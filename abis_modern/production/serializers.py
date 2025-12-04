"""
Serializers for production models.
"""
from rest_framework import serializers
from .models import Job, JobCoil, DailyProduction, Downtime


class JobCoilSerializer(serializers.ModelSerializer):
    coil_number = serializers.CharField(source='coil.abc_coil_number', read_only=True)
    
    class Meta:
        model = JobCoil
        fields = '__all__'
        read_only_fields = ['created_at', 'created_by', 'updated_at', 'updated_by']


class JobSerializer(serializers.ModelSerializer):
    customer_name = serializers.CharField(source='customer.company_name', read_only=True)
    line_number = serializers.CharField(source='line.line_number', read_only=True)
    shift_number = serializers.CharField(source='shift.shift_number', read_only=True)
    
    class Meta:
        model = Job
        fields = '__all__'
        read_only_fields = ['created_at', 'created_by', 'updated_at', 'updated_by']


class JobDetailSerializer(JobSerializer):
    """Extended serializer with assigned coils."""
    job_coils = JobCoilSerializer(many=True, read_only=True)


class DailyProductionSerializer(serializers.ModelSerializer):
    line_number = serializers.CharField(source='line.line_number', read_only=True)
    shift_number = serializers.CharField(source='shift.shift_number', read_only=True)
    
    class Meta:
        model = DailyProduction
        fields = '__all__'
        read_only_fields = ['created_at', 'created_by', 'updated_at', 'updated_by']


class DowntimeSerializer(serializers.ModelSerializer):
    line_number = serializers.CharField(source='line.line_number', read_only=True)
    job_number = serializers.CharField(source='job.job_number', read_only=True)
    category_display = serializers.CharField(source='get_category_display', read_only=True)
    
    class Meta:
        model = Downtime
        fields = '__all__'
        read_only_fields = ['duration_minutes', 'created_at', 'created_by', 'updated_at', 'updated_by']
