from rest_framework import viewsets, status
from rest_framework.decorators import action, api_view, permission_classes
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated, IsAdminUser
from django.db.models import Q, Count
from django.utils import timezone
from datetime import timedelta
from .models import Notification, NotificationTemplate, UserNotificationPreference
from .serializers import (
    NotificationSerializer, NotificationTemplateSerializer,
    UserNotificationPreferenceSerializer
)
from .services import NotificationService


class NotificationViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing notifications
    """
    serializer_class = NotificationSerializer
    permission_classes = [IsAuthenticated]
    
    def get_queryset(self):
        """Return notifications for the current user"""
        user = self.request.user
        queryset = Notification.objects.filter(user=user)
        
        # Filter by status
        status_filter = self.request.query_params.get('status', None)
        if status_filter:
            queryset = queryset.filter(status=status_filter)
        
        # Filter by notification type
        type_filter = self.request.query_params.get('type', None)
        if type_filter:
            queryset = queryset.filter(notification_type=type_filter)
        
        # Filter by date range
        days = self.request.query_params.get('days', None)
        if days:
            start_date = timezone.now() - timedelta(days=int(days))
            queryset = queryset.filter(created_at__gte=start_date)
        
        return queryset.select_related('user')
    
    @action(detail=True, methods=['post'])
    def mark_read(self, request, pk=None):
        """Mark a notification as read"""
        notification = self.get_object()
        notification.mark_as_read()
        return Response({'status': 'notification marked as read'})
    
    @action(detail=False, methods=['post'])
    def mark_all_read(self, request):
        """Mark all notifications as read for current user"""
        count = Notification.objects.filter(
            user=request.user,
            status='SENT'
        ).update(status='READ', read_at=timezone.now())
        return Response({'status': f'{count} notifications marked as read'})
    
    @action(detail=False, methods=['get'])
    def unread_count(self, request):
        """Get count of unread notifications"""
        count = Notification.objects.filter(
            user=request.user,
            status='SENT'
        ).count()
        return Response({'unread_count': count})
    
    @action(detail=False, methods=['get'])
    def summary(self, request):
        """Get notification summary statistics"""
        user = request.user
        
        total = Notification.objects.filter(user=user).count()
        unread = Notification.objects.filter(user=user, status='SENT').count()
        
        # Count by type
        by_type = Notification.objects.filter(user=user).values(
            'notification_type'
        ).annotate(count=Count('id'))
        
        # Recent notifications (last 7 days)
        seven_days_ago = timezone.now() - timedelta(days=7)
        recent = Notification.objects.filter(
            user=user,
            created_at__gte=seven_days_ago
        ).count()
        
        return Response({
            'total': total,
            'unread': unread,
            'recent': recent,
            'by_type': by_type
        })


class NotificationTemplateViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing notification templates (admin only)
    """
    queryset = NotificationTemplate.objects.all()
    serializer_class = NotificationTemplateSerializer
    permission_classes = [IsAdminUser]
    
    def get_queryset(self):
        queryset = NotificationTemplate.objects.all()
        
        # Filter by active status
        is_active = self.request.query_params.get('is_active', None)
        if is_active is not None:
            queryset = queryset.filter(is_active=is_active.lower() == 'true')
        
        return queryset


class UserNotificationPreferenceViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing user notification preferences
    """
    serializer_class = UserNotificationPreferenceSerializer
    permission_classes = [IsAuthenticated]
    
    def get_queryset(self):
        """Return preferences for the current user"""
        return UserNotificationPreference.objects.filter(user=self.request.user)
    
    @action(detail=False, methods=['get'])
    def my_preferences(self, request):
        """Get current user's notification preferences"""
        preferences, created = UserNotificationPreference.objects.get_or_create(
            user=request.user
        )
        serializer = self.get_serializer(preferences)
        return Response(serializer.data)
    
    @action(detail=False, methods=['post', 'put', 'patch'])
    def update_preferences(self, request):
        """Update current user's notification preferences"""
        preferences, created = UserNotificationPreference.objects.get_or_create(
            user=request.user
        )
        serializer = self.get_serializer(preferences, data=request.data, partial=True)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data)


@api_view(['POST'])
@permission_classes([IsAdminUser])
def send_test_notification(request):
    """
    Send a test notification to the current user
    """
    notification_type = request.data.get('notification_type', 'JOB_STARTED')
    
    context_data = {
        'job_id': 'TEST-001',
        'job_number': 'JOB-TEST-001',
        'customer_name': 'Test Customer',
        'status': 'In Progress',
        'quantity': 1000,
        'alloy': '3003',
    }
    
    notification = NotificationService.create_notification(
        request.user, notification_type, context_data
    )
    
    if notification:
        success = NotificationService.send_notification(notification)
        if success:
            return Response({
                'status': 'success',
                'message': 'Test notification sent',
                'notification_id': notification.id
            })
        else:
            return Response({
                'status': 'error',
                'message': 'Failed to send notification'
            }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    else:
        return Response({
            'status': 'error',
            'message': 'Failed to create notification'
        }, status=status.HTTP_400_BAD_REQUEST)
