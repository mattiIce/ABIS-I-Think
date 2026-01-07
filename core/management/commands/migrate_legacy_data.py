"""
Django Management Command for Data Migration

Usage:
    python manage.py migrate_legacy_data [options]
"""

import logging
from django.core.management.base import BaseCommand, CommandError
from django.db import transaction
from migration.oracle_connection import OracleConnectionManager
from migration.migrate import MigrationOrchestrator
from migration.validation import PostMigrationValidator


class Command(BaseCommand):
    help = 'Migrate legacy ABIS data from Oracle 11g to Django models'

    def add_arguments(self, parser):
        parser.add_argument(
            '--dry-run',
            action='store_true',
            help='Perform dry run without writing to database'
        )
        parser.add_argument(
            '--batch-size',
            type=int,
            default=1000,
            help='Batch size for bulk inserts (default: 1000)'
        )
        parser.add_argument(
            '--entity',
            type=str,
            help='Migrate only specific entity type (e.g., customer, coil, job)'
        )
        parser.add_argument(
            '--check-only',
            action='store_true',
            help='Run pre-migration checks only'
        )
        parser.add_argument(
            '--validate',
            action='store_true',
            help='Run post-migration validation after completion'
        )
        parser.add_argument(
            '--resume',
            action='store_true',
            help='Resume from last checkpoint'
        )

    def handle(self, *args, **options):
        # Configure logging
        log_level = logging.DEBUG if options['verbosity'] > 1 else logging.INFO
        logging.basicConfig(
            level=log_level,
            format='%(asctime)s [%(levelname)s] %(message)s'
        )
        logger = logging.getLogger(__name__)

        try:
            # Initialize Oracle connection
            self.stdout.write("Initializing Oracle connection...")
            oracle_manager = OracleConnectionManager()

            # Initialize orchestrator
            orchestrator = MigrationOrchestrator(
                oracle_manager=oracle_manager,
                batch_size=options['batch_size'],
                dry_run=options['dry_run']
            )

            # Run pre-migration checks
            if not orchestrator.run_pre_migration_checks():
                raise CommandError("Pre-migration checks failed")

            if options['check_only']:
                self.stdout.write(self.style.SUCCESS("✅ All checks passed"))
                return

            # Confirm before proceeding (unless dry-run)
            if not options['dry_run']:
                confirm = input("\n⚠️  This will modify the database. Continue? (yes/no): ")
                if confirm.lower() != 'yes':
                    self.stdout.write(self.style.WARNING("Migration cancelled"))
                    return

            # Run migration
            if options['entity']:
                self.stdout.write(f"\nMigrating single entity: {options['entity']}")
                stats = orchestrator.migrate_entity_type(options['entity'])
            else:
                stats = orchestrator.migrate_all()

            # Post-migration validation
            if options['validate'] and not options['dry_run']:
                self.stdout.write("\nRunning post-migration validation...")
                validator = PostMigrationValidator(oracle_manager)
                report = validator.generate_report()

            # Close Oracle connection
            oracle_manager.close_pool()

            self.stdout.write(self.style.SUCCESS("\n✅ Migration completed successfully!"))

        except KeyboardInterrupt:
            self.stdout.write(self.style.WARNING("\n⚠️  Migration interrupted by user"))
            raise CommandError("Migration interrupted")
        except Exception as e:
            logger.error(f"Migration failed: {e}", exc_info=True)
            raise CommandError(f"Migration failed: {e}")
