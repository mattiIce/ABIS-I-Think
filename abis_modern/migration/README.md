# Data Migration Script

Migrate legacy ABIS data from Oracle 11g (Solaris 10) to Django/PostgreSQL.

## Overview

This migration tool extracts data from the legacy PowerBuilder/Oracle system and transforms it to fit the new Django models. It handles:

- **8 entity types**: Carriers, Lines, Customers, Coils, Jobs, Skids, QA Results, Shipments
- **Dependency-aware migration**: Foreign key relationships respected
- **Incremental migration**: Resume from checkpoints
- **Data transformation**: Field mapping, type conversion, data cleaning
- **Validation**: Pre and post-migration checks

## Prerequisites

### 1. Install cx_Oracle

```bash
pip install cx_Oracle
```

### 2. Oracle Instant Client (if needed)

On Linux/macOS, you may need Oracle Instant Client:

```bash
# Download from: https://www.oracle.com/database/technologies/instant-client/downloads.html
# Extract and set LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/path/to/instantclient:$LD_LIBRARY_PATH
```

### 3. Configure Environment

Create or update `.env` file:

```bash
# Oracle 11g Connection (Solaris 10)
ORACLE_USER=dbo
ORACLE_PASSWORD=obd#157

# Option A: Use TNS name (recommended if you have tnsnames.ora)
ORACLE_TNS_NAME=your_tns_name_from_tnsnames_ora

# Option B: Direct connection (alternative)
# ORACLE_HOST=solaris-server-hostname
# ORACLE_PORT=1521
# ORACLE_SERVICE=ABIS

# If tnsnames.ora is not in default location, set TNS_ADMIN
# TNS_ADMIN=/path/to/directory/containing/tnsnames.ora

# PostgreSQL Connection (already configured)
DATABASE_URL=postgresql://...
```

### 4. Configure TNS Names (Optional)

If using TNS name, place your `tnsnames.ora` file in one of these locations:
- `$ORACLE_HOME/network/admin/tnsnames.ora`
- `$TNS_ADMIN/tnsnames.ora`
- `/etc/tnsnames.ora` (Linux)

Example `tnsnames.ora` entry:
```
ABIS =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = solaris-server)(PORT = 1521))
    (CONNECT_DATA =
      (SERVICE_NAME = ABIS)
    )
  )
```

Then use `ORACLE_TNS_NAME=ABIS` in your `.env` file.

## Usage

### 1. Test Connection

```bash
python manage.py migrate_legacy_data --check-only
```

This verifies:
- Oracle connection works
- Source tables exist and accessible
- Django models ready
- Record counts visible

### 2. Dry Run

Test migration without writing to database:

```bash
python manage.py migrate_legacy_data --dry-run
```

### 3. Migrate Single Entity

Test with small dataset first:

```bash
python manage.py migrate_legacy_data --entity carrier
python manage.py migrate_legacy_data --entity line
```

### 4. Full Migration

```bash
python manage.py migrate_legacy_data --validate
```

Add `--validate` flag to run post-migration checks.

### 5. Resume from Checkpoint

If migration interrupted:

```bash
python manage.py migrate_legacy_data --resume
```

Progress is saved to `migration_checkpoint.json` after each batch.

## Migration Order

Entities migrate in dependency order:

1. **carrier** → shipping.Carrier
2. **line** → production.Line  
3. **customer** → customers.Customer
4. **coil** → inventory.Coil (depends on customer)
5. **job** → production.Job (depends on customer, coil)
6. **skid** → inventory.Skid (depends on job)
7. **qa** → quality.QAResult (depends on job)
8. **shipment** → shipping.Shipment (depends on carrier, customer)

## Data Transformations

### Field Mappings

PowerBuilder fields → Django fields:

```
AB_CUSTOMER.CUSTOMER_CODE → Customer.code
AB_CUSTOMER.CUSTOMER_NAME → Customer.name
AB_COIL.COIL_NO → Coil.coil_number
AB_JOB.JOB_NO → Job.job_number
```

### Type Conversions

- **Strings**: Trimmed, uppercase where appropriate
- **Dates**: Oracle DATE → Python datetime
- **Booleans**: 'Y'/'N', 1/0 → True/False
- **Decimals**: Number → Decimal with precision
- **Phone**: Formatted (XXX) XXX-XXXX
- **Email**: Lowercased and validated

### Null Handling

- Empty strings → NULL for optional fields
- Default values for required fields
- Nullable foreign keys handled gracefully

## Troubleshooting

### Connection Failed

```
❌ Oracle connection failed
```

**Solutions:**
- Verify credentials in `.env`
- Check network connectivity to Solaris server
- Ensure Oracle service running
- Test with `sqlplus` or `tnsping`

### Missing Table

```
❌ AB_CUSTOMER: table or view does not exist
```

**Solutions:**
- Verify table name (case-sensitive on some systems)
- Check user permissions: `GRANT SELECT ON AB_CUSTOMER TO abis;`
- Review `schema_mapping.py` for correct table names

### Foreign Key Errors

```
⚠️ Customer 12345 does not exist
```

**Solutions:**
- Ensure parent entities migrated first (check migration order)
- Review validation warnings (may auto-skip invalid FKs)
- Check source data integrity

### Memory Issues

```
MemoryError: cannot allocate memory
```

**Solutions:**
- Reduce batch size: `--batch-size 100`
- Migrate entities one at a time: `--entity customer`
- Increase available memory

### Encoding Issues

```
UnicodeDecodeError: 'utf-8' codec can't decode
```

