"""
Serializers for core models.
"""
from rest_framework import serializers
from .models import SystemLog, SystemOption, Line, Shift, Alloy, Temper


class SystemLogSerializer(serializers.ModelSerializer):
    user_username = serializers.CharField(source='user.username', read_only=True)
    
    class Meta:
        model = SystemLog
        fields = '__all__'
        read_only_fields = ['created_at', 'created_by', 'updated_at', 'updated_by']


class SystemOptionSerializer(serializers.ModelSerializer):
    class Meta:
        model = SystemOption
        fields = '__all__'


class LineSerializer(serializers.ModelSerializer):
    class Meta:
        model = Line
        fields = '__all__'


class ShiftSerializer(serializers.ModelSerializer):
    class Meta:
        model = Shift
        fields = '__all__'


class AlloySerializer(serializers.ModelSerializer):
    class Meta:
        model = Alloy
        fields = '__all__'


class TemperSerializer(serializers.ModelSerializer):
    class Meta:
        model = Temper
        fields = '__all__'
