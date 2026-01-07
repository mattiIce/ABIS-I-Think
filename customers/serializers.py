"""
Serializers for customer models.
"""
from rest_framework import serializers
from .models import Customer, CustomerContact, Carrier


class CustomerContactSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomerContact
        fields = '__all__'
        read_only_fields = ['created_at', 'created_by', 'updated_at', 'updated_by']


class CustomerSerializer(serializers.ModelSerializer):
    contacts = CustomerContactSerializer(many=True, read_only=True)
    parent_name = serializers.CharField(source='parent.company_name', read_only=True)
    contact_count = serializers.IntegerField(source='contacts.count', read_only=True)
    
    class Meta:
        model = Customer
        fields = '__all__'
        read_only_fields = ['created_at', 'created_by', 'updated_at', 'updated_by']


class CustomerDetailSerializer(CustomerSerializer):
    """Extended serializer with nested contacts."""
    contacts = CustomerContactSerializer(many=True, read_only=True)


class CarrierSerializer(serializers.ModelSerializer):
    class Meta:
        model = Carrier
        fields = '__all__'
        read_only_fields = ['created_at', 'created_by', 'updated_at', 'updated_by']
