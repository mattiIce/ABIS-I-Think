"""EDI processing models for ASC X12 transactions."""
from django.db import models
from django.contrib.auth.models import User


class EDIPartner(models.Model):
    """Trading partner configuration for EDI transactions."""
    
    QUALIFIER_CHOICES = [
        ('01', '01 - DUNS (Dun & Bradstreet)'),
        ('02', '02 - SCAC (Standard Carrier Alpha Code)'),
        ('ZZ', 'ZZ - Mutually Defined'),
    ]
    
    company_name = models.CharField(max_length=255)
    edi_id = models.CharField(max_length=50, unique=True, help_text="Trading partner EDI identifier")
    qualifier = models.CharField(max_length=2, choices=QUALIFIER_CHOICES, default='ZZ')
    
    # Transaction capabilities
    supports_856 = models.BooleanField(default=False, help_text="Ship Notice/Manifest")
    supports_863 = models.BooleanField(default=False, help_text="Material Test Report")
    supports_870 = models.BooleanField(default=False, help_text="Order Status Report")
    
    # Communication settings
    email = models.EmailField(blank=True, help_text="Email for EDI notifications")
    ftp_host = models.CharField(max_length=255, blank=True)
    ftp_username = models.CharField(max_length=100, blank=True)
    ftp_path = models.CharField(max_length=255, blank=True)
    
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    class Meta:
        db_table = 'edi_partner'
        ordering = ['company_name']
    
    def __str__(self):
        return f"{self.company_name} ({self.edi_id})"


class EDITransaction(models.Model):
    """Base model for all EDI transactions."""
    
    TRANSACTION_TYPES = [
        ('856', '856 - Ship Notice/Manifest'),
        ('863', '863 - Material Test Report'),
        ('870', '870 - Order Status Report'),
    ]
    
    DIRECTION_CHOICES = [
        ('INBOUND', 'Inbound'),
        ('OUTBOUND', 'Outbound'),
    ]
    
    STATUS_CHOICES = [
        ('PENDING', 'Pending'),
        ('PROCESSING', 'Processing'),
        ('SENT', 'Sent'),
        ('RECEIVED', 'Received'),
        ('ERROR', 'Error'),
        ('ACKNOWLEDGED', 'Acknowledged'),
    ]
    
    transaction_type = models.CharField(max_length=3, choices=TRANSACTION_TYPES)
    direction = models.CharField(max_length=10, choices=DIRECTION_CHOICES)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='PENDING')
    
    partner = models.ForeignKey(EDIPartner, on_delete=models.PROTECT, related_name='transactions')
    control_number = models.CharField(max_length=50, unique=True, help_text="ISA/GS control number")
    
    raw_data = models.TextField(help_text="Raw EDI X12 format data")
    parsed_data = models.JSONField(null=True, blank=True, help_text="Parsed EDI data as JSON")
    
    error_message = models.TextField(blank=True)
    processed_at = models.DateTimeField(null=True, blank=True)
    processed_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)
    
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    class Meta:
        db_table = 'edi_transaction'
        ordering = ['-created_at']
        indexes = [
            models.Index(fields=['transaction_type', 'status']),
            models.Index(fields=['control_number']),
        ]
    
    def __str__(self):
        return f"{self.transaction_type} - {self.control_number} ({self.status})"


class EDI856ShipNotice(models.Model):
    """EDI 856 - Ship Notice/Manifest transaction."""
    
    transaction = models.OneToOneField(
        EDITransaction, 
        on_delete=models.CASCADE, 
        related_name='ship_notice'
    )
    shipment = models.ForeignKey(
        'shipping.Shipment', 
        on_delete=models.CASCADE, 
        related_name='edi_notices'
    )
    
    # BSN Segment - Beginning Segment for Ship Notice
    shipment_id = models.CharField(max_length=50, help_text="Shipment identification number")
    shipment_date = models.DateField()
    shipment_time = models.TimeField(null=True, blank=True)
    
    # TD5 Segment - Carrier Details
    carrier_code = models.CharField(max_length=10, blank=True)
    carrier_name = models.CharField(max_length=255, blank=True)
    
    # REF Segment - Reference Identification
    bol_number = models.CharField(max_length=50, blank=True)
    pro_number = models.CharField(max_length=50, blank=True)
    
    # N1/N3/N4 Segments - Party Identification
    ship_from_name = models.CharField(max_length=255, blank=True)
    ship_from_address = models.TextField(blank=True)
    ship_to_name = models.CharField(max_length=255, blank=True)
    ship_to_address = models.TextField(blank=True)
    
    sent_at = models.DateTimeField(null=True, blank=True)
    acknowledged_at = models.DateTimeField(null=True, blank=True)
    
    class Meta:
        db_table = 'edi_856_ship_notice'
        ordering = ['-shipment_date']
    
    def __str__(self):
        return f"856 - {self.bol_number or self.shipment_id}"


