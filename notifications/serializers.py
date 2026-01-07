from rest_framework import serializers
from .models import Notification, NotificationTemplate, UserNotificationPreference


class NotificationTemplateSerializer(serializers.ModelSerializer):
    notification_type_display = serializers.CharField(source='get_notification_type_display', read_only=True)
    
    class Meta:
        model = NotificationTemplate
        fields = [
            'id', 'name', 'notification_type', 'notification_type_display',
            'subject', 'body_text', 'body_html', 'is_active',
            'created_at', 'updated_at'
        ]
        read_only_fields = ['created_at', 'updated_at']


class NotificationSerializer(serializers.ModelSerializer):
    notification_type_display = serializers.CharField(source='get_notification_type_display', read_only=True)
    status_display = serializers.CharField(source='get_status_display', read_only=True)
    user_username = serializers.CharField(source='user.username', read_only=True)
    
    class Meta:
        model = Notification
        fields = [
            'id', 'user', 'user_username', 'notification_type', 'notification_type_display',
            'subject', 'message', 'html_message',
            'job_id', 'shipment_id', 'coil_id', 'customer_id',
            'status', 'status_display', 'sent_at', 'read_at', 'error_message',
            'created_at', 'updated_at'
        ]
        read_only_fields = ['created_at', 'updated_at', 'sent_at', 'read_at']


class UserNotificationPreferenceSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserNotificationPreference
        fields = [
            'id', 'user',
            'email_enabled', 'email_job_started', 'email_job_completed', 'email_job_on_hold',
            'email_shipment_created', 'email_shipment_shipped',
            'email_qa_failed', 'email_qa_passed',
            'email_inventory_low', 'email_inventory_received',
            'email_customer_order', 'email_maintenance_due', 'email_downtime_alert',
            'app_enabled', 'app_job_started', 'app_job_completed', 'app_job_on_hold',
            'app_shipment_created', 'app_shipment_shipped',
            'app_qa_failed', 'app_qa_passed',
            'app_inventory_low', 'app_inventory_received',
            'app_customer_order', 'app_maintenance_due', 'app_downtime_alert',
            'daily_digest', 'weekly_digest',
            'created_at', 'updated_at'
        ]
        read_only_fields = ['user', 'created_at', 'updated_at']
