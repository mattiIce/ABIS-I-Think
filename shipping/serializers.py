"""
Serializers for shipping models.
"""
from rest_framework import serializers
from .models import Shipment, EDITransaction


class ShipmentSerializer(serializers.ModelSerializer):
    customer_name = serializers.CharField(source='customer.company_name', read_only=True)
    carrier_name = serializers.CharField(source='carrier.company_name', read_only=True)
    skid_count = serializers.IntegerField(source='skids.count', read_only=True)
    scrap_skid_count = serializers.IntegerField(source='scrap_skids.count', read_only=True)
    
    class Meta:
        model = Shipment
        fields = '__all__'
        read_only_fields = ['created_at', 'created_by', 'updated_at', 'updated_by']


class ShipmentDetailSerializer(ShipmentSerializer):
    """Extended serializer with skid details."""
    from inventory.serializers import SkidSerializer, ScrapSkidSerializer
    skids = SkidSerializer(many=True, read_only=True)
    scrap_skids = ScrapSkidSerializer(many=True, read_only=True)


class EDITransactionSerializer(serializers.ModelSerializer):
    customer_name = serializers.CharField(source='customer.company_name', read_only=True)
    shipment_bol = serializers.CharField(source='shipment.bol_number', read_only=True)
    transaction_type_display = serializers.CharField(source='get_transaction_type_display', read_only=True)
    
    class Meta:
        model = EDITransaction
        fields = '__all__'
        read_only_fields = ['created_at', 'created_by', 'updated_at', 'updated_by']
