from django.contrib import admin
from .models import Notification, NotificationTemplate, UserNotificationPreference


@admin.register(NotificationTemplate)
class NotificationTemplateAdmin(admin.ModelAdmin):
    list_display = ['name', 'notification_type', 'is_active', 'created_at']
    list_filter = ['notification_type', 'is_active']
    search_fields = ['name', 'subject']
    ordering = ['name']


@admin.register(Notification)
class NotificationAdmin(admin.ModelAdmin):
    list_display = ['user', 'notification_type', 'subject', 'status', 'created_at', 'sent_at']
    list_filter = ['status', 'notification_type', 'created_at']
    search_fields = ['user__username', 'subject', 'job_id', 'shipment_id']
    readonly_fields = ['created_at', 'updated_at', 'sent_at', 'read_at']
    ordering = ['-created_at']
    
    fieldsets = (
        ('Basic Information', {
            'fields': ('user', 'notification_type', 'status')
        }),
        ('Content', {
            'fields': ('subject', 'message', 'html_message')
        }),
        ('Related Objects', {
            'fields': ('job_id', 'shipment_id', 'coil_id', 'customer_id')
        }),
        ('Status', {
            'fields': ('sent_at', 'read_at', 'error_message')
        }),
        ('Timestamps', {
            'fields': ('created_at', 'updated_at')
        }),
    )


@admin.register(UserNotificationPreference)
class UserNotificationPreferenceAdmin(admin.ModelAdmin):
    list_display = ['user', 'email_enabled', 'app_enabled', 'daily_digest', 'weekly_digest']
    list_filter = ['email_enabled', 'app_enabled', 'daily_digest', 'weekly_digest']
    search_fields = ['user__username', 'user__email']
    
    fieldsets = (
        ('User', {
            'fields': ('user',)
        }),
        ('Email Preferences', {
            'fields': (
                'email_enabled',
                'email_job_started', 'email_job_completed', 'email_job_on_hold',
                'email_shipment_created', 'email_shipment_shipped',
                'email_qa_failed', 'email_qa_passed',
                'email_inventory_low', 'email_inventory_received',
                'email_customer_order', 'email_maintenance_due', 'email_downtime_alert'
            )
        }),
        ('In-App Preferences', {
            'fields': (
                'app_enabled',
                'app_job_started', 'app_job_completed', 'app_job_on_hold',
                'app_shipment_created', 'app_shipment_shipped',
                'app_qa_failed', 'app_qa_passed',
                'app_inventory_low', 'app_inventory_received',
                'app_customer_order', 'app_maintenance_due', 'app_downtime_alert'
            )
        }),
        ('Digest Settings', {
            'fields': ('daily_digest', 'weekly_digest')
        }),
    )
