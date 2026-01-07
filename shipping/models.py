"""
Shipping and EDI models.
"""
from django.db import models
from core.models import TimeStampedModel
from customers.models import Customer, Carrier


class Shipment(TimeStampedModel):
    """Shipment/Bill of Lading."""
    STATUS_CHOICES = [
        ('OPEN', 'Open'),
        ('IN_PROGRESS', 'In Progress'),
        ('READY', 'Ready to Ship'),
        ('SHIPPED', 'Shipped'),
        ('DELIVERED', 'Delivered'),
    ]
    
    shipment_id = models.AutoField(primary_key=True)
    bol_number = models.CharField(max_length=50, unique=True, db_index=True)
    
    # Customer and carrier
    customer = models.ForeignKey(Customer, on_delete=models.PROTECT, related_name='shipments')
    carrier = models.ForeignKey(Carrier, on_delete=models.PROTECT, related_name='shipments')
    
    # Destination
    ship_to_name = models.CharField(max_length=200)
    ship_to_address1 = models.CharField(max_length=200)
    ship_to_address2 = models.CharField(max_length=200, blank=True)
    ship_to_city = models.CharField(max_length=100)
    ship_to_state = models.CharField(max_length=50)
    ship_to_zip = models.CharField(max_length=20)
    ship_to_country = models.CharField(max_length=50, default='USA')
    
    # Shipping details
    trailer_number = models.CharField(max_length=50, blank=True)
    seal_number = models.CharField(max_length=50, blank=True)
    pro_number = models.CharField(max_length=50, blank=True)
    
    # Dates
    ship_date = models.DateField(db_index=True)
    delivery_date = models.DateField(null=True, blank=True)
    
    # Totals
    total_weight = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    total_pieces = models.IntegerField(default=0)
    total_skids = models.IntegerField(default=0)
    
    # Status
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='OPEN')
    
    # EDI
    edi_856_sent = models.BooleanField(default=False)
    edi_856_sent_date = models.DateTimeField(null=True, blank=True)
    
    notes = models.TextField(blank=True)

    class Meta:
        db_table = 'shipments'
        ordering = ['-ship_date', 'bol_number']
        indexes = [
            models.Index(fields=['customer', 'status']),
            models.Index(fields=['ship_date']),
        ]

    def __str__(self):
        return f"BOL {self.bol_number} - {self.customer.company_name}"


class EDITransaction(TimeStampedModel):
    """EDI transaction log."""
    TRANSACTION_TYPES = [
        ('856', 'ASN - Advanced Ship Notice'),
        ('863', 'Report of Test Results'),
        ('870', 'Order Status Report'),
    ]
    
    STATUS_CHOICES = [
        ('PENDING', 'Pending'),
        ('SENT', 'Sent'),
        ('ACKNOWLEDGED', 'Acknowledged'),
        ('ERROR', 'Error'),
    ]
    
    edi_transaction_id = models.AutoField(primary_key=True)
    transaction_type = models.CharField(max_length=10, choices=TRANSACTION_TYPES)
    customer = models.ForeignKey(Customer, on_delete=models.PROTECT, related_name='edi_transactions')
    
    # References
    shipment = models.ForeignKey(
        Shipment, 
        on_delete=models.CASCADE, 
        null=True, 
        blank=True,
        related_name='edi_transactions'
    )
    
    # Transaction details
    control_number = models.CharField(max_length=50, unique=True)
    file_name = models.CharField(max_length=200, blank=True)
    file_path = models.CharField(max_length=500, blank=True)
    
    # Status
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='PENDING')
    sent_date = models.DateTimeField(null=True, blank=True)
    acknowledged_date = models.DateTimeField(null=True, blank=True)
    
    # Error handling
    error_message = models.TextField(blank=True)
    retry_count = models.IntegerField(default=0)
    
    # Content
    edi_content = models.TextField(blank=True)

    class Meta:
        db_table = 'edi_transactions'
        ordering = ['-created_at']
        indexes = [
            models.Index(fields=['customer', 'transaction_type']),
            models.Index(fields=['status']),
        ]

    def __str__(self):
        return f"{self.get_transaction_type_display()} - {self.control_number}"
