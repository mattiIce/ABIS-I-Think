"""
Analytics utility functions for aggregating and processing data.
"""
from django.db.models import Sum, Count, Avg, Q, F, Max, Min
from django.db.models.functions import TruncDate, TruncMonth, TruncWeek
from django.utils import timezone
from datetime import timedelta
from decimal import Decimal


class ProductionAnalytics:
    """Analytics for production data."""
    
    @staticmethod
    def get_production_trends(days=30):
        """Get production output trends by day."""
        from production.models import Job
        
        end_date = timezone.now()
        start_date = end_date - timedelta(days=days)
        
        trends = Job.objects.filter(
            created_at__gte=start_date,
            created_at__lte=end_date
        ).annotate(
            date=TruncDate('created_at')
        ).values('date').annotate(
            total_jobs=Count('job_id'),
            total_quantity=Sum('ordered_quantity')
        ).order_by('date')
        
        return list(trends)
    
    @staticmethod
    def get_production_by_line(days=30):
        """Get production output grouped by production line."""
        from production.models import Job
        
        end_date = timezone.now()
        start_date = end_date - timedelta(days=days)
        
        by_line = Job.objects.filter(
            created_at__gte=start_date,
            created_at__lte=end_date
        ).values('line__name').annotate(
            total_jobs=Count('job_id'),
            total_quantity=Sum('ordered_quantity'),
            avg_quantity=Avg('ordered_quantity')
        ).order_by('-total_quantity')
        
        return list(by_line)
    
    @staticmethod
    def get_efficiency_metrics(days=30):
        """Calculate production efficiency metrics."""
        from production.models import Job
        
        end_date = timezone.now()
        start_date = end_date - timedelta(days=days)
        
        jobs = Job.objects.filter(
            created_at__gte=start_date,
            created_at__lte=end_date
        )
        
        total_jobs = jobs.count()
        completed_jobs = jobs.filter(status='COMPLETED').count()
        in_progress_jobs = jobs.filter(status='IN_PROGRESS').count()
        pending_jobs = jobs.filter(status='SCHEDULED').count()
        
        completion_rate = (completed_jobs / total_jobs * 100) if total_jobs > 0 else 0
        
        return {
            'total_jobs': total_jobs,
            'completed_jobs': completed_jobs,
            'in_progress_jobs': in_progress_jobs,
            'pending_jobs': pending_jobs,
            'completion_rate': round(completion_rate, 2)
        }
    
    @staticmethod
    def get_downtime_analysis(days=30):
        """Analyze downtime by category."""
        from production.models import DowntimeLog
        
        end_date = timezone.now()
        start_date = end_date - timedelta(days=days)
        
        downtime = DowntimeLog.objects.filter(
            start_time__gte=start_date,
            start_time__lte=end_date
        ).values('category').annotate(
            total_incidents=Count('pk'),
            total_duration=Sum('duration_minutes')
        ).order_by('-total_duration')
        
        return list(downtime)


class QualityAnalytics:
    """Analytics for quality control data."""
    
    @staticmethod
    def get_defect_trends(days=30):
        """Get defect trends over time."""
        from quality.models import QAResult
        
        end_date = timezone.now()
        start_date = end_date - timedelta(days=days)
        
        trends = QAResult.objects.filter(
            created_at__gte=start_date,
            created_at__lte=end_date
        ).annotate(
            date=TruncDate('created_at')
        ).values('date').annotate(
            total_tests=Count('pk'),
            passed_tests=Count('pk', filter=Q(status='PASSED')),
            failed_tests=Count('pk', filter=Q(status='FAILED'))
        ).order_by('date')
        
        return list(trends)
    
    @staticmethod
    def get_defect_distribution():
        """Get distribution of defect types."""
        from quality.models import Defect
        
        distribution = Defect.objects.values('defect_type__name').annotate(
            count=Count('pk')
        ).order_by('-count')[:10]
        
        return list(distribution)
    
    @staticmethod
    def get_quality_metrics(days=30):
        """Calculate overall quality metrics."""
        from quality.models import QAResult
        
        end_date = timezone.now()
        start_date = end_date - timedelta(days=days)
        
        results = QAResult.objects.filter(
            created_at__gte=start_date,
            created_at__lte=end_date
        )
        
        total_tests = results.count()
        passed_tests = results.filter(status='PASSED').count()
        failed_tests = results.filter(status='FAILED').count()
        
        pass_rate = (passed_tests / total_tests * 100) if total_tests > 0 else 0
        
        return {
            'total_tests': total_tests,
            'passed_tests': passed_tests,
            'failed_tests': failed_tests,
            'pass_rate': round(pass_rate, 2)
        }
    
    @staticmethod
    def get_qa_by_inspector(days=30):
        """Get QA results grouped by inspector."""
        from quality.models import QAResult
        
        end_date = timezone.now()
        start_date = end_date - timedelta(days=days)
        
        by_inspector = QAResult.objects.filter(
            created_at__gte=start_date,
            created_at__lte=end_date
        ).values('inspector__username').annotate(
            total_tests=Count('pk'),
            passed_tests=Count('pk', filter=Q(status='PASSED')),
            failed_tests=Count('pk', filter=Q(status='FAILED'))
        ).order_by('-total_tests')
        
        return list(by_inspector)


