"""EDI X12 parser utilities."""
from datetime import datetime
from typing import Dict, List, Tuple
import re


class X12Segment:
    """Represents a single X12 segment."""
    
    def __init__(self, segment_id: str, elements: List[str]):
        self.segment_id = segment_id
        self.elements = elements
    
    def get(self, index: int, default='') -> str:
        """Get element by index (1-based)."""
        try:
            return self.elements[index - 1] if index > 0 else default
        except IndexError:
            return default
    
    def __repr__(self):
        return f"{self.segment_id}*{('*'.join(self.elements))}"


class X12Parser:
    """Parser for X12 EDI format."""
    
    def __init__(self, edi_data: str):
        self.raw_data = edi_data
        self.segments: List[X12Segment] = []
        self.element_separator = '*'
        self.segment_terminator = '~'
        self.sub_element_separator = ':'
    
    def parse(self) -> List[X12Segment]:
        """Parse EDI data into segments."""
        # Clean the data
        data = self.raw_data.strip()
        
        # Extract separators from ISA segment if present
        if data.startswith('ISA'):
            self.element_separator = data[3]
            self.sub_element_separator = data[104]
            self.segment_terminator = data[105]
        
        # Split into segments
        segment_strings = [s.strip() for s in data.split(self.segment_terminator) if s.strip()]
        
        for segment_str in segment_strings:
            if not segment_str:
                continue
            
            parts = segment_str.split(self.element_separator)
            segment_id = parts[0]
            elements = parts[1:] if len(parts) > 1 else []
            
            self.segments.append(X12Segment(segment_id, elements))
        
        return self.segments
    
    def get_segments(self, segment_id: str) -> List[X12Segment]:
        """Get all segments with the given ID."""
        return [s for s in self.segments if s.segment_id == segment_id]
    
    def get_segment(self, segment_id: str) -> X12Segment:
        """Get first segment with the given ID."""
        segments = self.get_segments(segment_id)
        return segments[0] if segments else None
    
    def extract_control_numbers(self) -> Dict[str, str]:
        """Extract ISA and GS control numbers."""
        isa = self.get_segment('ISA')
        gs = self.get_segment('GS')
        
        return {
            'isa_control': isa.get(13) if isa else '',
            'gs_control': gs.get(6) if gs else '',
            'sender_id': isa.get(6) if isa else '',
            'receiver_id': isa.get(8) if isa else '',
        }


class EDI856Parser(X12Parser):
    """Parser for EDI 856 Ship Notice/Manifest."""
    
    def parse_ship_notice(self) -> Dict:
        """Parse 856 transaction into structured data."""
        self.parse()
        
        # BSN - Beginning Segment for Ship Notice
        bsn = self.get_segment('BSN')
        shipment_id = bsn.get(2) if bsn else ''
        shipment_date = bsn.get(3) if bsn else ''
        shipment_time = bsn.get(4) if bsn else ''
        
        # DTM - Date/Time
        dtm_segments = self.get_segments('DTM')
        dates = {}
        for dtm in dtm_segments:
            date_type = dtm.get(1)
            date_value = dtm.get(2)
            dates[date_type] = date_value
        
        # TD5 - Carrier Details
        td5 = self.get_segment('TD5')
        carrier_code = td5.get(2) if td5 else ''
        carrier_name = td5.get(3) if td5 else ''
        
        # REF - Reference Identification
        refs = {}
        for ref in self.get_segments('REF'):
            ref_type = ref.get(1)
            ref_value = ref.get(2)
            refs[ref_type] = ref_value
        
        # N1 - Party Identification
        parties = self._parse_parties()
        
        # HL - Hierarchical Level (items)
        items = self._parse_items()
        
        return {
            'shipment_id': shipment_id,
            'shipment_date': self._parse_date(shipment_date),
            'shipment_time': self._parse_time(shipment_time),
            'carrier_code': carrier_code,
            'carrier_name': carrier_name,
            'references': refs,
            'parties': parties,
            'items': items,
        }
    
    def _parse_parties(self) -> Dict:
        """Parse party identification segments."""
        parties = {}
        current_party = None
        
        for segment in self.segments:
            if segment.segment_id == 'N1':
                party_type = segment.get(1)
                party_name = segment.get(2)
                current_party = party_type
                parties[party_type] = {
                    'name': party_name,
                    'address': {},
                }
            elif segment.segment_id == 'N3' and current_party:
                parties[current_party]['address']['line1'] = segment.get(1)
                parties[current_party]['address']['line2'] = segment.get(2)
            elif segment.segment_id == 'N4' and current_party:
                parties[current_party]['address']['city'] = segment.get(1)
                parties[current_party]['address']['state'] = segment.get(2)
                parties[current_party]['address']['zip'] = segment.get(3)
        
        return parties
    
    def _parse_items(self) -> List[Dict]:
        """Parse hierarchical level items."""
        items = []
        current_item = None
        
        for segment in self.segments:
            if segment.segment_id == 'HL':
                if current_item:
                    items.append(current_item)
                current_item = {
                    'sequence': segment.get(1),
                    'parent': segment.get(2),
                    'level_code': segment.get(3),
                }
            elif segment.segment_id == 'LIN' and current_item:
                current_item['item_number'] = segment.get(2)
            elif segment.segment_id == 'PID' and current_item:
                current_item['description'] = segment.get(5)
            elif segment.segment_id == 'SN1' and current_item:
                current_item['quantity'] = float(segment.get(2) or 0)
                current_item['unit_of_measure'] = segment.get(3)
            elif segment.segment_id == 'PO4' and current_item:
                current_item['pack_count'] = int(segment.get(1) or 1)
                current_item['weight'] = float(segment.get(6) or 0)
            elif segment.segment_id == 'MAN' and current_item:
                man_type = segment.get(1)
                man_value = segment.get(2)
                if 'marks' not in current_item:
                    current_item['marks'] = {}
                current_item['marks'][man_type] = man_value
        
        if current_item:
            items.append(current_item)
        
        return items
    
    def _parse_date(self, date_str: str) -> str:
        """Convert YYYYMMDD to ISO format."""
        if not date_str or len(date_str) != 8:
            return ''
        try:
            dt = datetime.strptime(date_str, '%Y%m%d')
            return dt.strftime('%Y-%m-%d')
        except ValueError:
            return ''
    
    def _parse_time(self, time_str: str) -> str:
        """Convert HHMM to HH:MM format."""
        if not time_str or len(time_str) < 4:
            return ''
        try:
            hh = time_str[:2]
            mm = time_str[2:4]
            return f"{hh}:{mm}:00"
        except ValueError:
            return ''


