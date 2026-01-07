from django.contrib import admin
from .models import Customer, CustomerContact, Carrier


@admin.register(Customer)
class CustomerAdmin(admin.ModelAdmin):
    list_display = ['customer_code', 'company_name', 'city', 'state', 'requires_edi', 'is_active']
    list_filter = ['is_active', 'requires_edi', 'state']
    search_fields = ['customer_code', 'company_name', 'city']
    fieldsets = (
        ('Basic Information', {
            'fields': ('customer_code', 'company_name', 'parent')
        }),
        ('Address', {
            'fields': ('address_line1', 'address_line2', 'city', 'state', 'zip_code', 'country')
        }),
        ('Contact', {
            'fields': ('phone', 'fax', 'email')
        }),
        ('Business Info', {
            'fields': ('duns_number', 'tax_id')
        }),
        ('EDI Configuration', {
            'fields': ('requires_edi', 'edi_qualifier', 'edi_identifier', 
                      'requires_856_asn', 'requires_863_report', 'requires_870_order')
        }),
        ('Requirements', {
            'fields': ('requires_cert_label', 'requires_cash_date')
        }),
        ('Status', {
            'fields': ('is_active', 'notes')
        }),
    )


@admin.register(CustomerContact)
class CustomerContactAdmin(admin.ModelAdmin):
    list_display = ['first_name', 'last_name', 'customer', 'email', 'is_primary']
    list_filter = ['is_primary', 'receive_reports']
    search_fields = ['first_name', 'last_name', 'email', 'customer__company_name']


@admin.register(Carrier)
class CarrierAdmin(admin.ModelAdmin):
    list_display = ['carrier_code', 'company_name', 'scac_code', 'is_active']
    list_filter = ['is_active']
    search_fields = ['carrier_code', 'company_name', 'scac_code']
