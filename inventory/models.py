"""
Inventory management models for coils and skids.
"""
from django.db import models
from decimal import Decimal
from core.models import TimeStampedModel, Alloy, Temper
from customers.models import Customer


class Coil(TimeStampedModel):
    """Master coil inventory record."""
    STATUS_CHOICES = [
        ('RECEIVED', 'Received'),
        ('AVAILABLE', 'Available for Processing'),
        ('IN_PROCESS', 'In Process'),
        ('PROCESSED', 'Processed'),
        ('ON_HOLD', 'On Hold'),
        ('REJECTED', 'Rejected'),
        ('SHIPPED', 'Shipped'),
    ]
    
    coil_id = models.AutoField(primary_key=True)
    
    # Coil identification
    original_coil_number = models.CharField(max_length=50, db_index=True)
    abc_coil_number = models.CharField(max_length=50, unique=True, db_index=True)
    supplier_coil_number = models.CharField(max_length=50, blank=True)
    
    # Customer and ownership
    customer = models.ForeignKey(Customer, on_delete=models.PROTECT, related_name='coils')
    supplier = models.ForeignKey(Customer, on_delete=models.PROTECT, related_name='supplied_coils', null=True, blank=True)
    
    # Material specifications
    alloy = models.ForeignKey(Alloy, on_delete=models.PROTECT)
    temper = models.ForeignKey(Temper, on_delete=models.PROTECT)
    gauge = models.DecimalField(max_digits=10, decimal_places=4, help_text="Thickness in inches")
    width = models.DecimalField(max_digits=10, decimal_places=3, help_text="Width in inches")
    
    # Weight and dimensions
    gross_weight = models.DecimalField(max_digits=12, decimal_places=2, help_text="Total weight in lbs")
    tare_weight = models.DecimalField(max_digits=12, decimal_places=2, default=Decimal('0'))
    net_weight = models.DecimalField(max_digits=12, decimal_places=2, help_text="Net weight in lbs")
    outside_diameter = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)
    inside_diameter = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)
    
    # Heat treatment
    heat_treatment = models.CharField(max_length=100, blank=True)
    lot_number = models.CharField(max_length=100, blank=True)
    
    # Receiving information
    received_date = models.DateField()
    receiving_number = models.CharField(max_length=50, blank=True)
    mill_certificate = models.CharField(max_length=100, blank=True)
    
    # Status and location
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='RECEIVED')
    location = models.CharField(max_length=100, blank=True, help_text="Physical warehouse location")
    
    # Quality flags
    qa_approved = models.BooleanField(default=False)
    qa_hold = models.BooleanField(default=False)
    qa_notes = models.TextField(blank=True)
    
    # EDI tracking
    has_863_report = models.BooleanField(default=False)
    edi_sent_date = models.DateTimeField(null=True, blank=True)
    
    # Notes
    notes = models.TextField(blank=True)

    class Meta:
        db_table = 'coils'
        ordering = ['-received_date', 'abc_coil_number']
        indexes = [
            models.Index(fields=['customer', 'status']),
            models.Index(fields=['received_date']),
            models.Index(fields=['abc_coil_number']),
        ]

    def __str__(self):
        return f"{self.abc_coil_number} - {self.alloy} {self.gauge}x{self.width}"

    def save(self, *args, **kwargs):
        # Calculate net weight if not set
        if not self.net_weight:
            self.net_weight = self.gross_weight - self.tare_weight
        super().save(*args, **kwargs)


class CoilHistory(TimeStampedModel):
    """Track coil status changes and movements."""
    history_id = models.AutoField(primary_key=True)
    coil = models.ForeignKey(Coil, on_delete=models.CASCADE, related_name='history')
    action = models.CharField(max_length=100)
    old_status = models.CharField(max_length=20, blank=True)
    new_status = models.CharField(max_length=20, blank=True)
    description = models.TextField()
    location = models.CharField(max_length=100, blank=True)

    class Meta:
        db_table = 'coil_history'
        ordering = ['-created_at']

    def __str__(self):
        return f"{self.coil.abc_coil_number} - {self.action} at {self.created_at}"


