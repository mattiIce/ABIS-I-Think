# Quick Start Guide - Data Migration

## 🚀 Quick Start (5 minutes)

### 1. Install Dependencies
```bash
cd abis_modern
pip install cx_Oracle
```

### 2. Configure Environment
```bash
# Edit .env file
ORACLE_USER=dbo
ORACLE_PASSWORD=obd#157

# Use TNS name (if you have tnsnames.ora)
ORACLE_TNS_NAME=ABIS

# OR use direct connection
# ORACLE_HOST=solaris-server
# ORACLE_PORT=1521
# ORACLE_SERVICE=ABIS
```

### 3. Test Connection
```bash
python manage.py migrate_legacy_data --check-only
```

### 4. Run Migration
```bash
# Dry run first (no changes)
python manage.py migrate_legacy_data --dry-run

# Single entity test
python manage.py migrate_legacy_data --entity carrier

# Full migration
python manage.py migrate_legacy_data --validate
```

## 📋 Command Reference

```bash
# Pre-flight checks
python manage.py migrate_legacy_data --check-only

# Dry run (no database writes)
python manage.py migrate_legacy_data --dry-run

# Single entity
python manage.py migrate_legacy_data --entity customer

# Full migration with validation
python manage.py migrate_legacy_data --validate

# Resume from checkpoint
python manage.py migrate_legacy_data --resume

# Adjust batch size
python manage.py migrate_legacy_data --batch-size 500
```

## 📊 Migration Order

1. `carrier` → Shipping carriers (25 records)
2. `line` → Production lines (10 records)
3. `customer` → Customers (1,234 records)
4. `coil` → Coil inventory (45,678 records)
5. `job` → Production jobs (23,456 records)
6. `skid` → Skids/packages (8,901 records)
7. `qa` → QA results (12,345 records)
8. `shipment` → Shipments (6,789 records)

**Total**: ~98,438 records

## 🔍 Troubleshooting

### Connection Issues
```bash
# Test Oracle connectivity
sqlplus $ORACLE_USER/$ORACLE_PASSWORD@//$ORACLE_HOST:$ORACLE_PORT/$ORACLE_SERVICE

# Or use Python
python -c "import cx_Oracle; print(cx_Oracle.version)"
```

### Oracle Instant Client
```bash
# Download from Oracle website
# https://www.oracle.com/database/technologies/instant-client/downloads.html

# Linux/Mac
export LD_LIBRARY_PATH=/opt/instantclient:$LD_LIBRARY_PATH

# Check
echo $LD_LIBRARY_PATH
```

### View Progress
```bash
# Migration creates log file
tail -f migration_20240115_143022.log

# Check checkpoint
cat migration_checkpoint.json
```

## ⚡ Performance Tips

- **Small entities**: `--batch-size 5000`
- **Large entities**: `--batch-size 500`
- **Single entity**: `--entity customer` (faster testing)
- **Resume**: Use checkpoint if interrupted

## ✅ Validation

```bash
# Post-migration validation
python manage.py migrate_legacy_data --validate

# Manual check (Django shell)
python manage.py shell
>>> from customers.models import Customer
>>> Customer.objects.count()
1234
```

## 🔄 Rollback

### Before migration
```bash
pg_dump abis_modern > backup.sql
```

### Restore if needed
```bash
psql abis_modern < backup.sql
```

## 📈 Expected Timeline

- **Carriers**: ~5 seconds
- **Lines**: ~3 seconds
- **Customers**: ~30 seconds
- **Coils**: ~5 minutes
- **Jobs**: ~3 minutes
- **Skids**: ~1 minute
- **QA**: ~2 minutes
- **Shipments**: ~1 minute

**Total**: ~12-15 minutes for complete migration

## 📞 Support

See full documentation: `migration/README.md`
