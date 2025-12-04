from django.urls import path, include
from rest_framework.routers import DefaultRouter
from . import views

router = DefaultRouter()

urlpatterns = [
    path('', include(router.urls)),
    
    # Certificate generation
    path('certificate/coil/<int:coil_id>/', views.generate_coil_certificate, name='coil-certificate'),
    
    # Label generation
    path('label/coil/<int:coil_id>/', views.generate_coil_label, name='coil-label'),
    path('label/skid/<int:skid_id>/', views.generate_skid_label, name='skid-label'),
    path('label/batch/', views.generate_batch_labels, name='batch-labels'),
    
    # Shipping documents
    path('bol/<int:bol_id>/', views.generate_bol, name='bol'),
    path('packing-list/<int:shipment_id>/', views.generate_packing_list, name='packing-list'),
    
    # Barcode/QR code generation
    path('barcode/', views.generate_barcode, name='barcode'),
    path('qrcode/', views.generate_qr_code, name='qrcode'),
]