class Skid(TimeStampedModel):
    """Finished product skids/pallets."""
    STATUS_CHOICES = [
        ('IN_PROGRESS', 'In Progress'),
        ('COMPLETE', 'Complete'),
        ('QC_HOLD', 'QC Hold'),
        ('AVAILABLE', 'Available for Shipment'),
        ('ASSIGNED', 'Assigned to Shipment'),
        ('SHIPPED', 'Shipped'),
    ]
    
    skid_id = models.AutoField(primary_key=True)
    skid_number = models.CharField(max_length=50, unique=True, db_index=True)
    package_number = models.CharField(max_length=50, blank=True, db_index=True)
    
    # Customer and product
    customer = models.ForeignKey(Customer, on_delete=models.PROTECT, related_name='skids')
    
    # Weight and dimensions
    gross_weight = models.DecimalField(max_digits=12, decimal_places=2)
    tare_weight = models.DecimalField(max_digits=12, decimal_places=2, default=Decimal('0'))
    net_weight = models.DecimalField(max_digits=12, decimal_places=2)
    piece_count = models.IntegerField(default=0)
    
    # Dimensions
    length = models.DecimalField(max_digits=10, decimal_places=3, null=True, blank=True)
    width = models.DecimalField(max_digits=10, decimal_places=3, null=True, blank=True)
    height = models.DecimalField(max_digits=10, decimal_places=3, null=True, blank=True)
    
    # Status and location
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='IN_PROGRESS')
    location = models.CharField(max_length=100, blank=True)
    
    # Production information
    production_date = models.DateField()
    completion_date = models.DateField(null=True, blank=True)
    
    # Quality
    qa_approved = models.BooleanField(default=False)
    qa_inspector = models.CharField(max_length=100, blank=True)
    qa_date = models.DateField(null=True, blank=True)
    
    # Shipping
    shipment = models.ForeignKey(
        'shipping.Shipment', 
        on_delete=models.SET_NULL, 
        null=True, 
        blank=True,
        related_name='skids'
    )
    
    notes = models.TextField(blank=True)

    class Meta:
        db_table = 'skids'
        ordering = ['-production_date', 'skid_number']
        indexes = [
            models.Index(fields=['customer', 'status']),
            models.Index(fields=['production_date']),
        ]

    def __str__(self):
        return f"Skid {self.skid_number} - {self.piece_count} pcs"

    def save(self, *args, **kwargs):
        if not self.net_weight:
            self.net_weight = self.gross_weight - self.tare_weight
        super().save(*args, **kwargs)


class ScrapSkid(TimeStampedModel):
    """Scrap material skids."""
    STATUS_CHOICES = [
        ('IN_PROGRESS', 'In Progress'),
        ('COMPLETE', 'Complete'),
        ('AVAILABLE', 'Available for Sale'),
        ('ASSIGNED', 'Assigned to Shipment'),
        ('SHIPPED', 'Shipped'),
    ]
    
    SCRAP_TYPE_CHOICES = [
        ('EDGE_TRIM', 'Edge Trim'),
        ('SKELETON', 'Skeleton'),
        ('REJECTS', 'Rejects'),
        ('PROCESS_SCRAP', 'Process Scrap'),
        ('OTHER', 'Other'),
    ]
    
    scrap_skid_id = models.AutoField(primary_key=True)
    scrap_skid_number = models.CharField(max_length=50, unique=True, db_index=True)
    
    # Scrap information
    scrap_type = models.CharField(max_length=20, choices=SCRAP_TYPE_CHOICES)
    customer = models.ForeignKey(Customer, on_delete=models.PROTECT, related_name='scrap_skids')
    
    # Weight
    gross_weight = models.DecimalField(max_digits=12, decimal_places=2)
    tare_weight = models.DecimalField(max_digits=12, decimal_places=2, default=Decimal('0'))
    net_weight = models.DecimalField(max_digits=12, decimal_places=2)
    
    # Status
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='IN_PROGRESS')
    location = models.CharField(max_length=100, blank=True)
    
    # Date tracking
    production_date = models.DateField()
    
    # Shipping
    shipment = models.ForeignKey(
        'shipping.Shipment',
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='scrap_skids'
    )
    
    notes = models.TextField(blank=True)

    class Meta:
        db_table = 'scrap_skids'
        ordering = ['-production_date']

    def __str__(self):
        return f"Scrap {self.scrap_skid_number} - {self.get_scrap_type_display()}"

    def save(self, *args, **kwargs):
        if not self.net_weight:
            self.net_weight = self.gross_weight - self.tare_weight
        super().save(*args, **kwargs)
