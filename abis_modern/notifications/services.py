from django.core.mail import send_mail, EmailMultiAlternatives
from django.template import Template, Context
from django.conf import settings
from django.contrib.auth.models import User
from .models import Notification, NotificationTemplate, UserNotificationPreference
import logging

logger = logging.getLogger(__name__)


class NotificationService:
    """Service for creating and sending notifications"""
    
    @staticmethod
    def create_notification(user, notification_type, context_data):
        """
        Create a notification for a user
        
        Args:
            user: User object
            notification_type: Type of notification (e.g., 'JOB_STARTED')
            context_data: Dictionary with data for template rendering
        
        Returns:
            Notification object
        """
        try:
            # Get the template
            template = NotificationTemplate.objects.get(
                notification_type=notification_type,
                is_active=True
            )
        except NotificationTemplate.DoesNotExist:
            logger.warning(f"No active template found for {notification_type}")
            return None
        
        # Render subject and body
        subject = Template(template.subject).render(Context(context_data))
        message = Template(template.body_text).render(Context(context_data))
        html_message = Template(template.body_html).render(Context(context_data))
        
        # Create notification
        notification = Notification.objects.create(
            user=user,
            notification_type=notification_type,
            subject=subject,
            message=message,
            html_message=html_message,
            job_id=context_data.get('job_id'),
            shipment_id=context_data.get('shipment_id'),
            coil_id=context_data.get('coil_id'),
            customer_id=context_data.get('customer_id'),
        )
        
        return notification
    
    @staticmethod
    def send_notification(notification):
        """
        Send a notification via email if user preferences allow
        
        Args:
            notification: Notification object
        
        Returns:
            Boolean indicating success
        """
        try:
            # Get user preferences
            preferences, created = UserNotificationPreference.objects.get_or_create(
                user=notification.user
            )
            
            # Check if user wants to receive this notification via email
            if not preferences.should_send_email(notification.notification_type):
                logger.info(f"User {notification.user.username} has disabled email for {notification.notification_type}")
                notification.mark_as_sent()
                return True
            
            # Send email
            email = EmailMultiAlternatives(
                subject=notification.subject,
                body=notification.message,
                from_email=settings.DEFAULT_FROM_EMAIL,
                to=[notification.user.email]
            )
            
            if notification.html_message:
                email.attach_alternative(notification.html_message, "text/html")
            
            email.send()
            notification.mark_as_sent()
            logger.info(f"Notification sent to {notification.user.email}: {notification.subject}")
            return True
            
        except Exception as e:
            logger.error(f"Failed to send notification {notification.id}: {str(e)}")
            notification.mark_as_failed(e)
            return False
    
    @staticmethod
    def send_bulk_notification(notification_type, context_data, user_filter=None):
        """
        Send notification to multiple users
        
        Args:
            notification_type: Type of notification
            context_data: Dictionary with data for template rendering
            user_filter: Optional Q object to filter users
        
        Returns:
            Tuple of (success_count, failure_count)
        """
        users = User.objects.filter(is_active=True)
        if user_filter:
            users = users.filter(user_filter)
        
        success_count = 0
        failure_count = 0
        
        for user in users:
            notification = NotificationService.create_notification(
                user, notification_type, context_data
            )
            if notification:
                if NotificationService.send_notification(notification):
                    success_count += 1
                else:
                    failure_count += 1
        
        return success_count, failure_count
    
    @staticmethod
    def notify_job_event(job, event_type):
        """Send notification for job events"""
        context = {
            'job_id': job.job_id,
            'job_number': job.job_number,
            'customer_name': job.customer.name if job.customer else 'N/A',
            'status': job.get_status_display(),
            'quantity': job.quantity,
            'alloy': job.alloy,
        }
        
        # Notify relevant users (e.g., production managers, customer service)
        users = User.objects.filter(groups__name__in=['Production', 'Managers', 'CustomerService'])
        
        for user in users:
            notification = NotificationService.create_notification(user, event_type, context)
            if notification:
                NotificationService.send_notification(notification)
    
    @staticmethod
    def notify_shipment_event(shipment, event_type):
        """Send notification for shipment events"""
        context = {
            'shipment_id': shipment.shipment_id,
            'bol_number': shipment.bol_number,
            'customer_name': shipment.customer.name if shipment.customer else 'N/A',
            'carrier': shipment.carrier.name if shipment.carrier else 'N/A',
            'status': shipment.get_status_display(),
            'ship_date': shipment.ship_date.strftime('%Y-%m-%d') if shipment.ship_date else 'Not set',
        }
        
        # Notify relevant users
        users = User.objects.filter(groups__name__in=['Shipping', 'Managers', 'CustomerService'])
        
        for user in users:
            notification = NotificationService.create_notification(user, event_type, context)
            if notification:
                NotificationService.send_notification(notification)
    
    @staticmethod
    def notify_qa_event(qa_result, event_type):
        """Send notification for QA events"""
        context = {
            'test_id': qa_result.test_id,
            'coil_id': qa_result.coil.coil_id if qa_result.coil else 'N/A',
            'test_type': qa_result.get_test_type_display(),
            'result': 'PASSED' if qa_result.passed else 'FAILED',
            'inspector': qa_result.inspector,
            'test_date': qa_result.test_date.strftime('%Y-%m-%d'),
        }
        
        # Notify quality and production managers
        users = User.objects.filter(groups__name__in=['Quality', 'Production', 'Managers'])
        
        for user in users:
            notification = NotificationService.create_notification(user, event_type, context)
            if notification:
                NotificationService.send_notification(notification)
    
    @staticmethod
    def notify_inventory_event(coil, event_type):
        """Send notification for inventory events"""
        context = {
            'coil_id': coil.coil_id,
            'heat_number': coil.heat_number,
            'alloy': coil.alloy,
            'temper': coil.temper,
            'quantity': coil.quantity,
            'location': coil.location or 'Not specified',
        }
        
        # Notify inventory managers
        users = User.objects.filter(groups__name__in=['Inventory', 'Managers'])
        
        for user in users:
            notification = NotificationService.create_notification(user, event_type, context)
            if notification:
                NotificationService.send_notification(notification)
