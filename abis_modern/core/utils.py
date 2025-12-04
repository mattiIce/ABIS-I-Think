"""
Utility functions converted from PowerBuilder.
"""
from decimal import Decimal
from typing import Optional
from datetime import datetime, date
import logging

logger = logging.getLogger(__name__)


def calculate_metal_weight(
    width: Decimal,
    gauge: Decimal,
    length: Decimal,
    density: Decimal
) -> Decimal:
    """
    Calculate theoretical metal weight.
    
    Args:
        width: Width in inches
        gauge: Thickness in inches
        length: Length in feet
        density: Material density in lbs/in³
    
    Returns:
        Weight in pounds
    """
    # Convert length from feet to inches
    length_inches = length * 12
    
    # Volume = width * gauge * length (all in inches)
    volume_cubic_inches = width * gauge * length_inches
    
    # Weight = volume * density
    weight = volume_cubic_inches * density
    
    return weight.quantize(Decimal('0.01'))


def format_coil_number(prefix: str, sequence: int, suffix: str = '') -> str:
    """
    Format a coil number in ABC standard format.
    
    Args:
        prefix: Customer or line prefix
        sequence: Sequential number
        suffix: Optional suffix
    
    Returns:
        Formatted coil number
    """
    formatted = f"{prefix}-{sequence:06d}"
    if suffix:
        formatted += f"-{suffix}"
    return formatted


def validate_cash_date(ship_date: date, cash_date: date) -> bool:
    """
    Validate that cash date is valid for shipment.
    Converted from f_validate_cash_date.srf
    
    Args:
        ship_date: Shipment date
        cash_date: Requested cash date
    
    Returns:
        True if valid, False otherwise
    """
    if cash_date < ship_date:
        logger.warning(f"Cash date {cash_date} is before ship date {ship_date}")
        return False
    
    # Cash date should not be more than 30 days after ship date
    delta = (cash_date - ship_date).days
    if delta > 30:
        logger.warning(f"Cash date {cash_date} is more than 30 days after ship date")
        return False
    
    return True


def get_next_sequence(prefix: str, table_name: str) -> int:
    """
    Get next sequence number for a given prefix/table.
    Converted from f_get_next_value.srf
    
    Args:
        prefix: Sequence prefix
        table_name: Table name for sequence
    
    Returns:
        Next sequence number
    """
    from core.models import SystemOption
    
    key = f"SEQ_{prefix}_{table_name}"
    
    try:
        option = SystemOption.objects.get(key=key)
        current_value = int(option.value)
        next_value = current_value + 1
        option.value = str(next_value)
        option.save()
        return next_value
    except SystemOption.DoesNotExist:
        # Initialize sequence
        SystemOption.objects.create(
            key=key,
            value='1',
            description=f'Sequence for {prefix} {table_name}'
        )
        return 1


def is_novelis_customer(customer_code: str) -> bool:
    """
    Check if customer is Novelis (special processing required).
    Converted from f_is_novelis.srf
    
    Args:
        customer_code: Customer code
    
    Returns:
        True if Novelis customer
    """
    novelis_codes = ['NOVELIS', 'NOV', 'ALCAN', 'ALC']
    return any(code in customer_code.upper() for code in novelis_codes)


def calculate_pieces_per_bundle(
    width: Decimal,
    gauge: Decimal,
    max_bundle_weight: Decimal = Decimal('4000')
) -> int:
    """
    Calculate optimal pieces per bundle based on dimensions.
    
    Args:
        width: Part width in inches
        gauge: Part thickness in inches
        max_bundle_weight: Maximum bundle weight in lbs
    
    Returns:
        Recommended pieces per bundle
    """
    # Rough calculation - would need piece weight
    # This is a simplified version
    if gauge < Decimal('0.020'):
        return 500
    elif gauge < Decimal('0.040'):
        return 250
    elif gauge < Decimal('0.080'):
        return 100
    else:
        return 50
