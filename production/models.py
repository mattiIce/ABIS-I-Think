"""
Production and job management models.
"""
from django.db import models
from core.models import TimeStampedModel, Line, Shift
from customers.models import Customer
from inventory.models import Coil


class Job(TimeStampedModel):
    """Production job/work order."""
    STATUS_CHOICES = [
        ('SCHEDULED', 'Scheduled'),
        ('IN_PROGRESS', 'In Progress'),
        ('COMPLETED', 'Completed'),
        ('ON_HOLD', 'On Hold'),
        ('CANCELLED', 'Cancelled'),
    ]
    
    job_id = models.AutoField(primary_key=True)
    job_number = models.CharField(max_length=50, unique=True, db_index=True)
    
    # Customer and product
    customer = models.ForeignKey(Customer, on_delete=models.PROTECT, related_name='jobs')
    part_number = models.CharField(max_length=100)
    part_description = models.CharField(max_length=200)
    
    # Order reference
    customer_po = models.CharField(max_length=100, blank=True)
    order_line = models.CharField(max_length=50, blank=True)
    
    # Production details
    line = models.ForeignKey(Line, on_delete=models.PROTECT, related_name='jobs')
    shift = models.ForeignKey(Shift, on_delete=models.PROTECT, related_name='jobs', null=True, blank=True)
    
    # Quantities
    ordered_quantity = models.IntegerField()
    produced_quantity = models.IntegerField(default=0)
    scrap_quantity = models.IntegerField(default=0)
    
    # Target specifications
    target_gauge = models.DecimalField(max_digits=10, decimal_places=4)
    target_width = models.DecimalField(max_digits=10, decimal_places=3)
    target_length = models.DecimalField(max_digits=10, decimal_places=3, null=True, blank=True)
    
    # Scheduling
    scheduled_start = models.DateTimeField(null=True, blank=True)
    scheduled_end = models.DateTimeField(null=True, blank=True)
    actual_start = models.DateTimeField(null=True, blank=True)
    actual_end = models.DateTimeField(null=True, blank=True)
    
    # Status
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='SCHEDULED')
    priority = models.IntegerField(default=100, help_text="Lower number = higher priority")
    
    notes = models.TextField(blank=True)

    class Meta:
        db_table = 'jobs'
        ordering = ['priority', '-created_at']
        indexes = [
            models.Index(fields=['customer', 'status']),
            models.Index(fields=['line', 'status']),
            models.Index(fields=['scheduled_start']),
        ]

    def __str__(self):
        return f"Job {self.job_number} - {self.customer.company_name}"


class JobCoil(TimeStampedModel):
    """Association of coils to jobs."""
    job_coil_id = models.AutoField(primary_key=True)
    job = models.ForeignKey(Job, on_delete=models.CASCADE, related_name='job_coils')
    coil = models.ForeignKey(Coil, on_delete=models.PROTECT, related_name='job_coils')
    
    sequence = models.IntegerField(default=0)
    quantity_used = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    is_active = models.BooleanField(default=True)

    class Meta:
        db_table = 'job_coils'
        ordering = ['job', 'sequence']
        unique_together = [['job', 'coil']]

    def __str__(self):
        return f"{self.job.job_number} - {self.coil.abc_coil_number}"


class DailyProduction(TimeStampedModel):
    """Daily production summary."""
    daily_prod_id = models.AutoField(primary_key=True)
    production_date = models.DateField(db_index=True)
    line = models.ForeignKey(Line, on_delete=models.PROTECT)
    shift = models.ForeignKey(Shift, on_delete=models.PROTECT)
    
    # Production metrics
    total_pieces = models.IntegerField(default=0)
    total_weight = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    scrap_weight = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    
    # Time tracking
    scheduled_runtime = models.DecimalField(max_digits=6, decimal_places=2, help_text="Hours")
    actual_runtime = models.DecimalField(max_digits=6, decimal_places=2, default=0)
    downtime = models.DecimalField(max_digits=6, decimal_places=2, default=0)
    
    # Efficiency
    efficiency_percent = models.DecimalField(max_digits=5, decimal_places=2, default=0)
    
    notes = models.TextField(blank=True)

    class Meta:
        db_table = 'daily_production'
        ordering = ['-production_date', 'line']
        unique_together = [['production_date', 'line', 'shift']]

    def __str__(self):
        return f"{self.production_date} - {self.line} - Shift {self.shift.shift_number}"


class Downtime(TimeStampedModel):
    """Downtime tracking."""
    CATEGORY_CHOICES = [
        ('MECHANICAL', 'Mechanical'),
        ('ELECTRICAL', 'Electrical'),
        ('TOOLING', 'Tooling'),
        ('MATERIAL', 'Material Issue'),
        ('QUALITY', 'Quality Issue'),
        ('CHANGEOVER', 'Job Changeover'),
        ('OTHER', 'Other'),
    ]
    
    downtime_id = models.AutoField(primary_key=True)
    line = models.ForeignKey(Line, on_delete=models.PROTECT, related_name='downtimes')
    job = models.ForeignKey(Job, on_delete=models.PROTECT, related_name='downtimes', null=True, blank=True)
    
    start_time = models.DateTimeField(db_index=True)
    end_time = models.DateTimeField(null=True, blank=True)
    duration_minutes = models.IntegerField(default=0)
    
    category = models.CharField(max_length=20, choices=CATEGORY_CHOICES)
    cause = models.CharField(max_length=200)
    description = models.TextField()
    
    corrective_action = models.TextField(blank=True)

    class Meta:
        db_table = 'downtime'
        ordering = ['-start_time']

    def __str__(self):
        return f"{self.line} - {self.get_category_display()} - {self.start_time}"

    def save(self, *args, **kwargs):
        if self.end_time and self.start_time:
            delta = self.end_time - self.start_time
            self.duration_minutes = int(delta.total_seconds() / 60)
        super().save(*args, **kwargs)
