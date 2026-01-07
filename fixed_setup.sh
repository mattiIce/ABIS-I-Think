#!/bin/bash
# Fixed EDI Setup Script

cd /workspaces/ABIS-I-Think/abis_modern

echo "================================================"
echo "🔧 EDI System Setup (Field Names Fixed)"
echo "================================================"

echo ""
echo "Step 1: Creating EDI migrations..."
python manage.py makemigrations edi

echo ""
echo "Step 2: Applying all migrations..."
python manage.py migrate

echo ""
echo "Step 3: Testing EDI system..."
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

print('\n' + '='*60)
print('✅ EDI SYSTEM READY!')
print('='*60)
print(f'✅ Test Partner: {partner.company_name} ({\"created\" if created else \"exists\"})')
print(f'✅ Total EDI partners: {EDIPartner.objects.filter(is_active=True).count()}')
print(f'✅ Total transactions: {EDITransaction.objects.count()}')
print('='*60)
"

echo ""
echo "================================================"
echo "📡 EDI API Endpoints"
echo "================================================"
echo "  POST /api/edi/transactions/generate_856/  - Ship Notice"
echo "  POST /api/edi/transactions/generate_863/  - Test Report"
echo "  POST /api/edi/transactions/generate_870/  - Order Status"
echo "  POST /api/edi/transactions/parse_edi/     - Parse Incoming"
echo "  GET  /api/edi/partners/                   - Trading Partners"
echo "  GET  /api/edi/transactions/               - All Transactions"
echo ""
echo "🌐 Backend:  http://localhost:8000"
echo "🎨 Frontend: http://localhost:5173"
echo "🔧 Admin:    http://localhost:8000/admin/edi/"
echo "================================================"
