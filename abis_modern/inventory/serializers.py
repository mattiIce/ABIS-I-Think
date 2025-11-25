"""
Serializers for inventory models.
"""
from rest_framework import serializers
from .models import Coil, CoilHistory, Skid, ScrapSkid


class CoilHistorySerializer(serializers.ModelSerializer):
    created_by_username = serializers.CharField(source='created_by.username', read_only=True)
    
    class Meta:
        model = CoilHistory
        fields = '__all__'
        read_only_fields = ['created_at', 'created_by', 'updated_at', 'updated_by']


class CoilSerializer(serializers.ModelSerializer):
    customer_name = serializers.CharField(source='customer.company_name', read_only=True)
    supplier_name = serializers.CharField(source='supplier.company_name', read_only=True)
    alloy_code = serializers.CharField(source='alloy.alloy_code', read_only=True)
    temper_code = serializers.CharField(source='temper.temper_code', read_only=True)
    
    class Meta:
        model = Coil
        fields = '__all__'
        read_only_fields = ['created_at', 'created_by', 'updated_at', 'updated_by']


class CoilDetailSerializer(CoilSerializer):
    """Extended serializer with history."""
    history = CoilHistorySerializer(many=True, read_only=True)


class SkidSerializer(serializers.ModelSerializer):
    customer_name = serializers.CharField(source='customer.company_name', read_only=True)
    shipment_bol = serializers.CharField(source='shipment.bol_number', read_only=True)
    
    class Meta:
        model = Skid
        fields = '__all__'
        read_only_fields = ['created_at', 'created_by', 'updated_at', 'updated_by']


class ScrapSkidSerializer(serializers.ModelSerializer):
    customer_name = serializers.CharField(source='customer.company_name', read_only=True)
    shipment_bol = serializers.CharField(source='shipment.bol_number', read_only=True)
    scrap_type_display = serializers.CharField(source='get_scrap_type_display', read_only=True)
    
    class Meta:
        model = ScrapSkid
        fields = '__all__'
        read_only_fields = ['created_at', 'created_by', 'updated_at', 'updated_by']