**Solutions:**
- Connection configured for UTF-8 (already set in `oracle_connection.py`)
- Check source data encoding
- May need NLS_LANG environment variable: `export NLS_LANG=AMERICAN_AMERICA.UTF8`

## Validation

### Pre-Migration Checks

Automatically run before migration:
- Oracle connectivity
- Source table existence
- Django model availability
- Record counts

### Post-Migration Validation

Run with `--validate` flag:

```bash
python manage.py migrate_legacy_data --validate
```

Checks:
- **Record counts match** between source and target
- **No orphaned records** (invalid foreign keys)
- **Data integrity** constraints satisfied

### Manual Verification

```python
# Django shell
python manage.py shell

from customers.models import Customer
from inventory.models import Coil
from production.models import Job

# Check counts
print(f"Customers: {Customer.objects.count()}")
print(f"Coils: {Coil.objects.count()}")
print(f"Jobs: {Job.objects.count()}")

# Sample records
print(Customer.objects.first().__dict__)
print(Coil.objects.first().__dict__)
```

## Rollback

### Option 1: Database Restore

Before migration:
```bash
pg_dump abis_modern > backup_before_migration.sql
```

To restore:
```bash
psql abis_modern < backup_before_migration.sql
```

### Option 2: Truncate Tables

```python
python manage.py shell

from django.apps import apps

# Clear migrated data (in reverse order)
apps.get_model('shipping', 'Shipment').objects.all().delete()
apps.get_model('quality', 'QAResult').objects.all().delete()
apps.get_model('inventory', 'Skid').objects.all().delete()
apps.get_model('production', 'Job').objects.all().delete()
apps.get_model('inventory', 'Coil').objects.all().delete()
apps.get_model('customers', 'Customer').objects.all().delete()
apps.get_model('production', 'Line').objects.all().delete()
apps.get_model('shipping', 'Carrier').objects.all().delete()
```

## Performance Tips

### Optimize Batch Size

Default is 1000 records per batch. Adjust based on:

- **Small records** (carriers, lines): Use 5000
- **Large records** (jobs, coils): Use 500
- **Available memory**: Reduce if OOM errors

```bash
python manage.py migrate_legacy_data --entity carrier --batch-size 5000
```

### Disable Signals Temporarily

For faster bulk inserts, temporarily disable Django signals:

```python
# In migration/migrate.py
from django.db.models.signals import post_save
post_save.disconnect(sender=Job)
# ... run migration ...
post_save.connect(sender=Job)
```

### Use Database Indexes

Ensure indexes on foreign keys:

```sql
CREATE INDEX idx_coil_customer ON inventory_coil(customer_id);
CREATE INDEX idx_job_customer ON production_job(customer_id);
CREATE INDEX idx_job_coil ON production_job(coil_id);
```

## Logs

Migration creates detailed log file:

```
migration_YYYYMMDD_HHMMSS.log
```

Contains:
- Start/end timestamps
- Per-entity statistics
- Error messages with stack traces
- Progress indicators
- Validation results

## Schema Reference

### Source Tables (Oracle)

Located in Oracle 11g on Solaris 10:

- `AB_CARRIER` - Shipping carriers
- `AB_LINE` - Production lines
- `AB_CUSTOMER` - Customer master
- `AB_COIL` - Coil inventory
- `AB_JOB` - Production jobs
- `AB_SKID` - Skid/package records
- `AB_QA_RESULT` - Quality assurance results
- `AB_SHIPMENT` - Shipment records

### Target Models (Django)

- `shipping.Carrier`
- `production.Line`
- `customers.Customer`
- `inventory.Coil`
- `production.Job`
- `inventory.Skid`
- `quality.QAResult`
- `shipping.Shipment`

See `migration/schema_mapping.py` for complete field mappings.

## Support

For issues or questions:

1. Check logs: `migration_*.log`
2. Run with verbose: `python manage.py migrate_legacy_data --verbosity 2`
3. Review `schema_mapping.py` for field mappings
4. Test connection: `--check-only`
5. Validate results: `--validate`

## Example Session

```bash
# 1. Verify prerequisites
pip install cx_Oracle
export LD_LIBRARY_PATH=/opt/instantclient:$LD_LIBRARY_PATH

# 2. Configure environment
vim .env  # Add ORACLE_* variables

# 3. Test connection
python manage.py migrate_legacy_data --check-only

# Output:
# ✅ Oracle connection successful
# ✅ AB_CARRIER: 25 records
# ✅ AB_CUSTOMER: 1,234 records
# ✅ AB_COIL: 45,678 records
# ...

# 4. Dry run
python manage.py migrate_legacy_data --dry-run

# 5. Migrate incrementally
python manage.py migrate_legacy_data --entity carrier
python manage.py migrate_legacy_data --entity line
python manage.py migrate_legacy_data --entity customer

# 6. Full migration with validation
python manage.py migrate_legacy_data --validate

# Output:
# Migrating carrier: AB_CARRIER -> Carrier
# [████████████████████████████████████████] 100.0% (25/25) | Elapsed: 2s
# Migrated: 25, Skipped: 0, Failed: 0
#
# Migrating customer: AB_CUSTOMER -> Customer  
# [████████████████████████████████████████] 100.0% (1234/1234) | Elapsed: 45s
# Migrated: 1234, Skipped: 0, Failed: 0
#
# Overall Summary:
#   Total records: 47,196
#   Successfully migrated: 47,196
#   Failed: 0
#   Success rate: 100.00%
#
# POST-MIGRATION VALIDATION REPORT
# Record Counts:
#   ✅ carrier
#   ✅ customer
#   ✅ coil
#   ...
# Orphaned Records:
#   ✅ None found
#
# ✅ Migration completed successfully!
```
