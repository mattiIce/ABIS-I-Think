from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import CoilViewSet, SkidViewSet, ScrapSkidViewSet

router = DefaultRouter()
router.register(r'coils', CoilViewSet)
router.register(r'skids', SkidViewSet)
router.register(r'scrap-skids', ScrapSkidViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
