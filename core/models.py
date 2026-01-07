"""
Core models for ABIS system.
"""
from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone


class TimeStampedModel(models.Model):
    """Abstract base class with timestamps."""
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    created_by = models.ForeignKey(
        User, 
        on_delete=models.SET_NULL, 
        null=True, 
        related_name='%(class)s_created'
    )
    updated_by = models.ForeignKey(
        User, 
        on_delete=models.SET_NULL, 
        null=True, 
        related_name='%(class)s_updated'
    )

    class Meta:
        abstract = True


class SystemLog(TimeStampedModel):
    """System activity logging."""
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    action = models.CharField(max_length=100)
    table_name = models.CharField(max_length=100, blank=True)
    record_id = models.CharField(max_length=100, blank=True)
    description = models.TextField(blank=True)
    ip_address = models.GenericIPAddressField(null=True, blank=True)

    class Meta:
        db_table = 'system_log'
        ordering = ['-created_at']

    def __str__(self):
        return f"{self.user.username} - {self.action} at {self.created_at}"


class SystemOption(models.Model):
    """System configuration options."""
    key = models.CharField(max_length=100, unique=True)
    value = models.TextField()
    description = models.TextField(blank=True)
    category = models.CharField(max_length=50, default='general')

    class Meta:
        db_table = 'system_options'
        ordering = ['category', 'key']

    def __str__(self):
        return f"{self.key}: {self.value}"


class Line(models.Model):
    """Production lines (24", 36", 60", 75", 84", 108", 110")."""
    line_id = models.AutoField(primary_key=True)
    line_number = models.CharField(max_length=10, unique=True)
    description = models.CharField(max_length=200)
    is_active = models.BooleanField(default=True)
    capacity = models.DecimalField(max_digits=10, decimal_places=2, help_text="Capacity in lbs/hr")
    
    class Meta:
        db_table = 'lines'
        ordering = ['line_number']

    def __str__(self):
        return f"Line {self.line_number}"


class Shift(models.Model):
    """Work shift definitions."""
    SHIFT_CHOICES = [
        ('1', 'First Shift'),
        ('2', 'Second Shift'),
        ('3', 'Third Shift'),
    ]
    
    shift_id = models.AutoField(primary_key=True)
    shift_number = models.CharField(max_length=1, choices=SHIFT_CHOICES)
    start_time = models.TimeField()
    end_time = models.TimeField()
    description = models.CharField(max_length=100)

    class Meta:
        db_table = 'shifts'
        ordering = ['shift_number']

    def __str__(self):
        return f"Shift {self.shift_number} ({self.start_time}-{self.end_time})"


class Alloy(models.Model):
    """Aluminum alloy types."""
    alloy_id = models.AutoField(primary_key=True)
    alloy_code = models.CharField(max_length=20, unique=True)
    description = models.CharField(max_length=200)
    density = models.DecimalField(max_digits=10, decimal_places=4, help_text="Density in lbs/in³")

    class Meta:
        db_table = 'alloys'
        ordering = ['alloy_code']

    def __str__(self):
        return self.alloy_code


class Temper(models.Model):
    """Temper designations (H14, H16, etc.)."""
    temper_id = models.AutoField(primary_key=True)
    temper_code = models.CharField(max_length=20, unique=True)
    description = models.CharField(max_length=200)

    class Meta:
        db_table = 'tempers'
        ordering = ['temper_code']

    def __str__(self):
        return self.temper_code
