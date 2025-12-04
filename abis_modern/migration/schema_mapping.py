"""
Schema Mapping Configuration for Legacy ABIS Data Migration

Maps PowerBuilder/Oracle tables and fields to Django models.
Handles naming conventions, data type conversions, and relationships.
"""

from typing import Dict, List, Optional, Callable, Any
from datetime import datetime
import re


def get_mapping(entity_type: str) -> 'TableMapping':
    """Get mapping configuration for entity type"""
    if entity_type not in ALL_MAPPINGS:
        raise ValueError(f"Unknown entity type: {entity_type}")
    return ALL_MAPPINGS[entity_type]


def get_migration_order() -> List[str]:
    """Get list of entity types in migration order"""
    return MIGRATION_ORDER


class FieldMapping:
    """Defines mapping for a single field"""
    
    def __init__(
        self,
        source_field: str,
        target_field: str,
        transform: Optional[Callable] = None,
        default: Any = None,
        required: bool = False
    ):
        self.source_field = source_field
        self.target_field = target_field
        self.transform = transform
        self.default = default
        self.required = required
    
    def apply(self, source_data: Dict[str, Any]) -> Any:
        """Apply transformation to source data"""
        value = source_data.get(self.source_field, self.default)
        
        if value is None and self.required:
            raise ValueError(f"Required field {self.source_field} is missing")
        
        if value is not None and self.transform:
            try:
                return self.transform(value)
            except Exception as e:
                raise ValueError(f"Transform failed for {self.source_field}: {e}")
        
        return value


class TableMapping:
    """Defines mapping for a table/model"""
    
    def __init__(
        self,
        source_table: str,
        target_model: str,
        app_label: str,
        fields: List[FieldMapping],
        primary_key_field: str,
        where_clause: Optional[str] = None,
        order_by: Optional[str] = None
    ):
        self.source_table = source_table
        self.target_model = target_model
        self.app_label = app_label
        self.fields = fields
        self.primary_key_field = primary_key_field
        self.where_clause = where_clause
        self.order_by = order_by
    
    def get_select_query(self) -> str:
        """Generate SELECT query for source table"""
        fields = [f.source_field for f in self.fields]
        query = f"SELECT {', '.join(fields)} FROM {self.source_table}"
        
        if self.where_clause:
            query += f" WHERE {self.where_clause}"
        
        if self.order_by:
            query += f" ORDER BY {self.order_by}"
        
        return query
    
    def transform_row(self, source_row: Dict[str, Any]) -> Dict[str, Any]:
        """Transform a source row to target format"""
        target_row = {}
        
        for field in self.fields:
            target_row[field.target_field] = field.apply(source_row)
        
        return target_row


# ============================================================================
# Data Transformation Functions
# ============================================================================

def strip_string(value: Any) -> Optional[str]:
    """Strip whitespace from string values"""
    if value is None:
        return None
    return str(value).strip() if value else None


def uppercase_string(value: Any) -> Optional[str]:
    """Convert string to uppercase"""
    if value is None:
        return None
    return str(value).upper() if value else None


def parse_oracle_date(value: Any) -> Optional[datetime]:
    """Parse Oracle DATE to Python datetime"""
    if value is None:
        return None
    if isinstance(value, datetime):
        return value
    # cx_Oracle typically returns datetime objects, but handle strings just in case
    if isinstance(value, str):
        try:
            return datetime.strptime(value, '%Y-%m-%d %H:%M:%S')
        except ValueError:
            try:
                return datetime.strptime(value, '%Y-%m-%d')
            except ValueError:
                return None
    return None


def convert_to_boolean(value: Any) -> bool:
    """Convert various boolean representations"""
    if value is None:
        return False
    if isinstance(value, bool):
        return value
    if isinstance(value, (int, float)):
        return value != 0
    if isinstance(value, str):
        return value.upper() in ('Y', 'YES', 'T', 'TRUE', '1')
    return False


