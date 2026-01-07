#!/usr/bin/env python
"""
Quick Oracle Connection Test

Tests Oracle connectivity with provided credentials and TNS configuration.
"""

import os
import sys

# Add parent directory to path
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

# Try to import required modules
try:
    import cx_Oracle
    print("✅ cx_Oracle module imported successfully")
except ImportError as e:
    print(f"❌ Failed to import cx_Oracle: {e}")
    print("Install with: pip install cx_Oracle")
    sys.exit(1)

try:
    from dotenv import load_dotenv
    load_dotenv()
    print("✅ Environment variables loaded")
except ImportError:
    print("⚠️  python-dotenv not installed, using system environment only")

# Default credentials
ORACLE_USER = os.getenv('ORACLE_USER', 'dbo')
ORACLE_PASSWORD = os.getenv('ORACLE_PASSWORD', 'obd#157')
ORACLE_TNS_NAME = os.getenv('ORACLE_TNS_NAME')
ORACLE_HOST = os.getenv('ORACLE_HOST')
ORACLE_PORT = os.getenv('ORACLE_PORT', '1521')
ORACLE_SERVICE = os.getenv('ORACLE_SERVICE')

print("\n" + "="*60)
print("ORACLE CONNECTION TEST")
print("="*60)

# Display configuration
print("\nConfiguration:")
print(f"  User: {ORACLE_USER}")
print(f"  Password: {'*' * len(ORACLE_PASSWORD)}")
if ORACLE_TNS_NAME:
    print(f"  TNS Name: {ORACLE_TNS_NAME}")
if ORACLE_HOST:
    print(f"  Host: {ORACLE_HOST}")
    print(f"  Port: {ORACLE_PORT}")
    print(f"  Service: {ORACLE_SERVICE}")

# Test TNS_ADMIN
tns_admin = os.getenv('TNS_ADMIN')
if tns_admin:
    print(f"  TNS_ADMIN: {tns_admin}")
    tnsnames_path = os.path.join(tns_admin, 'tnsnames.ora')
    if os.path.exists(tnsnames_path):
        print(f"  ✅ tnsnames.ora found: {tnsnames_path}")
    else:
        print(f"  ⚠️  tnsnames.ora not found at: {tnsnames_path}")

print("\n" + "-"*60)
print("Testing Connection...")
print("-"*60)

connection_successful = False
connection_method = None

# Method 1: Try TNS connection
if ORACLE_TNS_NAME:
    print(f"\nMethod 1: TNS Connection to '{ORACLE_TNS_NAME}'")
    try:
        conn = cx_Oracle.connect(ORACLE_USER, ORACLE_PASSWORD, ORACLE_TNS_NAME)
        print("✅ TNS connection SUCCESSFUL!")
        connection_successful = True
        connection_method = "TNS"
    except cx_Oracle.DatabaseError as e:
        error, = e.args
        print(f"❌ TNS connection failed:")
        print(f"   Error Code: {error.code}")
        print(f"   Error Message: {error.message}")
        if error.code == 12154:
            print("\n   💡 Troubleshooting ORA-12154:")
            print("      - Verify TNS name exists in tnsnames.ora")
            print("      - Check TNS_ADMIN environment variable")
            print("      - Verify file permissions on tnsnames.ora")
    except Exception as e:
        print(f"❌ TNS connection failed: {e}")

# Method 2: Try direct connection
if not connection_successful and ORACLE_HOST and ORACLE_SERVICE:
    print(f"\nMethod 2: Direct Connection to {ORACLE_HOST}:{ORACLE_PORT}/{ORACLE_SERVICE}")
    try:
        dsn = cx_Oracle.makedsn(ORACLE_HOST, ORACLE_PORT, service_name=ORACLE_SERVICE)
        conn = cx_Oracle.connect(ORACLE_USER, ORACLE_PASSWORD, dsn)
        print("✅ Direct connection SUCCESSFUL!")
        connection_successful = True
        connection_method = "Direct"
    except cx_Oracle.DatabaseError as e:
        error, = e.args
        print(f"❌ Direct connection failed:")
        print(f"   Error Code: {error.code}")
        print(f"   Error Message: {error.message}")
        if error.code == 12514:
            print("\n   💡 Troubleshooting ORA-12514:")
            print("      - Verify service name is correct")
            print("      - Check Oracle listener is running")
        elif error.code == 1017:
            print("\n   💡 Troubleshooting ORA-01017:")
            print("      - Verify username/password: dbo / obd#157")
            print("      - Check account is not locked")
    except Exception as e:
        print(f"❌ Direct connection failed: {e}")

# If connected, run some tests
if connection_successful:
    print("\n" + "="*60)
    print(f"CONNECTION SUCCESSFUL ({connection_method} method)")
    print("="*60)
    
    try:
        cursor = conn.cursor()
        
        # Test 1: Check Oracle version
        print("\n1. Oracle Version:")
        cursor.execute("SELECT * FROM v$version WHERE banner LIKE 'Oracle%'")
        version = cursor.fetchone()
        if version:
            print(f"   {version[0]}")
        
        # Test 2: Check current user
        print("\n2. Current User:")
        cursor.execute("SELECT USER FROM dual")
        user = cursor.fetchone()[0]
        print(f"   {user}")
        
        # Test 3: Count tables
        print("\n3. User Tables:")
        cursor.execute("SELECT COUNT(*) FROM user_tables")
        count = cursor.fetchone()[0]
        print(f"   Total tables: {count}")
        
        # Test 4: List some tables
        if count > 0:
            print("\n4. Sample Tables:")
            cursor.execute("SELECT table_name FROM user_tables WHERE ROWNUM <= 10 ORDER BY table_name")
            tables = cursor.fetchall()
            for table in tables:
                print(f"   - {table[0]}")
        
        # Test 5: Check for ABIS tables
        print("\n5. ABIS Tables (AB_* prefix):")
        cursor.execute("""
            SELECT table_name, num_rows 
            FROM user_tables 
            WHERE table_name LIKE 'AB_%' 
            ORDER BY table_name
        """)
        abis_tables = cursor.fetchall()
        if abis_tables:
            for table, rows in abis_tables:
                row_count = rows if rows else 'Unknown'
                print(f"   - {table}: {row_count} rows")
        else:
            print("   ⚠️  No tables with AB_ prefix found")
            print("   You may need to adjust the schema mapping configuration")
        
        cursor.close()
        conn.close()
        
        print("\n" + "="*60)
        print("✅ ALL TESTS PASSED - Ready for migration!")
        print("="*60)
        print("\nNext steps:")
        print("  1. Review the tables listed above")
        print("  2. Run: python manage.py migrate_legacy_data --check-only")
        print("  3. If checks pass, run: python manage.py migrate_legacy_data --dry-run")
        
    except Exception as e:
        print(f"\n❌ Error during testing: {e}")
        conn.close()

else:
    print("\n" + "="*60)
    print("❌ CONNECTION FAILED")
    print("="*60)
    print("\nTroubleshooting steps:")
    print("  1. Verify credentials in .env file")
    print("  2. Check network connectivity to Oracle server")
    print("  3. Ensure Oracle service is running")
    print("  4. Review TNS_SETUP.md for detailed configuration help")
    print("  5. If using TNS, verify tnsnames.ora file exists and is readable")
    print("\nFor TNS configuration help:")
    print("  cat migration/TNS_SETUP.md")
    
    sys.exit(1)

print("\n")
