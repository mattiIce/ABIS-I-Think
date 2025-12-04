"""EDI URL configuration."""
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    EDIPartnerViewSet, EDITransactionViewSet,
    EDI856ShipNoticeViewSet, EDI863TestReportViewSet,
    EDI870OrderStatusViewSet
)

router = DefaultRouter()
router.register(r'partners', EDIPartnerViewSet, basename='edi-partner')
router.register(r'transactions', EDITransactionViewSet, basename='edi-transaction')
router.register(r'856-ship-notices', EDI856ShipNoticeViewSet, basename='edi-856')
router.register(r'863-test-reports', EDI863TestReportViewSet, basename='edi-863')
router.register(r'870-order-status', EDI870OrderStatusViewSet, basename='edi-870')

urlpatterns = [
    path('', include(router.urls)),
]
