"""
Data Migration Orchestrator

Main script to migrate legacy ABIS data from Oracle 11g to Django models.
"""

import os
import sys
import django
import logging
from datetime import datetime
from typing import Dict, List, Optional, Set
import json
from pathlib import Path

# Setup Django
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'abis_modern.settings')
django.setup()

from django.db import transaction
from django.apps import apps
from oracle_connection import OracleConnectionManager
from schema_mapping import get_mapping, get_migration_order
from validation import MigrationValidator
from progress import ProgressTracker

logger = logging.getLogger(__name__)


class MigrationOrchestrator:
    """Orchestrates the complete data migration process"""
    
    def __init__(
        self,
        oracle_manager: OracleConnectionManager,
        checkpoint_file: str = 'migration_checkpoint.json',
        batch_size: int = 1000,
        dry_run: bool = False
    ):
        self.oracle = oracle_manager
        self.checkpoint_file = checkpoint_file
        self.batch_size = batch_size
        self.dry_run = dry_run
        self.validator = MigrationValidator()
        self.progress = ProgressTracker()
        self.migrated_ids: Dict[str, Set[str]] = {}
        
        # Load checkpoint if exists
        self.load_checkpoint()
    
    def load_checkpoint(self):
        """Load migration checkpoint from file"""
        if os.path.exists(self.checkpoint_file):
            try:
                with open(self.checkpoint_file, 'r') as f:
                    data = json.load(f)
                    self.migrated_ids = {k: set(v) for k, v in data.get('migrated_ids', {}).items()}
                    logger.info(f"Loaded checkpoint: {sum(len(ids) for ids in self.migrated_ids.values())} records previously migrated")
            except Exception as e:
                logger.warning(f"Failed to load checkpoint: {e}")
    
    def save_checkpoint(self):
        """Save migration checkpoint to file"""
        try:
            data = {
                'migrated_ids': {k: list(v) for k, v in self.migrated_ids.items()},
                'timestamp': datetime.now().isoformat()
            }
            with open(self.checkpoint_file, 'w') as f:
                json.dump(data, f, indent=2)
            logger.debug("Checkpoint saved")
        except Exception as e:
            logger.error(f"Failed to save checkpoint: {e}")
    
    def is_already_migrated(self, entity_type: str, record_id: str) -> bool:
        """Check if a record has already been migrated"""
        return entity_type in self.migrated_ids and record_id in self.migrated_ids[entity_type]
    
    def mark_as_migrated(self, entity_type: str, record_id: str):
        """Mark a record as migrated"""
        if entity_type not in self.migrated_ids:
            self.migrated_ids[entity_type] = set()
        self.migrated_ids[entity_type].add(record_id)
    
    def migrate_entity_type(self, entity_type: str) -> Dict[str, int]:
        """
        Migrate all records for a single entity type
        
        Returns:
            Dictionary with migration statistics
        """
        mapping = get_mapping(entity_type)
        model = apps.get_model(mapping.app_label, mapping.target_model)
        
        logger.info(f"\n{'='*60}")
        logger.info(f"Migrating {entity_type}: {mapping.source_table} -> {mapping.target_model}")
        logger.info(f"{'='*60}")
        
        stats = {
            'total': 0,
            'migrated': 0,
            'skipped': 0,
            'failed': 0,
            'errors': []
        }
        
        # Get total count
        total_count = self.oracle.get_table_count(mapping.source_table, mapping.where_clause)
        logger.info(f"Total records in source: {total_count}")
        
        if total_count == 0:
            logger.warning(f"No records found in {mapping.source_table}")
            return stats
        
        stats['total'] = total_count
        
        # Initialize progress tracker
        self.progress.start(entity_type, total_count)
        
        # Fetch and migrate in batches
        query = mapping.get_select_query()
        
        for batch in self.oracle.execute_query_batched(query, batch_size=self.batch_size):
            batch_records = []
            
            for source_row in batch:
                try:
                    # Get primary key value
                    pk_value = str(source_row[mapping.primary_key_field])
                    
                    # Skip if already migrated
                    if self.is_already_migrated(entity_type, pk_value):
                        stats['skipped'] += 1
                        self.progress.update(1)
                        continue
                    
                    # Transform data
                    target_data = mapping.transform_row(source_row)
                    
                    # Validate (optional)
                    validation_errors = self.validator.validate_record(entity_type, target_data)
                    if validation_errors:
                        logger.warning(f"Validation errors for {pk_value}: {validation_errors}")
                        # Continue anyway unless critical
                    
                    # Prepare for bulk creation
                    if not self.dry_run:
                        batch_records.append(model(**target_data))
                    
                    self.mark_as_migrated(entity_type, pk_value)
                    stats['migrated'] += 1
                    
                except Exception as e:
                    error_msg = f"Failed to process record {source_row.get(mapping.primary_key_field)}: {e}"
                    logger.error(error_msg)
                    stats['failed'] += 1
                    stats['errors'].append(error_msg)
                
                self.progress.update(1)
            
            # Bulk create batch
            if batch_records and not self.dry_run:
                try:
                    with transaction.atomic():
                        model.objects.bulk_create(batch_records, ignore_conflicts=True)
                    logger.info(f"Inserted batch of {len(batch_records)} records")
                except Exception as e:
                    logger.error(f"Failed to insert batch: {e}")
                    stats['failed'] += len(batch_records)
            
            # Save checkpoint after each batch
            self.save_checkpoint()
        
        self.progress.finish()
        
        logger.info(f"\n{entity_type.upper()} Migration Summary:")
        logger.info(f"  Total:    {stats['total']}")
        logger.info(f"  Migrated: {stats['migrated']}")
        logger.info(f"  Skipped:  {stats['skipped']}")
        logger.info(f"  Failed:   {stats['failed']}")
        
        return stats
    
    def migrate_all(self) -> Dict[str, Dict[str, int]]:
        """
        Migrate all entity types in order
        
        Returns:
            Dictionary mapping entity types to their migration statistics
        """
        logger.info("\n" + "="*60)
        logger.info("STARTING FULL MIGRATION")
        logger.info("="*60)
        logger.info(f"Dry run: {self.dry_run}")
        logger.info(f"Batch size: {self.batch_size}")
        
        all_stats = {}
        migration_order = get_migration_order()
        
        for entity_type in migration_order:
            try:
                stats = self.migrate_entity_type(entity_type)
                all_stats[entity_type] = stats
            except Exception as e:
                logger.error(f"Failed to migrate {entity_type}: {e}")
                all_stats[entity_type] = {
                    'total': 0,
                    'migrated': 0,
                    'skipped': 0,
                    'failed': 0,
                    'errors': [str(e)]
                }
        
        # Final summary
        logger.info("\n" + "="*60)
        logger.info("MIGRATION COMPLETE")
        logger.info("="*60)
        
        total_records = sum(s['total'] for s in all_stats.values())
        total_migrated = sum(s['migrated'] for s in all_stats.values())
        total_failed = sum(s['failed'] for s in all_stats.values())
        
        logger.info(f"\nOverall Summary:")
        logger.info(f"  Total records:    {total_records}")
        logger.info(f"  Successfully migrated: {total_migrated}")
        logger.info(f"  Failed:           {total_failed}")
        logger.info(f"  Success rate:     {(total_migrated/total_records*100):.2f}%" if total_records > 0 else "  Success rate: N/A")
        
        return all_stats
    
    def run_pre_migration_checks(self) -> bool:
        """
        Run pre-migration validation checks
        
        Returns:
            True if all checks pass, False otherwise
        """
        logger.info("\n" + "="*60)
        logger.info("PRE-MIGRATION CHECKS")
        logger.info("="*60)
        
        checks_passed = True
        
        # Check Oracle connection
        logger.info("\n1. Testing Oracle connection...")
        if not self.oracle.test_connection():
            logger.error("❌ Oracle connection failed")
            checks_passed = False
        else:
            logger.info("✅ Oracle connection successful")
        
        # Check source tables exist
        logger.info("\n2. Checking source tables...")
        migration_order = get_migration_order()
        for entity_type in migration_order:
            mapping = get_mapping(entity_type)
            try:
                count = self.oracle.get_table_count(mapping.source_table)
                logger.info(f"✅ {mapping.source_table}: {count} records")
            except Exception as e:
                logger.error(f"❌ {mapping.source_table}: {e}")
                checks_passed = False
        
        # Check Django models
        logger.info("\n3. Checking Django models...")
        for entity_type in migration_order:
            mapping = get_mapping(entity_type)
            try:
                model = apps.get_model(mapping.app_label, mapping.target_model)
                logger.info(f"✅ {mapping.app_label}.{mapping.target_model}")
            except Exception as e:
                logger.error(f"❌ {mapping.app_label}.{mapping.target_model}: {e}")
                checks_passed = False
        
        logger.info("\n" + "="*60)
        if checks_passed:
            logger.info("✅ All pre-migration checks passed")
        else:
            logger.error("❌ Some pre-migration checks failed")
        logger.info("="*60)
        
        return checks_passed


