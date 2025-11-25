from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    SystemLogViewSet, SystemOptionViewSet, LineViewSet,
    ShiftViewSet, AlloyViewSet, TemperViewSet
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
]
