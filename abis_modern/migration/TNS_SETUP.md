# Oracle TNS Configuration Guide

## Using TNS Names with the Migration Tool

The Oracle connection manager supports both TNS names (from `tnsnames.ora`) and direct connections.

### Your Credentials
- **Username**: `dbo`
- **Password**: `obd#157`

---

## Option 1: Using TNS Names (Recommended)

### Step 1: Locate or Create tnsnames.ora

Place your `tnsnames.ora` file in one of these standard locations:

**Linux/Unix:**
- `$ORACLE_HOME/network/admin/tnsnames.ora`
- `$TNS_ADMIN/tnsnames.ora`
- `/etc/tnsnames.ora`

**Your tnsnames.ora content** (paste your actual file here):
```
# Example format:
ABIS =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = solaris-server.domain.com)(PORT = 1521))
    (CONNECT_DATA =
      (SERVICE_NAME = ABIS)
      (SERVER = DEDICATED)
    )
  )
```

### Step 2: Set TNS_ADMIN (if needed)

If your `tnsnames.ora` is not in a standard location:

```bash
export TNS_ADMIN=/path/to/directory/containing/tnsnames.ora

# Add to .env file
echo "TNS_ADMIN=/path/to/directory" >> .env
```

### Step 3: Configure .env

```bash
# Edit .env file
ORACLE_USER=dbo
ORACLE_PASSWORD=obd#157
ORACLE_TNS_NAME=ABIS  # Use the TNS name from your tnsnames.ora
```

### Step 4: Test Connection

```bash
# Test with SQLPlus (if available)
sqlplus dbo/obd#157@ABIS

# Or test with Python
python -c "import cx_Oracle; conn = cx_Oracle.connect('dbo', 'obd#157', 'ABIS'); print('Connected!'); conn.close()"

# Or use the migration tool
python manage.py migrate_legacy_data --check-only
```

---

## Option 2: Direct Connection (Alternative)

If you don't have or can't use a `tnsnames.ora` file:

### Configure .env

```bash
ORACLE_USER=dbo
ORACLE_PASSWORD=obd#157
ORACLE_HOST=your-solaris-server-hostname
ORACLE_PORT=1521
ORACLE_SERVICE=ABIS
```

### Test Connection

```bash
python manage.py migrate_legacy_data --check-only
```

---

## Troubleshooting

### Error: "ORA-12154: TNS:could not resolve the connect identifier"

**Solutions:**
1. Verify TNS name exists in `tnsnames.ora`
2. Check `TNS_ADMIN` environment variable
3. Verify file permissions: `chmod 644 tnsnames.ora`
4. Check for typos in TNS name

```bash
# List your TNS names
tnsping ABIS

# Check TNS_ADMIN
echo $TNS_ADMIN

# Verify tnsnames.ora location
find /etc $ORACLE_HOME $TNS_ADMIN -name "tnsnames.ora" 2>/dev/null
```

### Error: "ORA-12514: TNS:listener does not currently know of service"

**Solutions:**
1. Verify service name is correct
2. Check Oracle listener is running on target server
3. Verify network connectivity: `ping solaris-server`
4. Test port: `telnet solaris-server 1521`

### Error: "ORA-01017: invalid username/password"

**Solutions:**
1. Verify credentials: `dbo` / `obd#157`
2. Check account is not locked
3. Test with SQLPlus: `sqlplus dbo/obd#157@ABIS`

### Error: "DPI-1047: Cannot locate a 64-bit Oracle Client library"

**Solutions:**
1. Install Oracle Instant Client
2. Set LD_LIBRARY_PATH:
   ```bash
   export LD_LIBRARY_PATH=/path/to/instantclient:$LD_LIBRARY_PATH
   ```

### Connection Times Out

**Solutions:**
1. Check firewall rules
2. Verify server hostname resolves: `nslookup solaris-server`
3. Test connectivity: `nc -zv solaris-server 1521`
4. Check Oracle listener status on server

---

## Testing Your Configuration

### Quick Connection Test

Create a test script `test_oracle.py`:

```python
#!/usr/bin/env python
import cx_Oracle
import os
from dotenv import load_dotenv

load_dotenv()

# Try TNS connection
tns_name = os.getenv('ORACLE_TNS_NAME')
user = os.getenv('ORACLE_USER', 'dbo')
password = os.getenv('ORACLE_PASSWORD', 'obd#157')

if tns_name:
    print(f"Testing TNS connection: {user}@{tns_name}")
    try:
        conn = cx_Oracle.connect(user, password, tns_name)
        print("✅ TNS connection successful!")
        
        # Test query
        cursor = conn.cursor()
        cursor.execute("SELECT COUNT(*) FROM user_tables")
        count = cursor.fetchone()[0]
        print(f"✅ Found {count} tables in schema")
        
        cursor.close()
        conn.close()
    except Exception as e:
        print(f"❌ TNS connection failed: {e}")
else:
    print("⚠️  ORACLE_TNS_NAME not set, trying direct connection")
    host = os.getenv('ORACLE_HOST')
    port = os.getenv('ORACLE_PORT', '1521')
    service = os.getenv('ORACLE_SERVICE')
    
    if host and service:
        dsn = cx_Oracle.makedsn(host, port, service_name=service)
        print(f"Testing direct connection: {user}@{host}:{port}/{service}")
        try:
            conn = cx_Oracle.connect(user, password, dsn)
            print("✅ Direct connection successful!")
            conn.close()
        except Exception as e:
            print(f"❌ Direct connection failed: {e}")
    else:
        print("❌ Missing connection parameters")
```

Run test:
```bash
python test_oracle.py
```

---

## tnsnames.ora Template

Please provide your actual `tnsnames.ora` file, or create one using this template:

```
# ABIS Production Database (Oracle 11g on Solaris 10)
ABIS =
  (DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(HOST = <your-solaris-server>)(PORT = 1521))
    )
    (CONNECT_DATA =
      (SERVICE_NAME = ABIS)
      (SERVER = DEDICATED)
    )
  )

# You can add multiple entries for different environments:
ABIS_DEV =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = dev-server)(PORT = 1521))
    (CONNECT_DATA =
      (SERVICE_NAME = ABIS_DEV)
    )
  )
```

**Replace `<your-solaris-server>` with actual hostname or IP address.**

---

## Next Steps

Once connection is working:

1. ✅ Connection test passes
2. Run pre-migration checks: `python manage.py migrate_legacy_data --check-only`
3. Review source tables
4. Start migration: `python manage.py migrate_legacy_data --dry-run`

---

## Need Your tnsnames.ora File

To complete the setup, please share your `tnsnames.ora` file contents. You can:

1. **Copy the file content**:
   ```bash
   cat $TNS_ADMIN/tnsnames.ora
   # or
   cat $ORACLE_HOME/network/admin/tnsnames.ora
   ```

2. **Or provide**:
   - Server hostname/IP
   - Port (usually 1521)
   - Service name or SID
   - Any special connection parameters

Once you provide this, I can create a complete configuration file for you.
