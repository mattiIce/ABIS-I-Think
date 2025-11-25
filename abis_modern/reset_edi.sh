#!/bin/bash
# Clean migrations and create fresh ones

cd /workspaces/ABIS-I-Think/abis_modern

echo "================================================"
echo "🔄 Resetting EDI Migrations"
echo "================================================"

echo ""
echo "Step 1: Removing old migration files..."
rm -f edi/migrations/0001_initial.py
rm -f edi/migrations/0002_*.py
rm -rf edi/migrations/__pycache__

echo "✅ Old migrations removed"

echo ""
echo "Step 2: Creating fresh migrations..."
python manage.py makemigrations edi --noinput

echo ""
echo "Step 3: Applying migrations..."
python manage.py migrate

echo ""
echo "Step 4: Testing EDI system..."
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
print('✅ EDI SYSTEM SUCCESSFULLY INSTALLED!')
print('='*60)
print(f'✅ Test Partner: {partner.company_name} ({\"created\" if created else \"already exists\"})')
print(f'✅ Total EDI partners: {EDIPartner.objects.filter(is_active=True).count()}')
print(f'✅ Total transactions: {EDITransaction.objects.count()}')
print('='*60)
"

echo ""
echo "================================================"
echo "🎉 EDI System Ready!"
echo "================================================"
echo ""
echo "📡 Available Endpoints:"
echo "  • POST /api/edi/transactions/generate_856/"
echo "  • POST /api/edi/transactions/generate_863/"
echo "  • POST /api/edi/transactions/generate_870/"
echo "  • POST /api/edi/transactions/parse_edi/"
echo "  • GET  /api/edi/partners/"
echo "  • GET  /api/edi/transactions/"
echo ""
echo "🌐 Access Points:"
echo "  • Backend:  http://localhost:8000"
echo "  • Frontend: http://localhost:5173"
echo "  • Admin:    http://localhost:8000/admin/edi/"
echo ""
echo "================================================"
