from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import JobViewSet, JobCoilViewSet, DailyProductionViewSet, DowntimeViewSet

router = DefaultRouter()
router.register(r'jobs', JobViewSet)
router.register(r'job-coils', JobCoilViewSet)
router.register(r'daily-production', DailyProductionViewSet)
router.register(r'downtime', DowntimeViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
