"""
API views for production models.
"""
from rest_framework import viewsets, permissions, filters, status
from rest_framework.decorators import action
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend
from django.db.models import Sum, Avg, Count, Q
from django.utils import timezone
from datetime import timedelta
from .models import Job, JobCoil, DailyProduction, Downtime
from .serializers import (
    JobSerializer, JobDetailSerializer, JobCoilSerializer,
    DailyProductionSerializer, DowntimeSerializer
)


class JobViewSet(viewsets.ModelViewSet):
    """
    API endpoint for production jobs.
    """
    queryset = Job.objects.select_related('customer', 'line', 'shift')
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['status', 'customer', 'line', 'shift']
    search_fields = ['job_number', 'part_number', 'customer_po']
    ordering_fields = ['priority', 'scheduled_start', 'created_at']
    ordering = ['priority', '-created_at']
    
    def get_serializer_class(self):
        if self.action == 'retrieve':
            return JobDetailSerializer
        return JobSerializer
    
    @action(detail=True, methods=['post'])
    def start(self, request, pk=None):
        """Start a job."""
        job = self.get_object()
        job.status = 'IN_PROGRESS'
        job.actual_start = timezone.now()
        job.save()
        serializer = self.get_serializer(job)
        return Response(serializer.data)
    
    @action(detail=True, methods=['post'])
    def complete(self, request, pk=None):
        """Complete a job."""
        job = self.get_object()
        job.status = 'COMPLETED'
        job.actual_end = timezone.now()
        job.save()
        serializer = self.get_serializer(job)
        return Response(serializer.data)
    
    @action(detail=True, methods=['get'])
    def coils(self, request, pk=None):
        """Get coils assigned to this job."""
        job = self.get_object()
        job_coils = job.job_coils.select_related('coil').filter(is_active=True)
        serializer = JobCoilSerializer(job_coils, many=True)
        return Response(serializer.data)
    
    @action(detail=False, methods=['get'])
    def active(self, request):
        """Get currently active jobs."""
        jobs = self.queryset.filter(status='IN_PROGRESS')
        serializer = self.get_serializer(jobs, many=True)
        return Response(serializer.data)
    
    @action(detail=False, methods=['get'])
    def scheduled(self, request):
        """Get scheduled jobs for today."""
        today = timezone.now().date()
        jobs = self.queryset.filter(
            status='SCHEDULED',
            scheduled_start__date=today
        ).order_by('priority', 'scheduled_start')
        serializer = self.get_serializer(jobs, many=True)
        return Response(serializer.data)


class JobCoilViewSet(viewsets.ModelViewSet):
    """
    API endpoint for job-coil assignments.
    """
    queryset = JobCoil.objects.select_related('job', 'coil')
    serializer_class = JobCoilSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['job', 'coil', 'is_active']


class DailyProductionViewSet(viewsets.ModelViewSet):
    """
    API endpoint for daily production tracking.
    """
    queryset = DailyProduction.objects.select_related('line', 'shift')
    serializer_class = DailyProductionSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend, filters.OrderingFilter]
    filterset_fields = ['production_date', 'line', 'shift']
    ordering_fields = ['production_date', 'line']
    ordering = ['-production_date']
    
    @action(detail=False, methods=['get'])
    def summary(self, request):
        """Get production summary for date range."""
        start_date = request.query_params.get('start_date')
        end_date = request.query_params.get('end_date')
        
        queryset = self.queryset
        if start_date:
            queryset = queryset.filter(production_date__gte=start_date)
        if end_date:
            queryset = queryset.filter(production_date__lte=end_date)
        
        summary = queryset.aggregate(
            total_pieces=Sum('total_pieces'),
            total_weight=Sum('total_weight'),
            total_scrap=Sum('scrap_weight'),
            avg_efficiency=Avg('efficiency_percent'),
            total_downtime=Sum('downtime')
        )
        return Response(summary)
    
    @action(detail=False, methods=['get'])
    def by_line(self, request):
        """Get production grouped by line."""
        from django.db.models import Sum
        summary = self.queryset.values('line__line_number').annotate(
            total_weight=Sum('total_weight'),
            total_pieces=Sum('total_pieces'),
            avg_efficiency=Avg('efficiency_percent')
        ).order_by('line__line_number')
        return Response(summary)


class DowntimeViewSet(viewsets.ModelViewSet):
    """
    API endpoint for downtime tracking.
    """
    queryset = Downtime.objects.select_related('line', 'job')
    serializer_class = DowntimeSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['line', 'job', 'category']
    search_fields = ['cause', 'description']
    ordering_fields = ['start_time', 'duration_minutes']
    ordering = ['-start_time']
    
    @action(detail=False, methods=['get'])
    def by_category(self, request):
        """Get downtime summary by category."""
        summary = self.queryset.values('category').annotate(
            count=Count('downtime_id'),
            total_minutes=Sum('duration_minutes')
        ).order_by('-total_minutes')
        return Response(summary)
    
    @action(detail=False, methods=['get'])
    def recent(self, request):
        """Get recent downtime (last 7 days)."""
        seven_days_ago = timezone.now() - timedelta(days=7)
        downtimes = self.queryset.filter(start_time__gte=seven_days_ago)
        page = self.paginate_queryset(downtimes)
        serializer = self.get_serializer(page, many=True)
        return self.get_paginated_response(serializer.data)
