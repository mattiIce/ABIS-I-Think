"""
Celery configuration for background tasks.
"""
import os
from celery import Celery
from celery.schedules import crontab

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'abis_modern.settings')

app = Celery('abis_modern')
app.config_from_object('django.conf:settings', namespace='CELERY')
app.autodiscover_tasks()

# Periodic tasks
app.conf.beat_schedule = {
    'process-edi-files-every-15-minutes': {
        'task': 'edi.tasks.process_incoming_edi',
        'schedule': crontab(minute='*/15'),
    },
    'generate-daily-production-reports': {
        'task': 'reports.tasks.generate_daily_production_report',
        'schedule': crontab(hour=7, minute=0),
    },
    'send-inventory-alerts': {
        'task': 'inventory.tasks.check_inventory_alerts',
        'schedule': crontab(hour='*/2'),
    },
}