class EDI863Parser(X12Parser):
    """Parser for EDI 863 Material Test Report."""
    
    def parse_test_report(self) -> Dict:
        """Parse 863 transaction into structured data."""
        self.parse()
        
        # BTR - Beginning Segment for Test Results
        btr = self.get_segment('BTR')
        report_number = btr.get(2) if btr else ''
        report_date = btr.get(3) if btr else ''
        
        # REF - Reference Identification
        refs = {}
        for ref in self.get_segments('REF'):
            ref_type = ref.get(1)
            ref_value = ref.get(2)
            refs[ref_type] = ref_value
        
        # LIN - Item Identification
        lin = self.get_segment('LIN')
        item_number = lin.get(3) if lin else ''
        
        # PID - Product/Item Description
        descriptions = []
        for pid in self.get_segments('PID'):
            descriptions.append(pid.get(5))
        
        # MEA - Measurements
        measurements = self._parse_measurements()
        
        # TES - Test Period or Interval
        tests = self._parse_tests()
        
        return {
            'report_number': report_number,
            'report_date': self._parse_date(report_date),
            'references': refs,
            'item_number': item_number,
            'descriptions': descriptions,
            'measurements': measurements,
            'tests': tests,
        }
    
    def _parse_measurements(self) -> Dict:
        """Parse measurement segments."""
        measurements = {}
        for mea in self.get_segments('MEA'):
            measure_type = mea.get(2)
            measure_value = mea.get(3)
            measure_unit = mea.get(4)
            measurements[measure_type] = {
                'value': measure_value,
                'unit': measure_unit,
            }
        return measurements
    
    def _parse_tests(self) -> List[Dict]:
        """Parse test result segments."""
        tests = []
        for tes in self.get_segments('TES'):
            tests.append({
                'test_code': tes.get(1),
                'test_result': tes.get(2),
                'unit': tes.get(3),
                'standard': tes.get(4),
            })
        return tests
    
    def _parse_date(self, date_str: str) -> str:
        """Convert YYYYMMDD to ISO format."""
        if not date_str or len(date_str) != 8:
            return ''
        try:
            dt = datetime.strptime(date_str, '%Y%m%d')
            return dt.strftime('%Y-%m-%d')
        except ValueError:
            return ''


class EDI870Parser(X12Parser):
    """Parser for EDI 870 Order Status Report."""
    
    def parse_order_status(self) -> Dict:
        """Parse 870 transaction into structured data."""
        self.parse()
        
        # BSR - Beginning Segment for Order Status Report
        bsr = self.get_segment('BSR')
        report_number = bsr.get(2) if bsr else ''
        report_date = bsr.get(3) if bsr else ''
        
        # REF - Reference Identification
        refs = {}
        for ref in self.get_segments('REF'):
            ref_type = ref.get(1)
            ref_value = ref.get(2)
            refs[ref_type] = ref_value
        
        # OID - Order Identification
        oid = self.get_segment('OID')
        order_status = oid.get(2) if oid else ''
        
        # QTY - Quantity
        quantities = {}
        for qty in self.get_segments('QTY'):
            qty_type = qty.get(1)
            qty_value = qty.get(2)
            quantities[qty_type] = float(qty_value or 0)
        
        # DTM - Date/Time
        dates = {}
        for dtm in self.get_segments('DTM'):
            date_type = dtm.get(1)
            date_value = dtm.get(2)
            dates[date_type] = self._parse_date(date_value)
        
        return {
            'report_number': report_number,
            'report_date': self._parse_date(report_date),
            'references': refs,
            'order_status': order_status,
            'quantities': quantities,
            'dates': dates,
        }
    
    def _parse_date(self, date_str: str) -> str:
        """Convert YYYYMMDD to ISO format."""
        if not date_str or len(date_str) != 8:
            return ''
        try:
            dt = datetime.strptime(date_str, '%Y%m%d')
            return dt.strftime('%Y-%m-%d')
        except ValueError:
            return ''
