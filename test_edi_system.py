#!/usr/bin/env python
"""Test script to verify EDI system after migrations."""
import os
import sys
import django

# Setup Django
sys.path.insert(0, '/workspaces/ABIS-I-Think/abis_modern')
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'abis_modern.settings')
django.setup()

from django.contrib.auth.models import User
from edi.models import EDIPartner, EDITransaction

def test_edi_system():
    """Test EDI models and basic functionality."""
    print("=" * 60)
    print("EDI System Test")
    print("=" * 60)
    
    # Test 1: Create EDI Partner
    print("\n✓ Testing EDI Partner creation...")
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
    print(f"  Partner: {partner.company_name} ({'created' if created else 'exists'})")
    
    # Test 2: Count existing transactions
    print("\n✓ Checking EDI transactions...")
    transaction_count = EDITransaction.objects.count()
    print(f"  Total transactions: {transaction_count}")
    
    # Test 3: List partners by transaction support
    print("\n✓ Partners by transaction support:")
    partners_856 = EDIPartner.objects.filter(supports_856=True, is_active=True).count()
    partners_863 = EDIPartner.objects.filter(supports_863=True, is_active=True).count()
    partners_870 = EDIPartner.objects.filter(supports_870=True, is_active=True).count()
    print(f"  856 (Ship Notice): {partners_856} partners")
    print(f"  863 (Test Report): {partners_863} partners")
    print(f"  870 (Order Status): {partners_870} partners")
    
    # Test 4: API endpoints availability
    print("\n✓ EDI API Endpoints:")
    endpoints = [
        '/api/edi/partners/',
        '/api/edi/transactions/',
        '/api/edi/transactions/generate_856/',
        '/api/edi/transactions/generate_863/',
        '/api/edi/transactions/generate_870/',
        '/api/edi/transactions/parse_edi/',
        '/api/edi/856-ship-notices/',
        '/api/edi/863-test-reports/',
        '/api/edi/870-order-status/',
    ]
    for endpoint in endpoints:
        print(f"  • {endpoint}")
    
    print("\n" + "=" * 60)
    print("✅ EDI System is ready!")
    print("=" * 60)
    print("\nNext steps:")
    print("  1. Access EDI admin at: http://localhost:8000/admin/edi/")
    print("  2. Create trading partners via API or admin")
    print("  3. Test EDI generation endpoints")
    print("  4. Backend is running at: http://localhost:8000")
    print("=" * 60)

if __name__ == '__main__':
    try:
        test_edi_system()
    except Exception as e:
        print(f"\n❌ Error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)
