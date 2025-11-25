"""
API views for customer models.
"""
from rest_framework import viewsets, permissions, filters, status
from rest_framework.decorators import action
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend
from .models import Customer, CustomerContact, Carrier
from .serializers import (
    CustomerSerializer, CustomerDetailSerializer,
    CustomerContactSerializer, CarrierSerializer
)


class CustomerViewSet(viewsets.ModelViewSet):
    """
    API endpoint for customers.
    
    list: Get all customers
    retrieve: Get specific customer with contacts
    create: Create new customer
    update: Update customer
    destroy: Delete customer
    """
    queryset = Customer.objects.select_related('parent').prefetch_related('contacts')
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['is_active', 'requires_edi', 'state', 'parent']
    search_fields = ['customer_code', 'company_name', 'city']
    ordering_fields = ['customer_code', 'company_name', 'created_at']
    ordering = ['company_name']
    
    def get_serializer_class(self):
        if self.action == 'retrieve':
            return CustomerDetailSerializer
        return CustomerSerializer
    
    @action(detail=True, methods=['get'])
    def contacts(self, request, pk=None):
        """Get all contacts for a customer."""
        customer = self.get_object()
        contacts = customer.contacts.all()
        serializer = CustomerContactSerializer(contacts, many=True)
        return Response(serializer.data)
    
    @action(detail=True, methods=['get'])
    def shipments(self, request, pk=None):
        """Get recent shipments for a customer."""
        customer = self.get_object()
        from shipping.serializers import ShipmentSerializer
        shipments = customer.shipments.order_by('-ship_date')[:10]
        serializer = ShipmentSerializer(shipments, many=True)
        return Response(serializer.data)


class CustomerContactViewSet(viewsets.ModelViewSet):
    """
    API endpoint for customer contacts.
    """
    queryset = CustomerContact.objects.select_related('customer')
    serializer_class = CustomerContactSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend, filters.SearchFilter]
    filterset_fields = ['customer', 'is_primary', 'receive_reports']
    search_fields = ['first_name', 'last_name', 'email']
    ordering = ['customer', 'last_name', 'first_name']


class CarrierViewSet(viewsets.ModelViewSet):
    """
    API endpoint for carriers.
    """
    queryset = Carrier.objects.all()
    serializer_class = CarrierSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend, filters.SearchFilter]
    filterset_fields = ['is_active']
    search_fields = ['carrier_code', 'company_name', 'scac_code']
    ordering = ['company_name']
