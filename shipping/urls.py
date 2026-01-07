from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import ShipmentViewSet, EDITransactionViewSet

router = DefaultRouter()
router.register(r'shipments', ShipmentViewSet)
router.register(r'edi-transactions', EDITransactionViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