class InventoryAnalytics:
    """Analytics for inventory data."""
    
    @staticmethod
    def get_inventory_levels():
        """Get current inventory levels by material."""
        from inventory.models import Coil
        
        levels = Coil.objects.filter(
            status='AVAILABLE'
        ).values('material__alloy__code').annotate(
            total_coils=Count('coil_id'),
            total_weight=Sum('weight')
        ).order_by('-total_weight')
        
        return list(levels)
    
    @staticmethod
    def get_turnover_analysis(days=90):
        """Calculate inventory turnover metrics."""
        from inventory.models import Coil
        from shipping.models import Shipment
        
        end_date = timezone.now()
        start_date = end_date - timedelta(days=days)
        
        # Coils received
        received = Coil.objects.filter(
            received_date__gte=start_date,
            received_date__lte=end_date
        ).aggregate(
            total_received=Count('coil_id'),
            total_weight_received=Sum('weight')
        )
        
        # Coils shipped
        shipped = Shipment.objects.filter(
            ship_date__gte=start_date,
            ship_date__lte=end_date
        ).aggregate(
            total_shipments=Count('shipment_id')
        )
        
        return {
            'coils_received': received['total_received'] or 0,
            'weight_received': float(received['total_weight_received'] or 0),
            'total_shipments': shipped['total_shipments'] or 0,
            'period_days': days
        }
    
    @staticmethod
    def get_inventory_value():
        """Calculate total inventory value."""
        from inventory.models import Coil
        
        value_data = Coil.objects.filter(
            status='AVAILABLE'
        ).aggregate(
            total_coils=Count('coil_id'),
            total_weight=Sum('weight')
        )
        
        return value_data
    
    @staticmethod
    def get_aging_analysis():
        """Analyze inventory aging."""
        from inventory.models import Coil
        
        today = timezone.now().date()
        
        # Age brackets: 0-30, 31-60, 61-90, 90+ days
        aging = {
            '0-30_days': 0,
            '31-60_days': 0,
            '61-90_days': 0,
            '90plus_days': 0
        }
        
        coils = Coil.objects.filter(status='AVAILABLE')
        
        for coil in coils:
            if coil.received_date:
                age = (today - coil.received_date).days
                if age <= 30:
                    aging['0-30_days'] += 1
                elif age <= 60:
                    aging['31-60_days'] += 1
                elif age <= 90:
                    aging['61-90_days'] += 1
                else:
                    aging['90plus_days'] += 1
        
        return aging


class CustomerAnalytics:
    """Analytics for customer data."""
    
    @staticmethod
    def get_top_customers(days=90, limit=10):
        """Get top customers by order volume."""
        from shipping.models import Shipment
        
        end_date = timezone.now()
        start_date = end_date - timedelta(days=days)
        
        top_customers = Shipment.objects.filter(
            ship_date__gte=start_date,
            ship_date__lte=end_date
        ).values('customer__company_name').annotate(
            total_shipments=Count('shipment_id'),
            total_value=Count('skids')  # Simplified - would need actual value calculation
        ).order_by('-total_shipments')[:limit]
        
        return list(top_customers)
    
    @staticmethod
    def get_order_trends(days=90):
        """Get order trends over time."""
        from production.models import Job
        
        end_date = timezone.now()
        start_date = end_date - timedelta(days=days)
        
        trends = Job.objects.filter(
            created_at__gte=start_date,
            created_at__lte=end_date
        ).annotate(
            week=TruncWeek('created_at')
        ).values('week').annotate(
            total_orders=Count('job_id'),
            total_quantity=Sum('ordered_quantity')
        ).order_by('week')
        
        return list(trends)
    
    @staticmethod
    def get_shipment_analysis(days=30):
        """Analyze shipment patterns."""
        from shipping.models import Shipment
        
        end_date = timezone.now()
        start_date = end_date - timedelta(days=days)
        
        shipments = Shipment.objects.filter(
            ship_date__gte=start_date,
            ship_date__lte=end_date
        )
        
        total_shipments = shipments.count()
        on_time = shipments.filter(status='DELIVERED').count()
        pending = shipments.filter(status='PENDING').count()
        
        on_time_rate = (on_time / total_shipments * 100) if total_shipments > 0 else 0
        
        return {
            'total_shipments': total_shipments,
            'delivered': on_time,
            'pending': pending,
            'on_time_rate': round(on_time_rate, 2)
        }
    
    @staticmethod
    def get_customer_distribution():
        """Get customer distribution by region/type."""
        from customers.models import Customer
        
        distribution = Customer.objects.values('state').annotate(
            count=Count('customer_id')
        ).order_by('-count')[:10]
        
        return list(distribution)
