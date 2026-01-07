from django.db.models.signals import post_save, pre_save
from django.dispatch import receiver
from production.models import Job
from shipping.models import Shipment
# from quality.models import QAResult  # TODO: Create QAResult model
from inventory.models import Coil
from .services import NotificationService
import logging

logger = logging.getLogger(__name__)


@receiver(post_save, sender=Job)
def job_status_changed(sender, instance, created, **kwargs):
    """Send notification when job status changes"""
    if created and instance.status == 'SCHEDULED':
        # New job created
        NotificationService.notify_job_event(instance, 'JOB_STARTED')
    elif not created:
        # Job updated - check status changes
        if instance.status == 'COMPLETED':
            NotificationService.notify_job_event(instance, 'JOB_COMPLETED')
        elif instance.status == 'ON_HOLD':
            NotificationService.notify_job_event(instance, 'JOB_ON_HOLD')


@receiver(post_save, sender=Shipment)
def shipment_status_changed(sender, instance, created, **kwargs):
    """Send notification when shipment status changes"""
    if created:
        NotificationService.notify_shipment_event(instance, 'SHIPMENT_CREATED')
    elif not created and instance.status == 'SHIPPED':
        NotificationService.notify_shipment_event(instance, 'SHIPMENT_SHIPPED')


# TODO: Uncomment when QAResult model is created
# @receiver(post_save, sender=QAResult)
# def qa_result_saved(sender, instance, created, **kwargs):
#     """Send notification when QA test is completed"""
#     if created:
#         if instance.passed:
#             NotificationService.notify_qa_event(instance, 'QA_PASSED')
#         else:
#             NotificationService.notify_qa_event(instance, 'QA_FAILED')


@receiver(post_save, sender=Coil)
def coil_received(sender, instance, created, **kwargs):
    """Send notification when new coil is received"""
    if created:
        NotificationService.notify_inventory_event(instance, 'INVENTORY_RECEIVED')
