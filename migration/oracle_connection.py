"""
Oracle Database Connection Manager for Legacy ABIS Data Migration

Handles connections to Oracle 11g on Solaris 10 using cx_Oracle.
Provides connection pooling, error handling, and query execution utilities.
"""

import cx_Oracle
import os
from typing import Optional, List, Dict, Any
from contextlib import contextmanager
import logging

logger = logging.getLogger(__name__)


class OracleConnectionManager:
    """Manages connections to legacy Oracle 11g database"""
    
    def __init__(
        self,
        username: Optional[str] = None,
        password: Optional[str] = None,
        host: Optional[str] = None,
        port: Optional[int] = None,
        service_name: Optional[str] = None,
        tns_name: Optional[str] = None,
        min_pool_size: int = 2,
        max_pool_size: int = 10,
        increment: int = 1
    ):
        """
        Initialize Oracle connection manager
        
        Args:
            username: Oracle username (or use ORACLE_USER env var, default: dbo)
            password: Oracle password (or use ORACLE_PASSWORD env var, default: obd#157)
            host: Oracle server host (or use ORACLE_HOST env var)
            port: Oracle port (or use ORACLE_PORT env var, default 1521)
            service_name: Oracle service name (or use ORACLE_SERVICE env var)
            tns_name: TNS name from tnsnames.ora (or use ORACLE_TNS_NAME env var)
            min_pool_size: Minimum connections in pool
            max_pool_size: Maximum connections in pool
            increment: Connection pool increment
        """
        self.username = username or os.getenv('ORACLE_USER', 'dbo')
        self.password = password or os.getenv('ORACLE_PASSWORD', 'obd#157')
        self.tns_name = tns_name or os.getenv('ORACLE_TNS_NAME')
        self.host = host or os.getenv('ORACLE_HOST')
        self.port = port or int(os.getenv('ORACLE_PORT', '1521'))
        self.service_name = service_name or os.getenv('ORACLE_SERVICE')
        
        if not self.password:
            raise ValueError("Oracle password must be provided or set in ORACLE_PASSWORD env var")
        
        # Build DSN - prefer TNS name if provided
        if self.tns_name:
            self.dsn = self.tns_name
            logger.info(f"Oracle connection configured using TNS: {self.username}@{self.tns_name}")
        elif self.host and self.service_name:
            self.dsn = cx_Oracle.makedsn(self.host, self.port, service_name=self.service_name)
            logger.info(f"Oracle connection configured: {self.username}@{self.host}:{self.port}/{self.service_name}")
        else:
            raise ValueError("Must provide either tns_name or both host and service_name")
        
        self.pool = None
        self.min_pool_size = min_pool_size
        self.max_pool_size = max_pool_size
        self.increment = increment
    
    def create_pool(self):
        """Create connection pool"""
        try:
            self.pool = cx_Oracle.SessionPool(
                user=self.username,
                password=self.password,
                dsn=self.dsn,
                min=self.min_pool_size,
                max=self.max_pool_size,
                increment=self.increment,
                threaded=True,
                encoding="UTF-8"
            )
            logger.info(f"Connection pool created: {self.min_pool_size}-{self.max_pool_size} connections")
        except cx_Oracle.DatabaseError as e:
            logger.error(f"Failed to create connection pool: {e}")
            raise
    
    def close_pool(self):
        """Close connection pool"""
        if self.pool:
            self.pool.close()
            self.pool = None
            logger.info("Connection pool closed")
    
    @contextmanager
    def get_connection(self):
        """
        Get a connection from the pool (context manager)
        
        Usage:
            with manager.get_connection() as conn:
                cursor = conn.cursor()
                cursor.execute("SELECT * FROM table")
        """
        if not self.pool:
            self.create_pool()
        
        conn = self.pool.acquire()
        try:
            yield conn
        finally:
            self.pool.release(conn)
    
    def execute_query(self, query: str, params: Optional[Dict[str, Any]] = None) -> List[Dict[str, Any]]:
        """
        Execute a SELECT query and return results as list of dictionaries
        
        Args:
            query: SQL SELECT query
            params: Query parameters dictionary
        
        Returns:
            List of dictionaries with column names as keys
        """
        with self.get_connection() as conn:
            cursor = conn.cursor()
            try:
                if params:
                    cursor.execute(query, params)
                else:
                    cursor.execute(query)
                
                # Get column names
                columns = [desc[0].lower() for desc in cursor.description]
                
                # Fetch all results
                results = []
                for row in cursor:
                    results.append(dict(zip(columns, row)))
                
                logger.debug(f"Query returned {len(results)} rows")
                return results
                
            except cx_Oracle.DatabaseError as e:
                logger.error(f"Query execution failed: {e}")
                logger.error(f"Query: {query}")
                raise
            finally:
                cursor.close()
    
    def execute_query_batched(
        self,
        query: str,
        params: Optional[Dict[str, Any]] = None,
        batch_size: int = 1000
    ):
        """
        Execute a SELECT query and yield results in batches
        
        Args:
            query: SQL SELECT query
            params: Query parameters dictionary
            batch_size: Number of rows per batch
        
        Yields:
            Lists of dictionaries (batches)
        """
        with self.get_connection() as conn:
            cursor = conn.cursor()
            cursor.arraysize = batch_size
            
            try:
                if params:
                    cursor.execute(query, params)
                else:
                    cursor.execute(query)
                
                # Get column names
                columns = [desc[0].lower() for desc in cursor.description]
                
                # Fetch in batches
                while True:
                    rows = cursor.fetchmany(batch_size)
                    if not rows:
                        break
                    
                    batch = [dict(zip(columns, row)) for row in rows]
                    logger.debug(f"Fetched batch of {len(batch)} rows")
                    yield batch
                    
            except cx_Oracle.DatabaseError as e:
                logger.error(f"Batched query execution failed: {e}")
                logger.error(f"Query: {query}")
                raise
            finally:
                cursor.close()
    
    def get_table_count(self, table_name: str, where_clause: Optional[str] = None) -> int:
        """
        Get row count for a table
        
        Args:
            table_name: Name of the table
            where_clause: Optional WHERE clause (without WHERE keyword)
        
        Returns:
            Row count
        """
        query = f"SELECT COUNT(*) as count FROM {table_name}"
        if where_clause:
            query += f" WHERE {where_clause}"
        
        result = self.execute_query(query)
        return result[0]['count'] if result else 0
    
    def test_connection(self) -> bool:
        """
        Test database connection
        
        Returns:
            True if connection successful, False otherwise
        """
        try:
            with self.get_connection() as conn:
                cursor = conn.cursor()
                cursor.execute("SELECT 1 FROM DUAL")
                result = cursor.fetchone()
                cursor.close()
                
                if result:
                    logger.info("Oracle connection test successful")
                    return True
                return False
        except Exception as e:
            logger.error(f"Oracle connection test failed: {e}")
            return False
    
    def get_table_schema(self, table_name: str) -> List[Dict[str, Any]]:
        """
        Get schema information for a table
        
        Args:
            table_name: Name of the table
        
        Returns:
            List of column information dictionaries
        """
        query = """
            SELECT 
                column_name,
                data_type,
                data_length,
                data_precision,
                data_scale,
                nullable,
                data_default
            FROM user_tab_columns
            WHERE table_name = :table_name
            ORDER BY column_id
        """
        return self.execute_query(query, {'table_name': table_name.upper()})
    
    def list_tables(self, pattern: Optional[str] = None) -> List[str]:
        """
        List all tables in the database
        
        Args:
            pattern: Optional SQL LIKE pattern for table names
        
        Returns:
            List of table names
        """
        query = "SELECT table_name FROM user_tables"
        if pattern:
            query += " WHERE table_name LIKE :pattern"
            results = self.execute_query(query, {'pattern': pattern.upper()})
        else:
            results = self.execute_query(query)
        
        return [row['table_name'].lower() for row in results]


def get_default_connection_manager() -> OracleConnectionManager:
    """Get connection manager with default settings from environment"""
    return OracleConnectionManager()


if __name__ == "__main__":
    # Test the connection
    logging.basicConfig(level=logging.INFO)
    
    try:
        manager = get_default_connection_manager()
        
        if manager.test_connection():
            print("✅ Oracle connection successful!")
            
            # List tables
            tables = manager.list_tables()
            print(f"\n📊 Found {len(tables)} tables in database")
            print("Sample tables:", tables[:10])
            
        else:
            print("❌ Oracle connection failed!")
            
    except Exception as e:
        print(f"❌ Error: {e}")
