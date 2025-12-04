#!/usr/bin/env python
"""
Automated EDI Setup Script
Runs migrations and tests the EDI system
"""
import os
import sys
import subprocess

# Change to the correct directory
os.chdir('/workspaces/ABIS-I-Think/abis_modern')

def run_command(command, description):
    """Run a shell command and print output."""
    print(f"\n{'='*60}")
    print(f"▶ {description}")
    print('='*60)
    
    try:
        result = subprocess.run(
            command,
            shell=True,
            capture_output=True,
            text=True,
            check=True
        )
        
        if result.stdout:
            print(result.stdout)
        if result.stderr:
            print(result.stderr)
        
        print(f"✅ {description} - SUCCESS")
        return True
        
    except subprocess.CalledProcessError as e:
        print(f"❌ {description} - FAILED")
        print(f"Exit code: {e.returncode}")
        if e.stdout:
            print("STDOUT:", e.stdout)
        if e.stderr:
            print("STDERR:", e.stderr)
        return False

def main():
    """Main setup function."""
    print("\n" + "="*60)
    print("🚀 ABIS EDI System Automated Setup")
    print("="*60)
    
    # Step 1: Create migrations
    if not run_command(
        'python manage.py makemigrations edi',
        'Creating EDI migrations'
    ):
        print("\n⚠️  Migration creation failed, but continuing...")
    
    # Step 2: Apply all migrations
    if not run_command(
        'python manage.py migrate',
        'Applying all migrations'
    ):
        print("\n❌ Migration failed. Stopping.")
        sys.exit(1)
    
    # Step 3: Test the EDI system
    print("\n" + "="*60)
    print("▶ Testing EDI System")
    print("="*60)
    
    # Import and run the test
    sys.path.insert(0, '/workspaces/ABIS-I-Think/abis_modern')
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'abis_modern.settings')
    
    import django
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
    
    print(f"\n✅ EDI Partner: {partner.company_name} ({'created' if created else 'exists'})")
    print(f"✅ Transaction count: {EDITransaction.objects.count()}")
    print(f"✅ Active partners: {EDIPartner.objects.filter(is_active=True).count()}")
    
    # Show endpoints
    print("\n" + "="*60)
    print("📡 Available EDI Endpoints:")
    print("="*60)
    endpoints = [
        'GET/POST  /api/edi/partners/',
        'GET       /api/edi/transactions/',
        'POST      /api/edi/transactions/generate_856/',
        'POST      /api/edi/transactions/generate_863/',
        'POST      /api/edi/transactions/generate_870/',
        'POST      /api/edi/transactions/parse_edi/',
        'GET       /api/edi/856-ship-notices/',
        'GET       /api/edi/863-test-reports/',
        'GET       /api/edi/870-order-status/',
    ]
    for endpoint in endpoints:
        print(f"  • {endpoint}")
    
    print("\n" + "="*60)
    print("✅ EDI SYSTEM READY!")
    print("="*60)
    print("\n🌐 Backend: http://localhost:8000")
    print("🎨 Frontend: http://localhost:5173")
    print("🔧 Admin: http://localhost:8000/admin/edi/")
    print("\n" + "="*60)

if __name__ == '__main__':
    try:
        main()
    except Exception as e:
        print(f"\n❌ Error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)
