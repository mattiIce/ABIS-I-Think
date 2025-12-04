from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone


class NotificationTemplate(models.Model):
    """Templates for different types of notifications"""
    
    NOTIFICATION_TYPES = [
        ('JOB_STARTED', 'Job Started'),
        ('JOB_COMPLETED', 'Job Completed'),
        ('JOB_ON_HOLD', 'Job On Hold'),
        ('SHIPMENT_CREATED', 'Shipment Created'),
        ('SHIPMENT_SHIPPED', 'Shipment Shipped'),
        ('QA_FAILED', 'QA Test Failed'),
        ('QA_PASSED', 'QA Test Passed'),
        ('INVENTORY_LOW', 'Low Inventory Alert'),
        ('INVENTORY_RECEIVED', 'Inventory Received'),
        ('CUSTOMER_ORDER', 'New Customer Order'),
        ('MAINTENANCE_DUE', 'Maintenance Due'),
        ('DOWNTIME_ALERT', 'Production Downtime'),
    ]
    
    name = models.CharField(max_length=100, unique=True)
    notification_type = models.CharField(max_length=50, choices=NOTIFICATION_TYPES, unique=True)
    subject = models.CharField(max_length=255)
    body_text = models.TextField(help_text='Plain text version')
    body_html = models.TextField(help_text='HTML version with template variables like {job_number}, {customer_name}')
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    class Meta:
        db_table = 'notification_templates'
        ordering = ['name']
    
    def __str__(self):
        return f"{self.name} ({self.get_notification_type_display()})"


class Notification(models.Model):
    """Individual notification records"""
    
    STATUS_CHOICES = [
        ('PENDING', 'Pending'),
        ('SENT', 'Sent'),
        ('FAILED', 'Failed'),
        ('READ', 'Read'),
    ]
    
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='notifications')
    notification_type = models.CharField(max_length=50, choices=NotificationTemplate.NOTIFICATION_TYPES)
    subject = models.CharField(max_length=255)
    message = models.TextField()
    html_message = models.TextField(blank=True, null=True)
    
    # Related objects (optional, for linking back to source)
    job_id = models.CharField(max_length=50, blank=True, null=True)
    shipment_id = models.CharField(max_length=50, blank=True, null=True)
    coil_id = models.CharField(max_length=50, blank=True, null=True)
    customer_id = models.CharField(max_length=50, blank=True, null=True)
    
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='PENDING')
    sent_at = models.DateTimeField(blank=True, null=True)
    read_at = models.DateTimeField(blank=True, null=True)
    error_message = models.TextField(blank=True, null=True)
    
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    class Meta:
        db_table = 'notifications'
        ordering = ['-created_at']
        indexes = [
            models.Index(fields=['user', '-created_at']),
            models.Index(fields=['status']),
        ]
    
    def __str__(self):
        return f"{self.get_notification_type_display()} - {self.user.username} ({self.status})"
    
    def mark_as_sent(self):
        self.status = 'SENT'
        self.sent_at = timezone.now()
        self.save()
    
    def mark_as_failed(self, error):
        self.status = 'FAILED'
        self.error_message = str(error)
        self.save()
    
    def mark_as_read(self):
        if self.status == 'SENT':
            self.status = 'READ'
            self.read_at = timezone.now()
            self.save()


class UserNotificationPreference(models.Model):
    """User preferences for receiving notifications"""
    
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='notification_preferences')
    
    # Email preferences
    email_enabled = models.BooleanField(default=True)
    email_job_started = models.BooleanField(default=True)
    email_job_completed = models.BooleanField(default=True)
    email_job_on_hold = models.BooleanField(default=True)
    email_shipment_created = models.BooleanField(default=True)
    email_shipment_shipped = models.BooleanField(default=True)
    email_qa_failed = models.BooleanField(default=True)
    email_qa_passed = models.BooleanField(default=False)
    email_inventory_low = models.BooleanField(default=True)
    email_inventory_received = models.BooleanField(default=False)
    email_customer_order = models.BooleanField(default=True)
    email_maintenance_due = models.BooleanField(default=True)
    email_downtime_alert = models.BooleanField(default=True)
    
    # In-app notification preferences
    app_enabled = models.BooleanField(default=True)
    app_job_started = models.BooleanField(default=True)
    app_job_completed = models.BooleanField(default=True)
    app_job_on_hold = models.BooleanField(default=True)
    app_shipment_created = models.BooleanField(default=True)
    app_shipment_shipped = models.BooleanField(default=True)
    app_qa_failed = models.BooleanField(default=True)
    app_qa_passed = models.BooleanField(default=True)
    app_inventory_low = models.BooleanField(default=True)
    app_inventory_received = models.BooleanField(default=True)
    app_customer_order = models.BooleanField(default=True)
    app_maintenance_due = models.BooleanField(default=True)
    app_downtime_alert = models.BooleanField(default=True)
    
    # Digest settings
    daily_digest = models.BooleanField(default=False)
    weekly_digest = models.BooleanField(default=False)
    
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    class Meta:
        db_table = 'user_notification_preferences'
    
    def __str__(self):
        return f"Notification Preferences - {self.user.username}"
    
    def should_send_email(self, notification_type):
        """Check if user wants to receive email for this notification type"""
        if not self.email_enabled:
            return False
        
        field_map = {
            'JOB_STARTED': self.email_job_started,
            'JOB_COMPLETED': self.email_job_completed,
            'JOB_ON_HOLD': self.email_job_on_hold,
            'SHIPMENT_CREATED': self.email_shipment_created,
            'SHIPMENT_SHIPPED': self.email_shipment_shipped,
            'QA_FAILED': self.email_qa_failed,
            'QA_PASSED': self.email_qa_passed,
            'INVENTORY_LOW': self.email_inventory_low,
            'INVENTORY_RECEIVED': self.email_inventory_received,
            'CUSTOMER_ORDER': self.email_customer_order,
            'MAINTENANCE_DUE': self.email_maintenance_due,
            'DOWNTIME_ALERT': self.email_downtime_alert,
        }
        return field_map.get(notification_type, False)
    
    def should_send_app_notification(self, notification_type):
        """Check if user wants to receive in-app notification for this notification type"""
        if not self.app_enabled:
            return False
        
        field_map = {
            'JOB_STARTED': self.app_job_started,
            'JOB_COMPLETED': self.app_job_completed,
            'JOB_ON_HOLD': self.app_job_on_hold,
            'SHIPMENT_CREATED': self.app_shipment_created,
            'SHIPMENT_SHIPPED': self.app_shipment_shipped,
            'QA_FAILED': self.app_qa_failed,
            'QA_PASSED': self.app_qa_passed,
            'INVENTORY_LOW': self.app_inventory_low,
            'INVENTORY_RECEIVED': self.app_inventory_received,
            'CUSTOMER_ORDER': self.app_customer_order,
            'MAINTENANCE_DUE': self.app_maintenance_due,
            'DOWNTIME_ALERT': self.app_downtime_alert,
        }
        return field_map.get(notification_type, True)
