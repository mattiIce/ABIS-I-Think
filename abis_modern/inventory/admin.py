from django.contrib import admin
from .models import Coil, CoilHistory, Skid, ScrapSkid


@admin.register(Coil)
class CoilAdmin(admin.ModelAdmin):
    list_display = ['abc_coil_number', 'customer', 'alloy', 'gauge', 'width', 
                    'net_weight', 'status', 'received_date']
    list_filter = ['status', 'customer', 'alloy', 'qa_approved', 'received_date']
    search_fields = ['abc_coil_number', 'original_coil_number', 'supplier_coil_number']
    readonly_fields = ['created_at', 'updated_at']
    
    fieldsets = (
        ('Identification', {
            'fields': ('original_coil_number', 'abc_coil_number', 'supplier_coil_number')
        }),
        ('Customer & Supplier', {
            'fields': ('customer', 'supplier')
        }),
        ('Material Specifications', {
            'fields': ('alloy', 'temper', 'gauge', 'width')
        }),
        ('Weight & Dimensions', {
            'fields': ('gross_weight', 'tare_weight', 'net_weight', 
                      'outside_diameter', 'inside_diameter')
        }),
        ('Heat Treatment', {
            'fields': ('heat_treatment', 'lot_number')
        }),
        ('Receiving', {
            'fields': ('received_date', 'receiving_number', 'mill_certificate')
        }),
        ('Status & Location', {
            'fields': ('status', 'location')
        }),
        ('Quality Control', {
            'fields': ('qa_approved', 'qa_hold', 'qa_notes')
        }),
        ('EDI', {
            'fields': ('has_863_report', 'edi_sent_date')
        }),
        ('Notes', {
            'fields': ('notes',)
        }),
    )


@admin.register(CoilHistory)
class CoilHistoryAdmin(admin.ModelAdmin):
    list_display = ['coil', 'action', 'old_status', 'new_status', 'created_at']
    list_filter = ['action', 'created_at']
    search_fields = ['coil__abc_coil_number', 'description']
    readonly_fields = ['created_at']


@admin.register(Skid)
class SkidAdmin(admin.ModelAdmin):
    list_display = ['skid_number', 'customer', 'piece_count', 'net_weight', 
                    'status', 'production_date']
    list_filter = ['status', 'customer', 'qa_approved', 'production_date']
    search_fields = ['skid_number', 'package_number']
    
    fieldsets = (
        ('Identification', {
            'fields': ('skid_number', 'package_number')
        }),
        ('Customer', {
            'fields': ('customer',)
        }),
        ('Weight & Dimensions', {
            'fields': ('gross_weight', 'tare_weight', 'net_weight', 'piece_count',
                      'length', 'width', 'height')
        }),
        ('Status & Location', {
            'fields': ('status', 'location')
        }),
        ('Production', {
            'fields': ('production_date', 'completion_date')
        }),
        ('Quality Control', {
            'fields': ('qa_approved', 'qa_inspector', 'qa_date')
        }),
        ('Shipping', {
            'fields': ('shipment',)
        }),
        ('Notes', {
            'fields': ('notes',)
        }),
    )


@admin.register(ScrapSkid)
class ScrapSkidAdmin(admin.ModelAdmin):
    list_display = ['scrap_skid_number', 'scrap_type', 'customer', 'net_weight', 
                    'status', 'production_date']
    list_filter = ['status', 'scrap_type', 'customer', 'production_date']
    search_fields = ['scrap_skid_number']