def convert_to_decimal(value: Any) -> Optional[float]:
    """Convert to decimal/float"""
    if value is None:
        return None
    try:
        return float(value)
    except (ValueError, TypeError):
        return None


def parse_phone_number(value: Any) -> Optional[str]:
    """Clean and format phone number"""
    if value is None:
        return None
    # Remove non-numeric characters
    phone = re.sub(r'[^\d]', '', str(value))
    if len(phone) == 10:
        return f"({phone[:3]}) {phone[3:6]}-{phone[6:]}"
    elif len(phone) == 11 and phone[0] == '1':
        return f"+1 ({phone[1:4]}) {phone[4:7]}-{phone[7:]}"
    return value


def clean_email(value: Any) -> Optional[str]:
    """Clean and validate email"""
    if value is None:
        return None
    email = str(value).strip().lower()
    if '@' in email and '.' in email:
        return email
    return None


# ============================================================================
# Schema Mappings
# ============================================================================

# Customer Mapping
CUSTOMER_MAPPING = TableMapping(
    source_table='AB_CUSTOMER',
    target_model='Customer',
    app_label='customers',
    primary_key_field='customer_id',
    fields=[
        FieldMapping('CUSTOMER_ID', 'customer_id', strip_string, required=True),
        FieldMapping('CUSTOMER_NAME', 'name', strip_string, required=True),
        FieldMapping('ADDRESS_1', 'address_line1', strip_string),
        FieldMapping('ADDRESS_2', 'address_line2', strip_string),
        FieldMapping('CITY', 'city', strip_string),
        FieldMapping('STATE', 'state', strip_string),
        FieldMapping('ZIP_CODE', 'zip_code', strip_string),
        FieldMapping('COUNTRY', 'country', strip_string, default='USA'),
        FieldMapping('PHONE', 'phone', parse_phone_number),
        FieldMapping('FAX', 'fax', parse_phone_number),
        FieldMapping('EMAIL', 'email', clean_email),
        FieldMapping('IS_ACTIVE', 'is_active', convert_to_boolean, default=True),
        FieldMapping('NOTES', 'notes', strip_string),
        FieldMapping('CREATED_DATE', 'created_at', parse_oracle_date),
        FieldMapping('MODIFIED_DATE', 'updated_at', parse_oracle_date),
    ],
    where_clause=None,
    order_by='CUSTOMER_ID'
)

# Coil Mapping
COIL_MAPPING = TableMapping(
    source_table='AB_COIL',
    target_model='Coil',
    app_label='inventory',
    primary_key_field='coil_id',
    fields=[
        FieldMapping('COIL_ID', 'coil_id', strip_string, required=True),
        FieldMapping('COIL_NUMBER', 'coil_number', strip_string),
        FieldMapping('HEAT_NUMBER', 'heat_number', strip_string),
        FieldMapping('ALLOY', 'alloy', strip_string),
        FieldMapping('TEMPER', 'temper', strip_string),
        FieldMapping('GAUGE', 'gauge', convert_to_decimal),
        FieldMapping('WIDTH', 'width', convert_to_decimal),
        FieldMapping('LENGTH', 'length', convert_to_decimal),
        FieldMapping('WEIGHT', 'weight', convert_to_decimal),
        FieldMapping('QUANTITY', 'quantity', convert_to_decimal),
        FieldMapping('LOCATION', 'location', strip_string),
        FieldMapping('STATUS', 'status', uppercase_string),
        FieldMapping('SUPPLIER', 'supplier', strip_string),
        FieldMapping('MILL_ID', 'mill_id', strip_string),
        FieldMapping('RECEIVED_DATE', 'received_date', parse_oracle_date),
        FieldMapping('CUSTOMER_ID', 'customer_id', strip_string),
        FieldMapping('NOTES', 'notes', strip_string),
        FieldMapping('CREATED_DATE', 'created_at', parse_oracle_date),
        FieldMapping('MODIFIED_DATE', 'updated_at', parse_oracle_date),
    ],
    where_clause=None,
    order_by='RECEIVED_DATE, COIL_ID'
)

