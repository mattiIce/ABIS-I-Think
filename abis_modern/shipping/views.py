"""
API views for shipping models.
"""
from rest_framework import viewsets, permissions, filters, status
from rest_framework.decorators import action
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend
from django.db.models import Sum, Count, Q
from django.db import models
from .models import Shipment, EDITransaction
from .serializers import (
    ShipmentSerializer, ShipmentDetailSerializer,
    EDITransactionSerializer
)


class ShipmentViewSet(viewsets.ModelViewSet):
    """
    API endpoint for shipments/BOLs.
    """
    queryset = Shipment.objects.select_related('customer', 'carrier').prefetch_related('skids', 'scrap_skids')
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['status', 'customer', 'carrier', 'ship_date']
    search_fields = ['bol_number', 'trailer_number', 'pro_number']
    ordering_fields = ['ship_date', 'bol_number']
    ordering = ['-ship_date']
    
    def get_serializer_class(self):
        if self.action == 'retrieve':
            return ShipmentDetailSerializer
        return ShipmentSerializer
    
    @action(detail=True, methods=['post'])
    def ship(self, request, pk=None):
        """Mark shipment as shipped."""
        shipment = self.get_object()
        shipment.status = 'SHIPPED'
        shipment.save()
        
        # Update skid statuses
        shipment.skids.update(status='SHIPPED')
        shipment.scrap_skids.update(status='SHIPPED')
        
        serializer = self.get_serializer(shipment)
        return Response(serializer.data)
    
    @action(detail=True, methods=['post'])
    def add_skid(self, request, pk=None):
        """Add a skid to shipment."""
        from inventory.models import Skid
        shipment = self.get_object()
        skid_id = request.data.get('skid_id')
        
        try:
            skid = Skid.objects.get(skid_id=skid_id)
            skid.shipment = shipment
            skid.status = 'ASSIGNED'
            skid.save()
            
            # Update shipment totals
            shipment.total_weight += skid.net_weight
            shipment.total_pieces += skid.piece_count
            shipment.total_skids += 1
            shipment.save()
            
            serializer = self.get_serializer(shipment)
            return Response(serializer.data)
        except Skid.DoesNotExist:
            return Response(
                {'error': 'Skid not found'},
                status=status.HTTP_404_NOT_FOUND
            )
    
    @action(detail=True, methods=['post'])
    def send_edi(self, request, pk=None):
        """Send EDI 856 ASN for shipment."""
        shipment = self.get_object()
        
        if not shipment.customer.requires_856_asn:
            return Response(
                {'error': 'Customer does not require EDI 856'},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        # Create EDI transaction (actual sending would be done by Celery task)
        edi_transaction = EDITransaction.objects.create(
            transaction_type='856',
            customer=shipment.customer,
            shipment=shipment,
            control_number=f'856-{shipment.bol_number}',
            status='PENDING',
            created_by=request.user
        )
        
        serializer = EDITransactionSerializer(edi_transaction)
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    
    @action(detail=False, methods=['get'])
    def open(self, request):
        """Get open shipments."""
        shipments = self.queryset.filter(status='OPEN')
        page = self.paginate_queryset(shipments)
        serializer = self.get_serializer(page, many=True)
        return self.get_paginated_response(serializer.data)
    
    @action(detail=False, methods=['get'])
    def statistics(self, request):
        """Get shipment statistics."""
        stats = self.queryset.aggregate(
            total_count=Count('shipment_id'),
            total_weight=Sum('total_weight'),
            total_skids=Sum('total_skids'),
            open_count=Count('shipment_id', filter=Q(status='OPEN')),
            shipped_count=Count('shipment_id', filter=Q(status='SHIPPED')),
        )
        return Response(stats)


class EDITransactionViewSet(viewsets.ModelViewSet):
    """
    API endpoint for EDI transactions.
    """
    queryset = EDITransaction.objects.select_related('customer', 'shipment')
    serializer_class = EDITransactionSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['transaction_type', 'customer', 'status', 'shipment']
    search_fields = ['control_number', 'file_name']
    ordering_fields = ['created_at', 'sent_date']
    ordering = ['-created_at']
    
    @action(detail=False, methods=['get'])
    def pending(self, request):
        """Get pending EDI transactions."""
        transactions = self.queryset.filter(status='PENDING')
        serializer = self.get_serializer(transactions, many=True)
        return Response(serializer.data)
    
    @action(detail=False, methods=['get'])
    def errors(self, request):
        """Get failed EDI transactions."""
        transactions = self.queryset.filter(status='ERROR')
        serializer = self.get_serializer(transactions, many=True)
        return Response(serializer.data)
    
    @action(detail=True, methods=['post'])
    def retry(self, request, pk=None):
        """Retry failed EDI transaction."""
        transaction = self.get_object()
        transaction.status = 'PENDING'
        transaction.retry_count += 1
        transaction.error_message = ''
        transaction.save()
        
        serializer = self.get_serializer(transaction)
        return Response(serializer.data)
