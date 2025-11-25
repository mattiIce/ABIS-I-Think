from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    SystemLogViewSet, SystemOptionViewSet, LineViewSet,
    ShiftViewSet, AlloyViewSet, TemperViewSet
)
from .analytics_views import (
    production_dashboard, quality_dashboard, inventory_dashboard,
    customer_dashboard, overview_dashboard
)

router = DefaultRouter()
router.register(r'system-logs', SystemLogViewSet)
router.register(r'system-options', SystemOptionViewSet)
router.register(r'lines', LineViewSet)
router.register(r'shifts', ShiftViewSet)
router.register(r'alloys', AlloyViewSet)
router.register(r'tempers', TemperViewSet)

urlpatterns = [
    path('', include(router.urls)),
    # Analytics endpoints
    path('analytics/production/', production_dashboard, name='analytics-production'),
    path('analytics/quality/', quality_dashboard, name='analytics-quality'),
    path('analytics/inventory/', inventory_dashboard, name='analytics-inventory'),
    path('analytics/customer/', customer_dashboard, name='analytics-customer'),
    path('analytics/overview/', overview_dashboard, name='analytics-overview'),
    # Notifications
    path('notifications/', include('notifications.urls')),
]
