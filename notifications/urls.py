from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    NotificationViewSet, NotificationTemplateViewSet,
    UserNotificationPreferenceViewSet, send_test_notification
)

router = DefaultRouter()
router.register(r'notifications', NotificationViewSet, basename='notification')
router.register(r'templates', NotificationTemplateViewSet, basename='notification-template')
router.register(r'preferences', UserNotificationPreferenceViewSet, basename='notification-preference')

urlpatterns = [
    path('', include(router.urls)),
    path('test/', send_test_notification, name='send-test-notification'),
]
