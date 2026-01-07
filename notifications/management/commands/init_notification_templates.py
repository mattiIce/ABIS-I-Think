from django.core.management.base import BaseCommand
from notifications.models import NotificationTemplate
import os
from django.conf import settings


class Command(BaseCommand):
    help = 'Initialize default notification templates'

    def handle(self, *args, **options):
        templates_dir = os.path.join(settings.BASE_DIR, 'notifications', 'templates', 'emails')
        
        templates_data = [
            {
                'name': 'Job Started',
                'notification_type': 'JOB_STARTED',
                'subject': 'Job {{ job_number }} Started',
                'body_text': '''A new production job has been started.

Job Number: {{ job_number }}
Job ID: {{ job_id }}
Customer: {{ customer_name }}
Alloy: {{ alloy }}
Quantity: {{ quantity }} lbs
Status: {{ status }}

Please monitor this job's progress in the production system.

---
ABIS Production Management System''',
                'html_file': 'job_started.html',
            },
            {
                'name': 'Job Completed',
                'notification_type': 'JOB_COMPLETED',
                'subject': 'Job {{ job_number }} Completed',
                'body_text': '''A production job has been successfully completed.

Job Number: {{ job_number }}
Job ID: {{ job_id }}
Customer: {{ customer_name }}
Alloy: {{ alloy }}
Quantity: {{ quantity }} lbs
Status: {{ status }}

The job is now ready for quality inspection and shipping preparation.

---
ABIS Production Management System''',
                'html_file': 'job_completed.html',
            },
            {
                'name': 'Job On Hold',
                'notification_type': 'JOB_ON_HOLD',
                'subject': 'Job {{ job_number }} On Hold',
                'body_text': '''A production job has been placed on hold.

Job Number: {{ job_number }}
Job ID: {{ job_id }}
Customer: {{ customer_name }}
Alloy: {{ alloy }}
Quantity: {{ quantity }} lbs
Status: {{ status }}

Please review and address any issues preventing production.

---
ABIS Production Management System''',
                'html_file': 'job_started.html',  # Reuse template
            },
            {
                'name': 'Shipment Created',
                'notification_type': 'SHIPMENT_CREATED',
                'subject': 'New Shipment {{ bol_number }} Created',
                'body_text': '''A new shipment has been created and is ready for processing.

Shipment ID: {{ shipment_id }}
BOL Number: {{ bol_number }}
Customer: {{ customer_name }}
Carrier: {{ carrier }}
Ship Date: {{ ship_date }}
Status: {{ status }}

Please ensure all items are prepared and ready for pickup.

---
ABIS Production Management System''',
                'html_file': 'shipment_created.html',
            },
            {
                'name': 'Shipment Shipped',
                'notification_type': 'SHIPMENT_SHIPPED',
                'subject': 'Shipment {{ bol_number }} Has Shipped',
                'body_text': '''A shipment has been dispatched.

Shipment ID: {{ shipment_id }}
BOL Number: {{ bol_number }}
Customer: {{ customer_name }}
Carrier: {{ carrier }}
Ship Date: {{ ship_date }}
Status: {{ status }}

The customer has been notified of the shipment.

---
ABIS Production Management System''',
                'html_file': 'shipment_created.html',  # Reuse template
            },
            {
                'name': 'QA Test Failed',
                'notification_type': 'QA_FAILED',
                'subject': 'QA Test Failed for {{ coil_id }}',
                'body_text': '''ALERT: A quality assurance test has failed and requires immediate attention.

Test ID: {{ test_id }}
Coil ID: {{ coil_id }}
Test Type: {{ test_type }}
Inspector: {{ inspector }}
Test Date: {{ test_date }}
Result: {{ result }}

Action Required: Please review the test results and take appropriate corrective action.

---
ABIS Production Management System''',
                'html_file': 'qa_failed.html',
            },
            {
                'name': 'QA Test Passed',
                'notification_type': 'QA_PASSED',
                'subject': 'QA Test Passed for {{ coil_id }}',
                'body_text': '''A quality assurance test has passed successfully.

Test ID: {{ test_id }}
Coil ID: {{ coil_id }}
Test Type: {{ test_type }}
Inspector: {{ inspector }}
Test Date: {{ test_date }}
Result: {{ result }}

The material is approved for use.

---
ABIS Production Management System''',
                'html_file': 'qa_failed.html',  # Reuse template with different context
            },
            {
                'name': 'Low Inventory Alert',
                'notification_type': 'INVENTORY_LOW',
                'subject': 'Low Inventory Alert - {{ alloy }}',
                'body_text': '''WARNING: Inventory levels are running low.

Coil ID: {{ coil_id }}
Heat Number: {{ heat_number }}
Alloy: {{ alloy }}
Temper: {{ temper }}
Current Quantity: {{ quantity }} lbs
Location: {{ location }}

Action Required: Please review inventory levels and consider placing a new order.

---
ABIS Production Management System''',
                'html_file': 'inventory_low.html',
            },
            {
                'name': 'Inventory Received',
                'notification_type': 'INVENTORY_RECEIVED',
                'subject': 'New Inventory Received - {{ coil_id }}',
                'body_text': '''New inventory has been received.

Coil ID: {{ coil_id }}
Heat Number: {{ heat_number }}
Alloy: {{ alloy }}
Temper: {{ temper }}
Quantity: {{ quantity }} lbs
Location: {{ location }}

The material is now available in the system.

---
ABIS Production Management System''',
                'html_file': 'inventory_low.html',  # Reuse template
            },
        ]
        
        created_count = 0
        updated_count = 0
        
        for template_data in templates_data:
            html_file = template_data.pop('html_file')
            html_path = os.path.join(templates_dir, html_file)
            
            # Read HTML template
            try:
                with open(html_path, 'r') as f:
                    body_html = f.read()
            except FileNotFoundError:
                self.stdout.write(self.style.WARNING(
                    f'HTML template not found: {html_file}, using text only'
                ))
                body_html = template_data['body_text'].replace('\n', '<br>')
            
            template_data['body_html'] = body_html
            
            # Create or update template
            template, created = NotificationTemplate.objects.update_or_create(
                notification_type=template_data['notification_type'],
                defaults=template_data
            )
            
            if created:
                created_count += 1
                self.stdout.write(self.style.SUCCESS(
                    f'Created template: {template.name}'
                ))
            else:
                updated_count += 1
                self.stdout.write(self.style.SUCCESS(
                    f'Updated template: {template.name}'
                ))
        
        self.stdout.write(self.style.SUCCESS(
            f'\nInitialization complete: {created_count} created, {updated_count} updated'
        ))
