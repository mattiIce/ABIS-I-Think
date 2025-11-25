"""EDI admin configuration."""
from django.contrib import admin
from .models import (
    EDIPartner, EDITransaction, EDI856ShipNotice, EDI856Item,
    EDI863TestReport, EDI870OrderStatus, EDILog
)


@admin.register(EDIPartner)
class EDIPartnerAdmin(admin.ModelAdmin):
    """Admin for EDI trading partners."""
    
    list_display = ['company_name', 'edi_id', 'qualifier', 'supports_856', 'supports_863', 'supports_870', 'is_active']
    list_filter = ['is_active', 'supports_856', 'supports_863', 'supports_870']
    search_fields = ['company_name', 'edi_id', 'email']
    fieldsets = (
        ('Basic Information', {
            'fields': ('company_name', 'edi_id', 'qualifier', 'is_active')
        }),
        ('Transaction Support', {
            'fields': ('supports_856', 'supports_863', 'supports_870')
        }),
        ('Communication Settings', {
            'fields': ('email', 'ftp_host', 'ftp_username', 'ftp_path')
        }),
    )


@admin.register(EDITransaction)
class EDITransactionAdmin(admin.ModelAdmin):
    """Admin for EDI transactions."""
    
    list_display = ['control_number', 'transaction_type', 'direction', 'status', 'partner', 'created_at']
    list_filter = ['transaction_type', 'direction', 'status', 'created_at']
    search_fields = ['control_number', 'partner__company_name']
    readonly_fields = ['created_at', 'updated_at', 'processed_at']
    fieldsets = (
        ('Transaction Info', {
            'fields': ('transaction_type', 'direction', 'status', 'partner', 'control_number')
        }),
        ('Data', {
            'fields': ('raw_data', 'parsed_data'),
            'classes': ('collapse',)
        }),
        ('Processing', {
            'fields': ('error_message', 'processed_by', 'processed_at')
        }),
        ('Timestamps', {
            'fields': ('created_at', 'updated_at')
        }),
    )


class EDI856ItemInline(admin.TabularInline):
    """Inline for 856 items."""
    model = EDI856Item
    extra = 0
    fields = ['sequence', 'item_number', 'quantity', 'unit_of_measure', 'coil_number']


@admin.register(EDI856ShipNotice)
class EDI856ShipNoticeAdmin(admin.ModelAdmin):
    """Admin for 856 ship notices."""
    
    list_display = ['bol_number', 'shipment_id', 'shipment_date', 'carrier_name', 'sent_at']
    list_filter = ['shipment_date', 'sent_at']
    search_fields = ['bol_number', 'shipment_id', 'carrier_name']
    readonly_fields = ['sent_at', 'acknowledged_at']
    inlines = [EDI856ItemInline]


@admin.register(EDI863TestReport)
class EDI863TestReportAdmin(admin.ModelAdmin):
    """Admin for 863 test reports."""
    
    list_display = ['report_number', 'coil_number', 'heat_number', 'report_date', 'sent_at']
    list_filter = ['report_date', 'sent_at']
    search_fields = ['report_number', 'coil_number', 'heat_number']
    readonly_fields = ['sent_at']
    fieldsets = (
        ('Report Info', {
            'fields': ('transaction', 'coil', 'report_number', 'report_date')
        }),
        ('Identification', {
            'fields': ('heat_number', 'coil_number', 'alloy', 'temper')
        }),
        ('Physical Properties', {
            'fields': ('gauge', 'width', 'weight')
        }),
        ('Test Results', {
            'fields': ('chemical_composition', 'mechanical_properties'),
            'classes': ('collapse',)
        }),
        ('Status', {
            'fields': ('sent_at',)
        }),
    )


@admin.register(EDI870OrderStatus)
class EDI870OrderStatusAdmin(admin.ModelAdmin):
    """Admin for 870 order status reports."""
    
    list_display = ['report_number', 'job_number', 'order_status', 'report_date', 'sent_at']
    list_filter = ['order_status', 'report_date', 'sent_at']
    search_fields = ['report_number', 'job_number', 'customer_po']
    readonly_fields = ['sent_at']
    fieldsets = (
        ('Report Info', {
            'fields': ('transaction', 'job', 'report_number', 'report_date')
        }),
        ('Order Info', {
            'fields': ('customer_po', 'job_number', 'order_status')
        }),
        ('Quantities', {
            'fields': ('quantity_ordered', 'quantity_completed', 'quantity_shipped')
        }),
        ('Dates', {
            'fields': ('scheduled_ship_date', 'estimated_completion_date')
        }),
        ('Notes', {
            'fields': ('notes',)
        }),
        ('Status', {
            'fields': ('sent_at',)
        }),
    )


@admin.register(EDILog)
class EDILogAdmin(admin.ModelAdmin):
    """Admin for EDI logs."""
    
    list_display = ['level', 'message', 'transaction', 'user', 'created_at']
    list_filter = ['level', 'created_at']
    search_fields = ['message']
    readonly_fields = ['created_at']
    date_hierarchy = 'created_at'