# Job Mapping
JOB_MAPPING = TableMapping(
    source_table='AB_JOB',
    target_model='Job',
    app_label='production',
    primary_key_field='job_id',
    fields=[
        FieldMapping('JOB_ID', 'job_id', strip_string, required=True),
        FieldMapping('JOB_NUMBER', 'job_number', strip_string, required=True),
        FieldMapping('CUSTOMER_ID', 'customer_id', strip_string),
        FieldMapping('COIL_ID', 'coil_id', strip_string),
        FieldMapping('LINE_ID', 'line_id', strip_string),
        FieldMapping('PART_NUMBER', 'part_number', strip_string),
        FieldMapping('QUANTITY', 'quantity', convert_to_decimal),
        FieldMapping('ALLOY', 'alloy', strip_string),
        FieldMapping('TEMPER', 'temper', strip_string),
        FieldMapping('GAUGE', 'gauge', convert_to_decimal),
        FieldMapping('WIDTH', 'width', convert_to_decimal),
        FieldMapping('LENGTH', 'length', convert_to_decimal),
        FieldMapping('STATUS', 'status', uppercase_string, default='PENDING'),
        FieldMapping('PRIORITY', 'priority', int, default=0),
        FieldMapping('SCHEDULED_DATE', 'scheduled_date', parse_oracle_date),
        FieldMapping('START_DATE', 'start_date', parse_oracle_date),
        FieldMapping('COMPLETION_DATE', 'completion_date', parse_oracle_date),
        FieldMapping('NOTES', 'notes', strip_string),
        FieldMapping('CREATED_DATE', 'created_at', parse_oracle_date),
        FieldMapping('MODIFIED_DATE', 'updated_at', parse_oracle_date),
    ],
    where_clause=None,
    order_by='SCHEDULED_DATE, JOB_ID'
)

# Shipment Mapping
SHIPMENT_MAPPING = TableMapping(
    source_table='AB_SHIPMENT',
    target_model='Shipment',
    app_label='shipping',
    primary_key_field='shipment_id',
    fields=[
        FieldMapping('SHIPMENT_ID', 'shipment_id', strip_string, required=True),
        FieldMapping('BOL_NUMBER', 'bol_number', strip_string, required=True),
        FieldMapping('CUSTOMER_ID', 'customer_id', strip_string),
        FieldMapping('CARRIER_ID', 'carrier_id', strip_string),
        FieldMapping('STATUS', 'status', uppercase_string, default='PENDING'),
        FieldMapping('SHIP_DATE', 'ship_date', parse_oracle_date),
        FieldMapping('DELIVERY_DATE', 'delivery_date', parse_oracle_date),
        FieldMapping('TRACKING_NUMBER', 'tracking_number', strip_string),
        FieldMapping('FREIGHT_CHARGES', 'freight_charges', convert_to_decimal),
        FieldMapping('NOTES', 'notes', strip_string),
        FieldMapping('CREATED_DATE', 'created_at', parse_oracle_date),
        FieldMapping('MODIFIED_DATE', 'updated_at', parse_oracle_date),
    ],
    where_clause=None,
    order_by='SHIP_DATE, SHIPMENT_ID'
)

# Skid Mapping
SKID_MAPPING = TableMapping(
    source_table='AB_SKID',
    target_model='Skid',
    app_label='inventory',
    primary_key_field='skid_id',
    fields=[
        FieldMapping('SKID_ID', 'skid_id', strip_string, required=True),
        FieldMapping('SKID_NUMBER', 'skid_number', strip_string),
        FieldMapping('JOB_ID', 'job_id', strip_string),
        FieldMapping('CUSTOMER_ID', 'customer_id', strip_string),
        FieldMapping('STATUS', 'status', uppercase_string),
        FieldMapping('LOCATION', 'location', strip_string),
        FieldMapping('TOTAL_PIECES', 'total_pieces', int),
        FieldMapping('TOTAL_WEIGHT', 'total_weight', convert_to_decimal),
        FieldMapping('CREATED_DATE', 'created_at', parse_oracle_date),
        FieldMapping('MODIFIED_DATE', 'updated_at', parse_oracle_date),
    ],
    where_clause=None,
    order_by='CREATED_DATE, SKID_ID'
)

# QA Result Mapping
QA_MAPPING = TableMapping(
    source_table='AB_QA_TEST',
    target_model='QAResult',
    app_label='quality',
    primary_key_field='test_id',
    fields=[
        FieldMapping('TEST_ID', 'test_id', strip_string, required=True),
        FieldMapping('COIL_ID', 'coil_id', strip_string),
        FieldMapping('JOB_ID', 'job_id', strip_string),
        FieldMapping('TEST_TYPE', 'test_type', uppercase_string),
        FieldMapping('TEST_DATE', 'test_date', parse_oracle_date),
        FieldMapping('INSPECTOR', 'inspector', strip_string),
        FieldMapping('RESULT', 'result', uppercase_string),
        FieldMapping('PASSED', 'passed', convert_to_boolean),
        FieldMapping('NOTES', 'notes', strip_string),
        FieldMapping('CREATED_DATE', 'created_at', parse_oracle_date),
    ],
    where_clause=None,
    order_by='TEST_DATE, TEST_ID'
)

# Carrier Mapping
CARRIER_MAPPING = TableMapping(
    source_table='AB_CARRIER',
    target_model='Carrier',
    app_label='shipping',
    primary_key_field='carrier_id',
    fields=[
        FieldMapping('CARRIER_ID', 'carrier_id', strip_string, required=True),
        FieldMapping('CARRIER_NAME', 'name', strip_string, required=True),
        FieldMapping('SCAC_CODE', 'scac_code', strip_string),
        FieldMapping('CONTACT_NAME', 'contact_name', strip_string),
        FieldMapping('PHONE', 'phone', parse_phone_number),
        FieldMapping('EMAIL', 'email', clean_email),
        FieldMapping('IS_ACTIVE', 'is_active', convert_to_boolean, default=True),
        FieldMapping('NOTES', 'notes', strip_string),
    ],
    where_clause=None,
    order_by='CARRIER_NAME'
)

# Line Mapping
LINE_MAPPING = TableMapping(
    source_table='AB_LINE',
    target_model='Line',
    app_label='core',
    primary_key_field='line_id',
    fields=[
        FieldMapping('LINE_ID', 'line_id', strip_string, required=True),
        FieldMapping('LINE_NUMBER', 'line_number', strip_string, required=True),
        FieldMapping('DESCRIPTION', 'description', strip_string),
        FieldMapping('IS_ACTIVE', 'is_active', convert_to_boolean, default=True),
    ],
    where_clause=None,
    order_by='LINE_NUMBER'
)

# ============================================================================
# Mapping Registry
# ============================================================================

ALL_MAPPINGS = {
    'carriers': CARRIER_MAPPING,
    'lines': LINE_MAPPING,
    'customers': CUSTOMER_MAPPING,
    'coils': COIL_MAPPING,
    'jobs': JOB_MAPPING,
    'skids': SKID_MAPPING,
    'qa_results': QA_MAPPING,
    'shipments': SHIPMENT_MAPPING,
}

# Migration order (respects foreign key dependencies)
MIGRATION_ORDER = [
    'carriers',
    'lines',
    'customers',
    'coils',
    'jobs',
    'skids',
    'qa_results',
    'shipments',
]


def get_mapping(entity_type: str) -> TableMapping:
    """Get mapping configuration for an entity type"""
    if entity_type not in ALL_MAPPINGS:
        raise ValueError(f"Unknown entity type: {entity_type}")
    return ALL_MAPPINGS[entity_type]


def get_migration_order() -> List[str]:
    """Get the order in which entities should be migrated"""
    return MIGRATION_ORDER.copy()
