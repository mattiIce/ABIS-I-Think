"""
Customer management models.
"""
from django.db import models
from core.models import TimeStampedModel


class Customer(TimeStampedModel):
    """Customer master data."""
    customer_id = models.AutoField(primary_key=True)
    customer_code = models.CharField(max_length=50, unique=True)
    company_name = models.CharField(max_length=200)
    parent = models.ForeignKey(
        'self', 
        on_delete=models.SET_NULL, 
        null=True, 
        blank=True,
        related_name='subsidiaries'
    )
    
    # Address information
    address_line1 = models.CharField(max_length=200)
    address_line2 = models.CharField(max_length=200, blank=True)
    city = models.CharField(max_length=100)
    state = models.CharField(max_length=50)
    zip_code = models.CharField(max_length=20)
    country = models.CharField(max_length=50, default='USA')
    
    # Contact information
    phone = models.CharField(max_length=50, blank=True)
    fax = models.CharField(max_length=50, blank=True)
    email = models.EmailField(blank=True)
    
    # Business information
    duns_number = models.CharField(max_length=20, blank=True)
    tax_id = models.CharField(max_length=50, blank=True)
    
    # EDI configuration
    requires_edi = models.BooleanField(default=False)
    edi_qualifier = models.CharField(max_length=10, blank=True)
    edi_identifier = models.CharField(max_length=50, blank=True)
    requires_856_asn = models.BooleanField(default=False)
    requires_863_report = models.BooleanField(default=False)
    requires_870_order = models.BooleanField(default=False)
    
    # Certification requirements
    requires_cert_label = models.BooleanField(default=False)
    requires_cash_date = models.BooleanField(default=False)
    
    # Status
    is_active = models.BooleanField(default=True)
    notes = models.TextField(blank=True)

    class Meta:
        db_table = 'customers'
        ordering = ['company_name']

    def __str__(self):
        return f"{self.customer_code} - {self.company_name}"


class CustomerContact(TimeStampedModel):
    """Customer contact persons."""
    contact_id = models.AutoField(primary_key=True)
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE, related_name='contacts')
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    title = models.CharField(max_length=100, blank=True)
    email = models.EmailField()
    phone = models.CharField(max_length=50, blank=True)
    mobile = models.CharField(max_length=50, blank=True)
    is_primary = models.BooleanField(default=False)
    receive_reports = models.BooleanField(default=False)

    class Meta:
        db_table = 'customer_contacts'
        ordering = ['customer', 'last_name', 'first_name']

    def __str__(self):
        return f"{self.first_name} {self.last_name} ({self.customer.company_name})"


class Carrier(TimeStampedModel):
    """Shipping carriers."""
    carrier_id = models.AutoField(primary_key=True)
    carrier_code = models.CharField(max_length=50, unique=True)
    company_name = models.CharField(max_length=200)
    scac_code = models.CharField(max_length=10, blank=True, help_text="Standard Carrier Alpha Code")
    
    address_line1 = models.CharField(max_length=200, blank=True)
    city = models.CharField(max_length=100, blank=True)
    state = models.CharField(max_length=50, blank=True)
    zip_code = models.CharField(max_length=20, blank=True)
    
    phone = models.CharField(max_length=50, blank=True)
    email = models.EmailField(blank=True)
    
    is_active = models.BooleanField(default=True)
    notes = models.TextField(blank=True)

    class Meta:
        db_table = 'carriers'
        ordering = ['company_name']

    def __str__(self):
        return f"{self.carrier_code} - {self.company_name}"
