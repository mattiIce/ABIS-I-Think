"""
URL configuration for ABIS Modern project.
"""
from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static
from django.http import JsonResponse
from drf_spectacular.views import SpectacularAPIView, SpectacularSwaggerView
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response


def health_check(request):
    """Health check endpoint for monitoring and Docker health checks."""
    return JsonResponse({'status': 'healthy', 'service': 'abis-modern'})


def api_root(request):
    """Root API endpoint with links to all services."""
    return JsonResponse({
        'message': 'ABIS Modern API',
        'version': '1.0',
        'endpoints': {
            'admin': '/admin/',
            'api_docs': '/api/docs/',
            'api_schema': '/api/schema/',
            'health': '/api/health/',
            'authentication': {
                'token': '/api/auth/token/',
                'refresh': '/api/auth/token/refresh/',
                'user': '/api/auth/user/',
            },
            'resources': {
                'core': '/api/core/',
                'inventory': '/api/inventory/',
                'production': '/api/production/',
                'shipping': '/api/shipping/',
                'quality': '/api/quality/',
                'customers': '/api/customers/',
                'maintenance': '/api/maintenance/',
                'reports': '/api/reports/',
                'edi': '/api/edi/',
                'notifications': '/api/notifications/',
            }
        },
        'frontend': 'http://localhost:3000'
    })


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def current_user(request):
    """Get current authenticated user information."""
    user = request.user
    return Response({
        'id': user.id,
        'username': user.username,
        'email': user.email,
        'first_name': user.first_name,
        'last_name': user.last_name,
    })


urlpatterns = [
    # Root API info
    path('', api_root, name='api_root'),
    
    # Admin
    path('admin/', admin.site.urls),
    
    # Health check
    path('api/health/', health_check, name='health_check'),
    
    # API Documentation
    path('api/schema/', SpectacularAPIView.as_view(), name='schema'),
    path('api/docs/', SpectacularSwaggerView.as_view(url_name='schema'), name='swagger-ui'),
    
    # Authentication
    path('api/auth/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/auth/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('api/auth/user/', current_user, name='current_user'),
    
    # ABIS API endpoints
    path('api/core/', include('core.urls')),
    path('api/inventory/', include('inventory.urls')),
    path('api/production/', include('production.urls')),
    path('api/shipping/', include('shipping.urls')),
    path('api/quality/', include('quality.urls')),
    path('api/customers/', include('customers.urls')),
    path('api/maintenance/', include('maintenance.urls')),
    path('api/reports/', include('reports.urls')),
    path('api/edi/', include('edi.urls')),
    path('api/notifications/', include('notifications.urls')),
]

# Serve media files in development
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)

# Admin site customization
admin.site.site_header = "ABIS Modern Administration"
admin.site.site_title = "ABIS Admin"
admin.site.index_title = "Aluminum Business Information System"