class EDI856Item(models.Model):
    """Line items for EDI 856 Ship Notice."""
    
    ship_notice = models.ForeignKey(
        EDI856ShipNotice, 
        on_delete=models.CASCADE, 
        related_name='items'
    )
    
    # HL Segment - Hierarchical Level
    sequence = models.IntegerField()
    
    # LIN Segment - Item Identification
    item_number = models.CharField(max_length=100)
    item_description = models.CharField(max_length=255, blank=True)
    
    # SN1 Segment - Item Detail (Shipment)
    quantity = models.DecimalField(max_digits=12, decimal_places=2)
    unit_of_measure = models.CharField(max_length=10, default='LB')
    
    # PO4 Segment - Item Physical Details
    pack_count = models.IntegerField(default=1)
    weight = models.DecimalField(max_digits=12, decimal_places=2, null=True, blank=True)
    
    # MAN Segment - Marks and Numbers
    coil_number = models.CharField(max_length=50, blank=True)
    heat_number = models.CharField(max_length=50, blank=True)
    
    class Meta:
        db_table = 'edi_856_item'
        ordering = ['sequence']
    
    def __str__(self):
        return f"{self.item_number} - {self.quantity} {self.unit_of_measure}"


class EDI863TestReport(models.Model):
    """EDI 863 - Material Test Report transaction."""
    
    transaction = models.OneToOneField(
        EDITransaction, 
        on_delete=models.CASCADE, 
        related_name='test_report'
    )
    coil = models.ForeignKey(
        'inventory.Coil', 
        on_delete=models.CASCADE, 
        related_name='edi_test_reports',
        null=True,
        blank=True
    )
    
    # BGM Segment - Beginning of Message
    report_number = models.CharField(max_length=50, unique=True)
    report_date = models.DateField()
    
    # RFF Segment - Reference
    heat_number = models.CharField(max_length=50)
    coil_number = models.CharField(max_length=50)
    
    # IMD Segment - Item Description
    product_description = models.TextField(blank=True)
    alloy = models.CharField(max_length=50, blank=True)
    temper = models.CharField(max_length=50, blank=True)
    
    # MEA Segment - Measurements
    gauge = models.DecimalField(max_digits=10, decimal_places=4, null=True, blank=True)
    width = models.DecimalField(max_digits=10, decimal_places=4, null=True, blank=True)
    weight = models.DecimalField(max_digits=12, decimal_places=2, null=True, blank=True)
    
    # Chemical composition (stored as JSON for flexibility)
    chemical_composition = models.JSONField(default=dict)
    
    # Mechanical properties (stored as JSON for flexibility)
    mechanical_properties = models.JSONField(default=dict)
    
    sent_at = models.DateTimeField(null=True, blank=True)
    
    class Meta:
        db_table = 'edi_863_test_report'
        ordering = ['-report_date']
    
    def __str__(self):
        return f"863 - {self.report_number}"


class EDI870OrderStatus(models.Model):
    """EDI 870 - Order Status Report transaction."""
    
    transaction = models.OneToOneField(
        EDITransaction, 
        on_delete=models.CASCADE, 
        related_name='order_status'
    )
    job = models.ForeignKey(
        'production.Job', 
        on_delete=models.CASCADE, 
        related_name='edi_status_reports',
        null=True,
        blank=True
    )
    
    # OSR Segment - Order Status Report
    report_number = models.CharField(max_length=50, unique=True)
    report_date = models.DateField()
    
    # REF Segment - Reference Identification
    customer_po = models.CharField(max_length=50, blank=True)
    job_number = models.CharField(max_length=50)
    
    # OID Segment - Order Identification
    order_status = models.CharField(max_length=50)
    quantity_ordered = models.DecimalField(max_digits=12, decimal_places=2)
    quantity_completed = models.DecimalField(max_digits=12, decimal_places=2)
    quantity_shipped = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    
    # DTM Segment - Date/Time Reference
    scheduled_ship_date = models.DateField(null=True, blank=True)
    estimated_completion_date = models.DateField(null=True, blank=True)
    
    notes = models.TextField(blank=True)
    sent_at = models.DateTimeField(null=True, blank=True)
    
    class Meta:
        db_table = 'edi_870_order_status'
        ordering = ['-report_date']
    
    def __str__(self):
        return f"870 - {self.report_number}"


class EDILog(models.Model):
    """Audit log for EDI processing events."""
    
    LOG_LEVEL_CHOICES = [
        ('INFO', 'Info'),
        ('WARNING', 'Warning'),
        ('ERROR', 'Error'),
    ]
    
    transaction = models.ForeignKey(
        EDITransaction, 
        on_delete=models.CASCADE, 
        related_name='logs',
        null=True,
        blank=True
    )
    
    level = models.CharField(max_length=10, choices=LOG_LEVEL_CHOICES, default='INFO')
    message = models.TextField()
    details = models.JSONField(null=True, blank=True)
    
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    
    class Meta:
        db_table = 'edi_log'
        ordering = ['-created_at']
        indexes = [
            models.Index(fields=['level', '-created_at']),
        ]
    
    def __str__(self):
        return f"[{self.level}] {self.message[:50]}"
