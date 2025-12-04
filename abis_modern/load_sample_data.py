#!/usr/bin/env python
"""
Load sample data for ABIS Modern application testing.
"""
import os
import sys
import django

# Setup Django environment
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'abis_modern.settings')
django.setup()

from decimal import Decimal
from datetime import datetime, timedelta
from core.models import Line, Shift, Alloy, Temper
from customers.models import Customer, Carrier
from inventory.models import Coil
from production.models import Job

def load_sample_data():
    print("Loading sample data...")
    
    # Create Lines
    lines_data = [
        {'line_number': '24', 'description': '24" Line', 'capacity': Decimal('5000.00')},
        {'line_number': '36', 'description': '36" Line', 'capacity': Decimal('7500.00')},
        {'line_number': '60', 'description': '60" Line', 'capacity': Decimal('10000.00')},
        {'line_number': '75', 'description': '75" Line', 'capacity': Decimal('12500.00')},
        {'line_number': '84', 'description': '84" Line', 'capacity': Decimal('15000.00')},
        {'line_number': '108', 'description': '108" Line', 'capacity': Decimal('18000.00')},
        {'line_number': '110', 'description': '110" Line', 'capacity': Decimal('20000.00')},
    ]
    
    for line_data in lines_data:
        line, created = Line.objects.get_or_create(
            line_number=line_data['line_number'],
            defaults=line_data
        )
        if created:
            print(f"  Created Line: {line.line_number}")
    
    # Create Shifts
    shifts_data = [
        {'shift_number': '1', 'description': 'First Shift (Day)', 'start_time': '07:00', 'end_time': '15:00'},
        {'shift_number': '2', 'description': 'Second Shift (Evening)', 'start_time': '15:00', 'end_time': '23:00'},
        {'shift_number': '3', 'description': 'Third Shift (Night)', 'start_time': '23:00', 'end_time': '07:00'},
    ]
    
    for shift_data in shifts_data:
        shift, created = Shift.objects.get_or_create(
            shift_number=shift_data['shift_number'],
            defaults=shift_data
        )
        if created:
            print(f"  Created Shift: {shift.description}")
    
    # Create Alloys
    alloys_data = [
        {'alloy_code': '3003', 'description': '3003 Aluminum-Manganese', 'density': Decimal('0.0975')},
        {'alloy_code': '3004', 'description': '3004 Aluminum-Manganese-Magnesium', 'density': Decimal('0.0975')},
        {'alloy_code': '3104', 'description': '3104 Aluminum-Manganese-Magnesium', 'density': Decimal('0.0975')},
        {'alloy_code': '5052', 'description': '5052 Aluminum-Magnesium', 'density': Decimal('0.0975')},
        {'alloy_code': '5182', 'description': '5182 Aluminum-Magnesium', 'density': Decimal('0.0975')},
        {'alloy_code': '6061', 'description': '6061 Aluminum-Magnesium-Silicon', 'density': Decimal('0.0975')},
    ]
    
    for alloy_data in alloys_data:
        alloy, created = Alloy.objects.get_or_create(
            alloy_code=alloy_data['alloy_code'],
            defaults=alloy_data
        )
        if created:
            print(f"  Created Alloy: {alloy.alloy_code}")
    
    # Create Tempers
    tempers_data = [
        {'temper_code': 'H14', 'description': 'Strain-hardened, 1/2 hard'},
        {'temper_code': 'H16', 'description': 'Strain-hardened, 3/4 hard'},
        {'temper_code': 'H18', 'description': 'Strain-hardened, full hard'},
        {'temper_code': 'H19', 'description': 'Strain-hardened, extra hard'},
        {'temper_code': 'O', 'description': 'Annealed'},
        {'temper_code': 'T6', 'description': 'Solution heat-treated and artificially aged'},
    ]
    
    for temper_data in tempers_data:
        temper, created = Temper.objects.get_or_create(
            temper_code=temper_data['temper_code'],
            defaults=temper_data
        )
        if created:
            print(f"  Created Temper: {temper.temper_code}")
    
    # Create Carriers
    carriers_data = [
        {'carrier_code': 'ABCT', 'company_name': 'ABC Trucking', 'scac_code': 'ABCT', 'phone': '555-0001'},
        {'carrier_code': 'XYZL', 'company_name': 'XYZ Logistics', 'scac_code': 'XYZL', 'phone': '555-0002'},
        {'carrier_code': 'FSTF', 'company_name': 'FastFreight LLC', 'scac_code': 'FSTF', 'phone': '555-0003'},
    ]
    
    for carrier_data in carriers_data:
        carrier, created = Carrier.objects.get_or_create(
            carrier_code=carrier_data['carrier_code'],
            defaults=carrier_data
        )
        if created:
            print(f"  Created Carrier: {carrier.company_name}")
    
    # Create Customers
    customers_data = [
        {
            'customer_code': 'FORD',
            'company_name': 'Ford Motor Company',
            'address_line1': '1 American Road',
            'city': 'Dearborn',
            'state': 'MI',
            'zip_code': '48126',
            'country': 'USA',
            'phone': '313-555-0001',
        },
        {
            'customer_code': 'GM',
            'company_name': 'General Motors',
            'address_line1': '100 Renaissance Center',
            'city': 'Detroit',
            'state': 'MI',
            'zip_code': '48243',
            'country': 'USA',
            'phone': '313-555-0002',
        },
        {
            'customer_code': 'TESLA',
            'company_name': 'Tesla Inc',
            'address_line1': '1 Tesla Road',
            'city': 'Austin',
            'state': 'TX',
            'zip_code': '78725',
            'country': 'USA',
            'phone': '512-555-0003',
        },
        {
            'customer_code': 'ALCOA',
            'company_name': 'Alcoa Corporation',
            'address_line1': '201 Isabella Street',
            'city': 'Pittsburgh',
            'state': 'PA',
            'zip_code': '15212',
            'country': 'USA',
            'phone': '412-555-0004',
        },
    ]
    
    customers = []
    for customer_data in customers_data:
        customer, created = Customer.objects.get_or_create(
            customer_code=customer_data['customer_code'],
            defaults=customer_data
        )
        if created:
            print(f"  Created Customer: {customer.company_name}")
        customers.append(customer)
    
    # Create Sample Coils
    print("\nCreating sample coils...")
    alloy_3004 = Alloy.objects.get(alloy_code='3004')
    alloy_5052 = Alloy.objects.get(alloy_code='5052')
    temper_h14 = Temper.objects.get(temper_code='H14')
    temper_h16 = Temper.objects.get(temper_code='H16')
    
    coils_data = [
        {
            'original_coil_number': 'ALCOA-2024-001',
            'abc_coil_number': 'ABC-000001',
            'customer': customers[3],  # Alcoa
            'alloy': alloy_3004,
            'temper': temper_h14,
            'gauge': Decimal('0.040'),
            'width': Decimal('48.00'),
            'gross_weight': Decimal('15000.00'),
            'tare_weight': Decimal('500.00'),
            'received_date': datetime.now().date() - timedelta(days=10),
            'status': 'approved',
        },
        {
            'original_coil_number': 'ALCOA-2024-002',
            'abc_coil_number': 'ABC-000002',
            'customer': customers[3],  # Alcoa
            'alloy': alloy_5052,
            'temper': temper_h16,
            'gauge': Decimal('0.050'),
            'width': Decimal('60.00'),
            'gross_weight': Decimal('18000.00'),
            'tare_weight': Decimal('600.00'),
            'received_date': datetime.now().date() - timedelta(days=8),
            'status': 'approved',
        },
        {
            'original_coil_number': 'ALCOA-2024-003',
            'abc_coil_number': 'ABC-000003',
            'customer': customers[3],  # Alcoa
            'alloy': alloy_3004,
            'temper': temper_h14,
            'gauge': Decimal('0.032'),
            'width': Decimal('36.00'),
            'gross_weight': Decimal('12000.00'),
            'tare_weight': Decimal('400.00'),
            'received_date': datetime.now().date() - timedelta(days=5),
            'status': 'approved',
        },
        {
            'original_coil_number': 'ALCOA-2024-004',
            'abc_coil_number': 'ABC-000004',
            'customer': customers[3],  # Alcoa
            'alloy': alloy_5052,
            'temper': temper_h14,
            'gauge': Decimal('0.063'),
            'width': Decimal('72.00'),
            'gross_weight': Decimal('20000.00'),
            'tare_weight': Decimal('700.00'),
            'received_date': datetime.now().date() - timedelta(days=3),
            'status': 'quarantine',
        },
    ]
    
    for coil_data in coils_data:
        coil, created = Coil.objects.get_or_create(
            abc_coil_number=coil_data['abc_coil_number'],
            defaults=coil_data
        )
        if created:
            print(f"  Created Coil: {coil.abc_coil_number} ({coil.status})")
    
    # Create Sample Jobs
    print("\nCreating sample jobs...")
    line_60 = Line.objects.get(line_number='60')
    line_84 = Line.objects.get(line_number='84')
    
    jobs_data = [
        {
            'job_number': 'JOB-2024-001',
            'customer': customers[0],  # Ford
            'line': line_60,
            'part_number': 'FORD-001',
            'part_description': 'Aluminum Panel 48" x 96"',
            'target_gauge': Decimal('0.040'),
            'target_width': Decimal('48.00'),
            'target_length': Decimal('96.00'),
            'ordered_quantity': 1000,
            'scheduled_start': datetime.now() + timedelta(days=2),
            'status': 'SCHEDULED',
        },
        {
            'job_number': 'JOB-2024-002',
            'customer': customers[1],  # GM
            'line': line_84,
            'part_number': 'GM-002',
            'part_description': 'Aluminum Sheet 60" x 120"',
            'target_gauge': Decimal('0.050'),
            'target_width': Decimal('60.00'),
            'target_length': Decimal('120.00'),
            'ordered_quantity': 1500,
            'scheduled_start': datetime.now() + timedelta(days=5),
            'status': 'SCHEDULED',
        },
        {
            'job_number': 'JOB-2024-003',
            'customer': customers[2],  # Tesla
            'line': line_60,
            'part_number': 'TESLA-003',
            'part_description': 'Aluminum Sheet 36" x 84"',
            'target_gauge': Decimal('0.032'),
            'target_width': Decimal('36.00'),
            'target_length': Decimal('84.00'),
            'ordered_quantity': 800,
            'scheduled_start': datetime.now() - timedelta(days=1),
            'status': 'IN_PROGRESS',
            'actual_start': datetime.now() - timedelta(days=1),
        },
    ]
    
    for job_data in jobs_data:
        job, created = Job.objects.get_or_create(
            job_number=job_data['job_number'],
            defaults=job_data
        )
        if created:
            print(f"  Created Job: {job.job_number} - {job.customer.company_name} ({job.status})")
    
    print("\n✅ Sample data loaded successfully!")
    print("\nYou can now:")
    print("  - Access the admin at: http://localhost:8000/admin/")
    print("    Login: admin / admin")
    print("  - Access the API at: http://localhost:8000/")
    print("  - Access the frontend at: http://localhost:3000/")

if __name__ == '__main__':
    try:
        load_sample_data()
    except Exception as e:
        print(f"\n❌ Error loading sample data: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)
