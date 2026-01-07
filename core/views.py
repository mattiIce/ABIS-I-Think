"""
API views for core models.
"""
from rest_framework import viewsets, permissions, filters
from django_filters.rest_framework import DjangoFilterBackend
from .models import SystemLog, SystemOption, Line, Shift, Alloy, Temper
from .serializers import (
    SystemLogSerializer, SystemOptionSerializer, LineSerializer,
    ShiftSerializer, AlloySerializer, TemperSerializer
)


class SystemLogViewSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint for system logs (read-only).
    """
    queryset = SystemLog.objects.all()
    serializer_class = SystemLogSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['user', 'action', 'table_name']
    search_fields = ['action', 'description']
    ordering_fields = ['created_at']
    ordering = ['-created_at']


class SystemOptionViewSet(viewsets.ModelViewSet):
    """
    API endpoint for system options.
    """
    queryset = SystemOption.objects.all()
    serializer_class = SystemOptionSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend, filters.SearchFilter]
    filterset_fields = ['category']
    search_fields = ['key', 'description']
    ordering = ['category', 'key']


class LineViewSet(viewsets.ModelViewSet):
    """
    API endpoint for production lines.
    """
    queryset = Line.objects.all()
    serializer_class = LineSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend, filters.SearchFilter]
    filterset_fields = ['is_active']
    search_fields = ['line_number', 'description']
    ordering = ['line_number']


class ShiftViewSet(viewsets.ModelViewSet):
    """
    API endpoint for work shifts.
    """
    queryset = Shift.objects.all()
    serializer_class = ShiftSerializer
    permission_classes = [permissions.IsAuthenticated]
    ordering = ['shift_number']


class AlloyViewSet(viewsets.ModelViewSet):
    """
    API endpoint for aluminum alloys.
    """
    queryset = Alloy.objects.all()
    serializer_class = AlloySerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [filters.SearchFilter]
    search_fields = ['alloy_code', 'description']
    ordering = ['alloy_code']


class TemperViewSet(viewsets.ModelViewSet):
    """
    API endpoint for temper designations.
    """
    queryset = Temper.objects.all()
    serializer_class = TemperSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [filters.SearchFilter]
    search_fields = ['temper_code', 'description']
    ordering = ['temper_code']
