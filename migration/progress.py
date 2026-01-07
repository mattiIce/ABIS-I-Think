"""
Progress Tracking

Track and display migration progress
"""

import sys
import time
from datetime import datetime, timedelta
from typing import Optional


class ProgressTracker:
    """Tracks and displays migration progress"""
    
    def __init__(self):
        self.entity_type: Optional[str] = None
        self.total: int = 0
        self.current: int = 0
        self.start_time: Optional[datetime] = None
        self.last_update_time: Optional[datetime] = None
    
    def start(self, entity_type: str, total: int):
        """Start tracking progress for an entity type"""
        self.entity_type = entity_type
        self.total = total
        self.current = 0
        self.start_time = datetime.now()
        self.last_update_time = self.start_time
        self._print_progress()
    
    def update(self, count: int = 1):
        """Update progress counter"""
        self.current += count
        
        # Only update display every second to avoid overwhelming terminal
        now = datetime.now()
        if (now - self.last_update_time).total_seconds() >= 1.0:
            self._print_progress()
            self.last_update_time = now
    
    def finish(self):
        """Finish tracking and print final progress"""
        self.current = self.total
        self._print_progress()
        sys.stdout.write("\n")
        sys.stdout.flush()
    
    def _print_progress(self):
        """Print progress bar to terminal"""
        if self.total == 0:
            return
        
        percent = (self.current / self.total) * 100
        elapsed = (datetime.now() - self.start_time).total_seconds()
        
        # Calculate ETA
        if self.current > 0:
            rate = self.current / elapsed
            remaining = (self.total - self.current) / rate
            eta_str = self._format_time(remaining)
        else:
            eta_str = "calculating..."
        
        # Create progress bar
        bar_length = 40
        filled = int(bar_length * self.current / self.total)
        bar = '█' * filled + '░' * (bar_length - filled)
        
        # Format output
        elapsed_str = self._format_time(elapsed)
        output = f"\r{self.entity_type}: [{bar}] {percent:.1f}% ({self.current}/{self.total}) | Elapsed: {elapsed_str} | ETA: {eta_str}"
        
        sys.stdout.write(output)
        sys.stdout.flush()
    
    @staticmethod
    def _format_time(seconds: float) -> str:
        """Format seconds as human-readable time"""
        if seconds < 60:
            return f"{int(seconds)}s"
        elif seconds < 3600:
            minutes = int(seconds / 60)
            secs = int(seconds % 60)
            return f"{minutes}m {secs}s"
        else:
            hours = int(seconds / 3600)
            minutes = int((seconds % 3600) / 60)
            return f"{hours}h {minutes}m"


class MigrationLogger:
    """Enhanced logger with statistics tracking"""
    
    def __init__(self):
        self.stats = {
            'start_time': None,
            'end_time': None,
            'entities_processed': 0,
            'total_records': 0,
            'successful': 0,
            'failed': 0,
            'skipped': 0,
            'errors': []
        }
    
    def start_migration(self):
        """Mark migration start"""
        self.stats['start_time'] = datetime.now()
    
    def end_migration(self):
        """Mark migration end"""
        self.stats['end_time'] = datetime.now()
    
    def log_entity_stats(self, entity_type: str, stats: dict):
        """Log statistics for an entity migration"""
        self.stats['entities_processed'] += 1
        self.stats['total_records'] += stats.get('total', 0)
        self.stats['successful'] += stats.get('migrated', 0)
        self.stats['failed'] += stats.get('failed', 0)
        self.stats['skipped'] += stats.get('skipped', 0)
        
        if stats.get('errors'):
            self.stats['errors'].extend([
                f"{entity_type}: {error}" for error in stats['errors']
            ])
    
    def get_summary(self) -> dict:
        """Get migration summary statistics"""
        duration = None
        if self.stats['start_time'] and self.stats['end_time']:
            duration = (self.stats['end_time'] - self.stats['start_time']).total_seconds()
        
        return {
            **self.stats,
            'duration_seconds': duration,
            'success_rate': (self.stats['successful'] / self.stats['total_records'] * 100) 
                           if self.stats['total_records'] > 0 else 0
        }
    
    def print_summary(self):
        """Print formatted migration summary"""
        summary = self.get_summary()
        
        print("\n" + "="*60)
        print("MIGRATION SUMMARY")
        print("="*60)
        print(f"Start time:         {summary['start_time'].strftime('%Y-%m-%d %H:%M:%S')}")
        print(f"End time:           {summary['end_time'].strftime('%Y-%m-%d %H:%M:%S')}")
        
        if summary['duration_seconds']:
            duration_str = ProgressTracker._format_time(summary['duration_seconds'])
            print(f"Duration:           {duration_str}")
        
        print(f"\nEntities processed: {summary['entities_processed']}")
        print(f"Total records:      {summary['total_records']}")
        print(f"Successful:         {summary['successful']}")
        print(f"Failed:             {summary['failed']}")
        print(f"Skipped:            {summary['skipped']}")
        print(f"Success rate:       {summary['success_rate']:.2f}%")
        
        if summary['errors']:
            print(f"\nErrors encountered: {len(summary['errors'])}")
            print("\nFirst 10 errors:")
            for error in summary['errors'][:10]:
                print(f"  - {error}")
        
        print("="*60)
