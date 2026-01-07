"""
Analytics API views.
"""
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status
from django.utils import timezone
from datetime import timedelta

from core.analytics import (
    ProductionAnalytics,
    QualityAnalytics,
    InventoryAnalytics,
    CustomerAnalytics
)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def production_dashboard(request):
    """
    Get production analytics dashboard data.
    Query params: days (default: 30)
    """
    days = int(request.query_params.get('days', 30))
    
    try:
        data = {
            'trends': ProductionAnalytics.get_production_trends(days),
            'by_line': ProductionAnalytics.get_production_by_line(days),
            'efficiency': ProductionAnalytics.get_efficiency_metrics(days),
            'downtime': ProductionAnalytics.get_downtime_analysis(days),
            'period': {
                'days': days,
                'start_date': (timezone.now() - timedelta(days=days)).isoformat(),
                'end_date': timezone.now().isoformat()
            }
        }
        return Response(data)
    except Exception as e:
        return Response(
            {'error': str(e)},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def quality_dashboard(request):
    """
    Get quality analytics dashboard data.
    Query params: days (default: 30)
    """
    days = int(request.query_params.get('days', 30))
    
    try:
        data = {
            'trends': QualityAnalytics.get_defect_trends(days),
            'defect_distribution': QualityAnalytics.get_defect_distribution(),
            'metrics': QualityAnalytics.get_quality_metrics(days),
            'by_inspector': QualityAnalytics.get_qa_by_inspector(days),
            'period': {
                'days': days,
                'start_date': (timezone.now() - timedelta(days=days)).isoformat(),
                'end_date': timezone.now().isoformat()
            }
        }
        return Response(data)
    except Exception as e:
        return Response(
            {'error': str(e)},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def inventory_dashboard(request):
    """
    Get inventory analytics dashboard data.
    Query params: days (default: 90 for turnover analysis)
    """
    days = int(request.query_params.get('days', 90))
    
    try:
        data = {
            'levels': InventoryAnalytics.get_inventory_levels(),
            'turnover': InventoryAnalytics.get_turnover_analysis(days),
            'value': InventoryAnalytics.get_inventory_value(),
            'aging': InventoryAnalytics.get_aging_analysis(),
            'period': {
                'days': days,
                'start_date': (timezone.now() - timedelta(days=days)).isoformat(),
                'end_date': timezone.now().isoformat()
            }
        }
        return Response(data)
    except Exception as e:
        return Response(
            {'error': str(e)},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def customer_dashboard(request):
    """
    Get customer analytics dashboard data.
    Query params: days (default: 90), limit (default: 10)
    """
    days = int(request.query_params.get('days', 90))
    limit = int(request.query_params.get('limit', 10))
    
    try:
        data = {
            'top_customers': CustomerAnalytics.get_top_customers(days, limit),
            'order_trends': CustomerAnalytics.get_order_trends(days),
            'shipment_analysis': CustomerAnalytics.get_shipment_analysis(30),
            'distribution': CustomerAnalytics.get_customer_distribution(),
            'period': {
                'days': days,
                'start_date': (timezone.now() - timedelta(days=days)).isoformat(),
                'end_date': timezone.now().isoformat()
            }
        }
        return Response(data)
    except Exception as e:
        return Response(
            {'error': str(e)},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def overview_dashboard(request):
    """
    Get overview dashboard with key metrics from all areas.
    """
    try:
        data = {
            'production': ProductionAnalytics.get_efficiency_metrics(30),
            'quality': QualityAnalytics.get_quality_metrics(30),
            'inventory': InventoryAnalytics.get_inventory_value(),
            'shipments': CustomerAnalytics.get_shipment_analysis(30),
            'timestamp': timezone.now().isoformat()
        }
        return Response(data)
    except Exception as e:
        return Response(
            {'error': str(e)},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )
