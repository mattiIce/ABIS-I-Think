from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import CustomerViewSet, CustomerContactViewSet, CarrierViewSet

router = DefaultRouter()
router.register(r'customers', CustomerViewSet)
router.register(r'contacts', CustomerContactViewSet)
router.register(r'carriers', CarrierViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