def main():
    """Main migration entry point"""
    import argparse
    
    parser = argparse.ArgumentParser(description='Migrate legacy ABIS data from Oracle to Django')
    parser.add_argument('--dry-run', action='store_true', help='Perform dry run without writing to database')
    parser.add_argument('--batch-size', type=int, default=1000, help='Batch size for bulk inserts')
    parser.add_argument('--entity', type=str, help='Migrate only specific entity type')
    parser.add_argument('--check-only', action='store_true', help='Run pre-migration checks only')
    parser.add_argument('--verbose', action='store_true', help='Enable verbose logging')
    
    args = parser.parse_args()
    
    # Configure logging
    log_level = logging.DEBUG if args.verbose else logging.INFO
    logging.basicConfig(
        level=log_level,
        format='%(asctime)s [%(levelname)s] %(message)s',
        handlers=[
            logging.FileHandler(f'migration_{datetime.now().strftime("%Y%m%d_%H%M%S")}.log'),
            logging.StreamHandler()
        ]
    )
    
    try:
        # Initialize Oracle connection
        logger.info("Initializing Oracle connection...")
        oracle_manager = OracleConnectionManager()
        
        # Initialize orchestrator
        orchestrator = MigrationOrchestrator(
            oracle_manager=oracle_manager,
            batch_size=args.batch_size,
            dry_run=args.dry_run
        )
        
        # Run pre-migration checks
        if not orchestrator.run_pre_migration_checks():
            logger.error("Pre-migration checks failed. Aborting migration.")
            sys.exit(1)
        
        if args.check_only:
            logger.info("Check-only mode. Exiting.")
            sys.exit(0)
        
        # Run migration
        if args.entity:
            # Migrate single entity
            logger.info(f"\nMigrating single entity: {args.entity}")
            stats = orchestrator.migrate_entity_type(args.entity)
        else:
            # Migrate all entities
            stats = orchestrator.migrate_all()
        
        # Close Oracle connection
        oracle_manager.close_pool()
        
        logger.info("\n✅ Migration completed successfully!")
        
    except KeyboardInterrupt:
        logger.warning("\n⚠️  Migration interrupted by user")
        sys.exit(1)
    except Exception as e:
        logger.error(f"\n❌ Migration failed: {e}", exc_info=True)
        sys.exit(1)


if __name__ == "__main__":
    main()
