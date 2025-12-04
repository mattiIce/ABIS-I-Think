#!/bin/bash
# Quick EDI Setup - Copy and paste this entire block into your terminal

cd /workspaces/ABIS-I-Think/abis_modern

echo "================================================"
echo "Step 1: Creating EDI migrations..."
echo "================================================"
python manage.py makemigrations edi

echo ""
echo "================================================"
echo "Step 2: Applying migrations..."
echo "================================================"
python manage.py migrate

echo ""
echo "================================================"
echo "Step 3: Testing EDI system..."
echo "================================================"
python -c "
import os, sys, django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'abis_modern.settings')
django.setup()

from edi.models import EDIPartner, EDITransaction

# Create test partner
partner, created = EDIPartner.objects.get_or_create(
    edi_id='TEST001',
    defaults={
        'company_name': 'Test Customer',
        'qualifier': 'ZZ',
        'supports_856': True,
        'supports_863': True,
        'supports_870': True,
        'is_active': True,
    }
)

print(f'\n✅ Test Partner: {partner.company_name} ({\"created\" if created else \"exists\"})')
print(f'✅ Total EDI partners: {EDIPartner.objects.filter(is_active=True).count()}')
print(f'✅ Total transactions: {EDITransaction.objects.count()}')
print('\n================================================')
print('✅ EDI SYSTEM IS READY!')
print('================================================')
"

echo ""
echo "📡 EDI Endpoints Available:"
echo "  • GET/POST  /api/edi/partners/"
echo "  • POST      /api/edi/transactions/generate_856/"
echo "  • POST      /api/edi/transactions/generate_863/"
echo "  • POST      /api/edi/transactions/generate_870/"
echo "  • POST      /api/edi/transactions/parse_edi/"
echo ""
echo "🌐 Backend:  http://localhost:8000"
echo "🎨 Frontend: http://localhost:5173"
echo "🔧 Admin:    http://localhost:8000/admin/edi/"
echo ""
