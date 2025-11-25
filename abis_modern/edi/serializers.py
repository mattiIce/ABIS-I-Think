"""EDI serializers."""
from rest_framework import serializers
from .models import (
    EDIPartner, EDITransaction, EDI856ShipNotice, EDI856Item,
    EDI863TestReport, EDI870OrderStatus, EDILog
)


class EDIPartnerSerializer(serializers.ModelSerializer):
    """Serializer for EDI trading partners."""
    
    class Meta:
        model = EDIPartner
        fields = [
            'id', 'company_name', 'edi_id', 'qualifier',
            'supports_856', 'supports_863', 'supports_870',
            'email', 'ftp_host', 'ftp_username', 'ftp_path',
            'is_active', 'created_at', 'updated_at'
        ]
        read_only_fields = ['id', 'created_at', 'updated_at']


class EDILogSerializer(serializers.ModelSerializer):
    """Serializer for EDI logs."""
    
    user_name = serializers.CharField(source='user.username', read_only=True)
    
    class Meta:
        model = EDILog
        fields = ['id', 'level', 'message', 'details', 'user_name', 'created_at']
        read_only_fields = ['id', 'created_at']


class EDITransactionSerializer(serializers.ModelSerializer):
    """Serializer for EDI transactions."""
    
    partner_name = serializers.CharField(source='partner.company_name', read_only=True)
    processed_by_name = serializers.CharField(source='processed_by.username', read_only=True)
    logs = EDILogSerializer(many=True, read_only=True)
    
    class Meta:
        model = EDITransaction
        fields = [
            'id', 'transaction_type', 'direction', 'status',
            'partner', 'partner_name', 'control_number',
            'raw_data', 'parsed_data', 'error_message',
            'processed_at', 'processed_by', 'processed_by_name',
            'created_at', 'updated_at', 'logs'
        ]
        read_only_fields = ['id', 'created_at', 'updated_at', 'processed_at']


class EDI856ItemSerializer(serializers.ModelSerializer):
    """Serializer for 856 ship notice items."""
    
    class Meta:
        model = EDI856Item
        fields = [
            'id', 'sequence', 'item_number', 'item_description',
            'quantity', 'unit_of_measure', 'pack_count', 'weight',
            'coil_number', 'heat_number'
        ]
        read_only_fields = ['id']


class EDI856ShipNoticeSerializer(serializers.ModelSerializer):
    """Serializer for EDI 856 ship notices."""
    
    transaction_details = EDITransactionSerializer(source='transaction', read_only=True)
    items = EDI856ItemSerializer(many=True, read_only=True)
    shipment_number = serializers.CharField(source='shipment.bol_number', read_only=True)
    
    class Meta:
        model = EDI856ShipNotice
        fields = [
            'id', 'transaction', 'transaction_details', 'shipment', 'shipment_number',
            'shipment_identifier', 'shipment_date', 'shipment_time',
            'carrier_code', 'carrier_name', 'bol_number', 'pro_number',
            'ship_from_name', 'ship_from_address',
            'ship_to_name', 'ship_to_address',
            'sent_at', 'acknowledged_at', 'items'
        ]
        read_only_fields = ['id', 'sent_at', 'acknowledged_at']


class EDI863TestReportSerializer(serializers.ModelSerializer):
    """Serializer for EDI 863 test reports."""
    
    transaction_details = EDITransactionSerializer(source='transaction', read_only=True)
    coil_number_display = serializers.CharField(source='coil.coil_number', read_only=True)
    
    class Meta:
        model = EDI863TestReport
        fields = [
            'id', 'transaction', 'transaction_details', 'coil', 'coil_number_display',
            'report_number', 'report_date', 'heat_number', 'coil_number',
            'product_description', 'alloy', 'temper',
            'gauge', 'width', 'weight',
            'chemical_composition', 'mechanical_properties',
            'sent_at'
        ]
        read_only_fields = ['id', 'sent_at']


class EDI870OrderStatusSerializer(serializers.ModelSerializer):
    """Serializer for EDI 870 order status reports."""
    
    transaction_details = EDITransactionSerializer(source='transaction', read_only=True)
    job_number_display = serializers.CharField(source='job.job_number', read_only=True)
    
    class Meta:
        model = EDI870OrderStatus
        fields = [
            'id', 'transaction', 'transaction_details', 'job', 'job_number_display',
            'report_number', 'report_date', 'customer_po', 'job_number_text',
            'order_status', 'quantity_ordered', 'quantity_completed', 'quantity_shipped',
            'scheduled_ship_date', 'estimated_completion_date',
            'notes', 'sent_at'
        ]
        read_only_fields = ['id', 'sent_at']


class EDIGenerateRequestSerializer(serializers.Serializer):
    """Serializer for EDI generation requests."""
    
    transaction_type = serializers.ChoiceField(choices=['856', '863', '870'])
    partner_id = serializers.IntegerField()
    reference_id = serializers.IntegerField(help_text="ID of shipment, coil, or job depending on transaction type")
    
    def validate_partner_id(self, value):
        """Validate partner exists and supports the transaction type."""
        try:
            partner = EDIPartner.objects.get(id=value, is_active=True)
        except EDIPartner.DoesNotExist:
            raise serializers.ValidationError("Invalid or inactive EDI partner")
        return value


class EDIParseRequestSerializer(serializers.Serializer):
    """Serializer for EDI parsing requests."""
    
    partner_id = serializers.IntegerField()
    edi_data = serializers.CharField(help_text="Raw X12 EDI data")
    
    def validate_edi_data(self, value):
        """Validate EDI data format."""
        if not value.strip().startswith('ISA'):
            raise serializers.ValidationError("Invalid EDI format - must start with ISA segment")
        return value
