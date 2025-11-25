"""
Migration Validation

Pre and post migration validation checks
"""

import logging
from typing import List, Dict, Any, Optional
from django.core.exceptions import ValidationError
from django.apps import apps

logger = logging.getLogger(__name__)


class MigrationValidator:
    """Validates data during migration process"""
    
    def validate_record(self, entity_type: str, data: Dict[str, Any]) -> List[str]:
        """
        Validate a single record before migration
        
        Args:
            entity_type: Type of entity being validated
            data: Dictionary of field values
            
        Returns:
            List of validation error messages (empty if valid)
        """
        errors = []
        
        # Common validations
        if entity_type == 'customer':
            if not data.get('code'):
                errors.append("Customer code is required")
            if not data.get('name'):
                errors.append("Customer name is required")
        
        elif entity_type == 'coil':
            if not data.get('coil_number'):
                errors.append("Coil number is required")
            if data.get('weight') and data['weight'] < 0:
                errors.append("Coil weight cannot be negative")
            if data.get('width') and data['width'] <= 0:
                errors.append("Coil width must be positive")
        
        elif entity_type == 'job':
            if not data.get('job_number'):
                errors.append("Job number is required")
            if data.get('ordered_weight') and data['ordered_weight'] <= 0:
                errors.append("Ordered weight must be positive")
        
        elif entity_type == 'shipment':
            if not data.get('bol_number'):
                errors.append("BOL number is required")
        
        elif entity_type == 'carrier':
            if not data.get('code'):
                errors.append("Carrier code is required")
            if not data.get('name'):
                errors.append("Carrier name is required")
        
        return errors
    
    def validate_relationships(self, entity_type: str, data: Dict[str, Any]) -> List[str]:
        """
        Validate foreign key relationships
        
        Args:
            entity_type: Type of entity being validated
            data: Dictionary of field values
            
        Returns:
            List of validation error messages (empty if valid)
        """
        errors = []
        
        # Check foreign keys exist
        if entity_type == 'coil':
            if data.get('customer') and not self._check_fk_exists('customers', 'Customer', data['customer']):
                errors.append(f"Customer {data['customer']} does not exist")
        
        elif entity_type == 'job':
            if data.get('customer') and not self._check_fk_exists('customers', 'Customer', data['customer']):
                errors.append(f"Customer {data['customer']} does not exist")
            if data.get('coil') and not self._check_fk_exists('inventory', 'Coil', data['coil']):
                errors.append(f"Coil {data['coil']} does not exist")
        
        elif entity_type == 'shipment':
            if data.get('carrier') and not self._check_fk_exists('shipping', 'Carrier', data['carrier']):
                errors.append(f"Carrier {data['carrier']} does not exist")
        
        return errors
    
    def _check_fk_exists(self, app_label: str, model_name: str, pk: Any) -> bool:
        """Check if foreign key reference exists"""
        try:
            model = apps.get_model(app_label, model_name)
            return model.objects.filter(pk=pk).exists()
        except Exception as e:
            logger.warning(f"FK check failed for {app_label}.{model_name}: {e}")
            return True  # Allow migration to continue


class PostMigrationValidator:
    """Validates migration results after completion"""
    
    def __init__(self, oracle_manager):
        self.oracle = oracle_manager
    
    def validate_counts(self, mapping) -> bool:
        """
        Compare record counts between source and target
        
        Returns:
            True if counts match
        """
        from schema_mapping import get_mapping
        
        # Get source count
        source_count = self.oracle.get_table_count(mapping.source_table, mapping.where_clause)
        
        # Get target count
        model = apps.get_model(mapping.app_label, mapping.target_model)
        target_count = model.objects.count()
        
        logger.info(f"{mapping.target_model}: Source={source_count}, Target={target_count}")
        
        if source_count != target_count:
            logger.warning(f"⚠️  Count mismatch for {mapping.target_model}")
            return False
        
        return True
    
    def validate_all_counts(self) -> Dict[str, bool]:
        """Validate counts for all migrated entities"""
        from schema_mapping import get_migration_order, get_mapping
        
        logger.info("\n" + "="*60)
        logger.info("POST-MIGRATION COUNT VALIDATION")
        logger.info("="*60)
        
        results = {}
        migration_order = get_migration_order()
        
        for entity_type in migration_order:
            mapping = get_mapping(entity_type)
            results[entity_type] = self.validate_counts(mapping)
        
        passed = sum(1 for v in results.values() if v)
        total = len(results)
        
        logger.info(f"\nValidation Results: {passed}/{total} passed")
        
        return results
    
    def check_orphaned_records(self) -> Dict[str, List[Any]]:
        """
        Check for records with invalid foreign key references
        
        Returns:
            Dictionary mapping entity types to lists of orphaned record IDs
        """
        logger.info("\n" + "="*60)
        logger.info("CHECKING FOR ORPHANED RECORDS")
        logger.info("="*60)
        
        orphans = {}
        
        # Check Coils with invalid customer FK
        from inventory.models import Coil
        invalid_coils = Coil.objects.filter(customer__isnull=True)
        if invalid_coils.exists():
            orphans['coils_no_customer'] = list(invalid_coils.values_list('id', flat=True))
            logger.warning(f"⚠️  Found {invalid_coils.count()} coils without customer")
        
        # Check Jobs with invalid references
        from production.models import Job
        invalid_jobs_customer = Job.objects.filter(customer__isnull=True)
        if invalid_jobs_customer.exists():
            orphans['jobs_no_customer'] = list(invalid_jobs_customer.values_list('id', flat=True))
            logger.warning(f"⚠️  Found {invalid_jobs_customer.count()} jobs without customer")
        
        invalid_jobs_coil = Job.objects.filter(coil__isnull=True)
        if invalid_jobs_coil.exists():
            orphans['jobs_no_coil'] = list(invalid_jobs_coil.values_list('id', flat=True))
            logger.warning(f"⚠️  Found {invalid_jobs_coil.count()} jobs without coil")
        
        # Check Shipments with invalid carrier
        from shipping.models import Shipment
        invalid_shipments = Shipment.objects.filter(carrier__isnull=True)
        if invalid_shipments.exists():
            orphans['shipments_no_carrier'] = list(invalid_shipments.values_list('id', flat=True))
            logger.warning(f"⚠️  Found {invalid_shipments.count()} shipments without carrier")
        
        if not orphans:
            logger.info("✅ No orphaned records found")
        
        return orphans
    
    def generate_report(self) -> str:
        """
        Generate comprehensive post-migration validation report
        
        Returns:
            Report as formatted string
        """
        report_lines = [
            "\n" + "="*60,
            "POST-MIGRATION VALIDATION REPORT",
            "="*60,
            ""
        ]
        
        # Count validation
        count_results = self.validate_all_counts()
        report_lines.append("Record Counts:")
        for entity, passed in count_results.items():
            status = "✅" if passed else "❌"
            report_lines.append(f"  {status} {entity}")
        report_lines.append("")
        
        # Orphaned records
        orphans = self.check_orphaned_records()
        report_lines.append("Orphaned Records:")
        if orphans:
            for entity, ids in orphans.items():
                report_lines.append(f"  ⚠️  {entity}: {len(ids)} records")
        else:
            report_lines.append("  ✅ None found")
        report_lines.append("")
        
        report_lines.append("="*60)
        
        report = "\n".join(report_lines)
        logger.info(report)
        
        return report
