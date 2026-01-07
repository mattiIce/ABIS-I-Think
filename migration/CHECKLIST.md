# Migration Checklist

Pre-migration, migration, and post-migration tasks.

## ☐ Pre-Migration (Setup)

### Environment Setup
- [ ] Virtual environment activated
- [ ] `cx_Oracle` installed: `pip install cx_Oracle`
- [ ] Oracle Instant Client configured (if needed)
- [ ] `.env` file configured with Oracle credentials
- [ ] Network connectivity to Solaris server verified

### Database Preparation
- [ ] PostgreSQL database created and migrated
- [ ] Django models verified: `python manage.py check`
- [ ] Database backup created: `pg_dump abis_modern > backup.sql`
- [ ] Oracle user has SELECT permissions on all source tables

### Pre-Flight Checks
- [ ] Connection test passed: `python manage.py migrate_legacy_data --check-only`
- [ ] Source tables accessible and record counts visible
- [ ] Django models load without errors
- [ ] Disk space sufficient (estimate: source DB size × 1.5)

## ☐ Migration (Execution)

### Testing Phase
- [ ] Dry run completed successfully: `--dry-run`
- [ ] Small entity migrated as test: `--entity carrier`
- [ ] Results validated manually in Django admin
- [ ] Migration logs reviewed for warnings/errors

### Production Migration
- [ ] Team notified of migration start
- [ ] Database backup confirmed recent
- [ ] Full migration initiated: `python manage.py migrate_legacy_data --validate`
- [ ] Progress monitored in real-time
- [ ] Checkpoint file saving successfully

### During Migration
- [ ] No critical errors in logs
- [ ] Progress bar advancing steadily
- [ ] Batch inserts completing successfully
- [ ] Foreign key relationships being created

## ☐ Post-Migration (Validation)

### Automated Validation
- [ ] Post-migration validation passed (if `--validate` used)
- [ ] Record counts match between source and target
- [ ] No orphaned records detected
- [ ] All entity types migrated successfully

### Manual Verification
- [ ] Django admin accessible
- [ ] Sample records visible in admin
- [ ] Foreign key relationships intact
- [ ] Date/time fields formatted correctly
- [ ] Decimal/numeric fields accurate

### Data Quality Checks
```bash
python manage.py shell
```
```python
from customers.models import Customer
from inventory.models import Coil
from production.models import Job
from shipping.models import Shipment

# Record counts
print(f"Customers: {Customer.objects.count()}")
print(f"Coils: {Coil.objects.count()}")
print(f"Jobs: {Job.objects.count()}")
print(f"Shipments: {Shipment.objects.count()}")

# Sample data inspection
customer = Customer.objects.first()
print(f"Customer: {customer.code} - {customer.name}")
print(f"Phone: {customer.phone}")
print(f"Email: {customer.email}")

coil = Coil.objects.first()
print(f"Coil: {coil.coil_number}")
print(f"Weight: {coil.weight}")
print(f"Customer: {coil.customer}")

job = Job.objects.first()
print(f"Job: {job.job_number}")
print(f"Customer: {job.customer}")
print(f"Coil: {job.coil}")

# Foreign key integrity
jobs_without_customer = Job.objects.filter(customer__isnull=True).count()
jobs_without_coil = Job.objects.filter(coil__isnull=True).count()
print(f"Jobs without customer: {jobs_without_customer}")
print(f"Jobs without coil: {jobs_without_coil}")
```

### Application Testing
- [ ] Django admin CRUD operations working
- [ ] API endpoints returning data
- [ ] Frontend pages loading migrated data
- [ ] Search/filter functionality working
- [ ] Reports generating correctly

## ☐ Finalization

### Documentation
- [ ] Migration log saved and archived
- [ ] Checkpoint file backed up
- [ ] Any data quality issues documented
- [ ] Migration statistics recorded

### Cleanup
- [ ] Temporary migration files removed (optional)
- [ ] Oracle connection pool closed
- [ ] Log files archived
- [ ] Team notified of completion

### Go-Live Preparation
- [ ] Legacy PowerBuilder system still accessible (backup)
- [ ] Cutover plan documented
- [ ] Rollback procedure tested
- [ ] Support team trained on new system

## 📊 Success Criteria

✅ **Migration considered successful if:**
- All record counts match (source vs target)
- No critical errors in logs
- Foreign key relationships intact
- Sample data spot-checks pass
- Application functionality verified
- Success rate ≥ 99%

⚠️ **Warning signs to investigate:**
- Count mismatches > 1%
- Orphaned records detected
- Validation errors > 5%
- Foreign key constraint violations
- Unexpected NULL values

❌ **Rollback if:**
- Data corruption detected
- Critical functionality broken
- Foreign key integrity compromised
- Success rate < 95%

## 📈 Migration Metrics

Track these metrics for reporting:

```
Start Time:        _________________
End Time:          _________________
Total Duration:    _________________

Records Migrated:
  Carriers:        _____ / _____
  Lines:           _____ / _____
  Customers:       _____ / _____
  Coils:           _____ / _____
  Jobs:            _____ / _____
  Skids:           _____ / _____
  QA Results:      _____ / _____
  Shipments:       _____ / _____
  
  TOTAL:           _____ / _____

Success Rate:      _____%
Failed Records:    _____
Warnings:          _____
Errors:            _____
```

## 🔄 Rollback Plan

If rollback needed:

```bash
# Stop application
sudo systemctl stop abis_modern

# Restore database
psql abis_modern < backup.sql

# Verify restoration
python manage.py shell
>>> from customers.models import Customer
>>> Customer.objects.count()  # Should be 0 or old count

# Restart application
sudo systemctl start abis_modern
```

## 📞 Emergency Contacts

- **Database Admin**: _______________
- **System Admin**: _______________
- **Development Lead**: _______________
- **Oracle Admin (Solaris)**: _______________

---

**Migration Date**: _______________  
**Performed By**: _______________  
**Approved By**: _______________
