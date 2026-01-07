"""
API views for inventory models.
"""
from rest_framework import viewsets, permissions, filters, status
from rest_framework.decorators import action
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend
from django.db.models import Sum, Count, Q
from .models import Coil, CoilHistory, Skid, ScrapSkid
from .serializers import (
    CoilSerializer, CoilDetailSerializer, CoilHistorySerializer,
    SkidSerializer, ScrapSkidSerializer
)


class CoilViewSet(viewsets.ModelViewSet):
    """
    API endpoint for coils.
    
    Provides CRUD operations and additional actions:
    - history: Get coil movement history
    - statistics: Get inventory statistics
    """
    queryset = Coil.objects.select_related('customer', 'supplier', 'alloy', 'temper')
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['status', 'customer', 'alloy', 'temper', 'qa_approved', 'qa_hold']
    search_fields = ['abc_coil_number', 'original_coil_number', 'supplier_coil_number']
    ordering_fields = ['received_date', 'abc_coil_number', 'net_weight']
    ordering = ['-received_date']
    
    def get_serializer_class(self):
        if self.action == 'retrieve':
            return CoilDetailSerializer
        return CoilSerializer
    
    def perform_create(self, serializer):
        coil = serializer.save(created_by=self.request.user)
        # Create history entry
        CoilHistory.objects.create(
            coil=coil,
            action='CREATED',
            new_status=coil.status,
            description=f'Coil created by {self.request.user.username}',
            created_by=self.request.user
        )
    
    def perform_update(self, serializer):
        old_status = serializer.instance.status
        coil = serializer.save(updated_by=self.request.user)
        # Create history entry if status changed
        if old_status != coil.status:
            CoilHistory.objects.create(
                coil=coil,
                action='STATUS_CHANGE',
                old_status=old_status,
                new_status=coil.status,
                description=f'Status changed from {old_status} to {coil.status}',
                created_by=self.request.user
            )
    
    @action(detail=True, methods=['get'])
    def history(self, request, pk=None):
        """Get complete history for a coil."""
        coil = self.get_object()
        history = coil.history.order_by('-created_at')
        serializer = CoilHistorySerializer(history, many=True)
        return Response(serializer.data)
    
    @action(detail=False, methods=['get'])
    def statistics(self, request):
        """Get coil inventory statistics."""
        stats = Coil.objects.aggregate(
            total_count=Count('coil_id'),
            total_weight=Sum('net_weight'),
            available_count=Count('coil_id', filter=Q(status='AVAILABLE')),
            in_process_count=Count('coil_id', filter=Q(status='IN_PROCESS')),
        )
        return Response(stats)
    
    @action(detail=True, methods=['post'])
    def approve_qa(self, request, pk=None):
        """Approve coil for quality."""
        coil = self.get_object()
        coil.qa_approved = True
        coil.qa_hold = False
        coil.save()
        
        CoilHistory.objects.create(
            coil=coil,
            action='QA_APPROVED',
            description=f'QA approved by {request.user.username}',
            created_by=request.user
        )
        
        serializer = self.get_serializer(coil)
        return Response(serializer.data)


class SkidViewSet(viewsets.ModelViewSet):
    """
    API endpoint for finished product skids.
    """
    queryset = Skid.objects.select_related('customer', 'shipment')
    serializer_class = SkidSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['status', 'customer', 'qa_approved', 'shipment']
    search_fields = ['skid_number', 'package_number']
    ordering_fields = ['production_date', 'skid_number', 'net_weight']
    ordering = ['-production_date']
    
    @action(detail=False, methods=['get'])
    def available(self, request):
        """Get skids available for shipment."""
        skids = self.queryset.filter(status='AVAILABLE', qa_approved=True, shipment__isnull=True)
        page = self.paginate_queryset(skids)
        serializer = self.get_serializer(page, many=True)
        return self.get_paginated_response(serializer.data)
    
    @action(detail=False, methods=['get'])
    def statistics(self, request):
        """Get skid inventory statistics."""
        stats = Skid.objects.aggregate(
            total_count=Count('skid_id'),
            total_weight=Sum('net_weight'),
            total_pieces=Sum('piece_count'),
            available_count=Count('skid_id', filter=Q(status='AVAILABLE')),
        )
        return Response(stats)


class ScrapSkidViewSet(viewsets.ModelViewSet):
    """
    API endpoint for scrap skids.
    """
    queryset = ScrapSkid.objects.select_related('customer', 'shipment')
    serializer_class = ScrapSkidSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['status', 'customer', 'scrap_type', 'shipment']
    search_fields = ['scrap_skid_number']
    ordering_fields = ['production_date', 'net_weight']
    ordering = ['-production_date']
    
    @action(detail=False, methods=['get'])
    def by_type(self, request):
        """Get scrap summary by type."""
        from django.db.models import Sum, Count
        summary = ScrapSkid.objects.values('scrap_type').annotate(
            count=Count('scrap_skid_id'),
            total_weight=Sum('net_weight')
        ).order_by('scrap_type')
        return Response(summary)
