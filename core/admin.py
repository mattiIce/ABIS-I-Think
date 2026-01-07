from django.contrib import admin
from .models import SystemLog, SystemOption, Line, Shift, Alloy, Temper


@admin.register(SystemLog)
class SystemLogAdmin(admin.ModelAdmin):
    list_display = ['user', 'action', 'table_name', 'created_at']
    list_filter = ['action', 'created_at']
    search_fields = ['user__username', 'action', 'description']
    readonly_fields = ['created_at', 'created_by', 'updated_at', 'updated_by']


@admin.register(SystemOption)
class SystemOptionAdmin(admin.ModelAdmin):
    list_display = ['key', 'value', 'category']
    list_filter = ['category']
    search_fields = ['key', 'description']


@admin.register(Line)
class LineAdmin(admin.ModelAdmin):
    list_display = ['line_number', 'description', 'capacity', 'is_active']
    list_filter = ['is_active']


@admin.register(Shift)
class ShiftAdmin(admin.ModelAdmin):
    list_display = ['shift_number', 'description', 'start_time', 'end_time']


@admin.register(Alloy)
class AlloyAdmin(admin.ModelAdmin):
    list_display = ['alloy_code', 'description', 'density']
    search_fields = ['alloy_code', 'description']


@admin.register(Temper)
class TemperAdmin(admin.ModelAdmin):
    list_display = ['temper_code', 'description']
    search_fields = ['temper_code', 'description']
