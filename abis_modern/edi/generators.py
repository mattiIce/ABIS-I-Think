"""EDI X12 generator utilities."""
from datetime import datetime
from typing import Dict, List, Optional
import random
import string


class X12Generator:
    """Base class for X12 EDI generation."""
    
    def __init__(self, sender_id: str, receiver_id: str, sender_qualifier: str = 'ZZ', receiver_qualifier: str = 'ZZ'):
        self.sender_id = sender_id.ljust(15)[:15]
        self.receiver_id = receiver_id.ljust(15)[:15]
        self.sender_qualifier = sender_qualifier
        self.receiver_qualifier = receiver_qualifier
        self.element_separator = '*'
        self.segment_terminator = '~'
        self.sub_element_separator = ':'
        
    def generate_control_number(self) -> str:
        """Generate a 9-digit control number."""
        return ''.join(random.choices(string.digits, k=9))
    
    def format_date(self, dt: datetime) -> str:
        """Format date as YYYYMMDD."""
        return dt.strftime('%Y%m%d')
    
    def format_time(self, dt: datetime) -> str:
        """Format time as HHMM."""
        return dt.strftime('%H%M')
    
    def create_isa_segment(self, control_number: str, timestamp: datetime) -> str:
        """Create ISA interchange control header."""
        date_str = timestamp.strftime('%y%m%d')
        time_str = timestamp.strftime('%H%M')
        
        return (
            f"ISA{self.element_separator}"
            f"00{' ' * 10}{self.element_separator}"  # Authorization info
            f"00{' ' * 10}{self.element_separator}"  # Security info
            f"{self.sender_qualifier}{self.element_separator}"
            f"{self.sender_id}{self.element_separator}"
            f"{self.receiver_qualifier}{self.element_separator}"
            f"{self.receiver_id}{self.element_separator}"
            f"{date_str}{self.element_separator}"
            f"{time_str}{self.element_separator}"
            f"U{self.element_separator}"  # Standards ID
            f"00401{self.element_separator}"  # Version
            f"{control_number}{self.element_separator}"
            f"0{self.element_separator}"  # Acknowledgment requested
            f"P{self.element_separator}"  # Usage indicator (P=Production, T=Test)
            f"{self.sub_element_separator}"
            f"{self.segment_terminator}\n"
        )
    
    def create_gs_segment(self, transaction_code: str, control_number: str, timestamp: datetime) -> str:
        """Create GS functional group header."""
        date_str = self.format_date(timestamp)
        time_str = self.format_time(timestamp)
        
        return (
            f"GS{self.element_separator}"
            f"SH{self.element_separator}"  # Functional identifier code
            f"{self.sender_id.strip()}{self.element_separator}"
            f"{self.receiver_id.strip()}{self.element_separator}"
            f"{date_str}{self.element_separator}"
            f"{time_str}{self.element_separator}"
            f"{control_number}{self.element_separator}"
            f"X{self.element_separator}"  # Responsible agency code
            f"004010{self.segment_terminator}\n"  # Version
        )
    
    def create_st_segment(self, transaction_code: str, control_number: str) -> str:
        """Create ST transaction set header."""
        return (
            f"ST{self.element_separator}"
            f"{transaction_code}{self.element_separator}"
            f"{control_number}{self.segment_terminator}\n"
        )
    
    def create_se_segment(self, segment_count: int, control_number: str) -> str:
        """Create SE transaction set trailer."""
        return (
            f"SE{self.element_separator}"
            f"{segment_count}{self.element_separator}"
            f"{control_number}{self.segment_terminator}\n"
        )
    
    def create_ge_segment(self, transaction_count: int, control_number: str) -> str:
        """Create GE functional group trailer."""
        return (
            f"GE{self.element_separator}"
            f"{transaction_count}{self.element_separator}"
            f"{control_number}{self.segment_terminator}\n"
        )
    
    def create_iea_segment(self, group_count: int, control_number: str) -> str:
        """Create IEA interchange control trailer."""
        return (
            f"IEA{self.element_separator}"
            f"{group_count}{self.element_separator}"
            f"{control_number}{self.segment_terminator}\n"
        )


class EDI856Generator(X12Generator):
    """Generator for EDI 856 Ship Notice/Manifest."""
    
    def generate(self, shipment_data: Dict) -> str:
        """Generate 856 transaction from shipment data."""
        timestamp = datetime.now()
        isa_control = self.generate_control_number()
        gs_control = self.generate_control_number()
        st_control = self.generate_control_number()
        
        segments = []
        
        # ISA - Interchange Control Header
        segments.append(self.create_isa_segment(isa_control, timestamp))
        
        # GS - Functional Group Header
        segments.append(self.create_gs_segment('856', gs_control, timestamp))
        
        # ST - Transaction Set Header
        segments.append(self.create_st_segment('856', st_control))
        
        # BSN - Beginning Segment for Ship Notice
        segments.append(self._create_bsn_segment(shipment_data))
        
        # DTM - Date/Time Reference
        segments.append(self._create_dtm_segment(shipment_data))
        
        # HL - Hierarchical Level (Shipment)
        segments.append(self._create_hl_shipment(shipment_data))
        
        # TD5 - Carrier Details
        if shipment_data.get('carrier_code'):
            segments.append(self._create_td5_segment(shipment_data))
        
        # REF - Reference Identification
        if shipment_data.get('bol_number'):
            segments.append(self._create_ref_segment('BM', shipment_data['bol_number']))
        if shipment_data.get('pro_number'):
            segments.append(self._create_ref_segment('CN', shipment_data['pro_number']))
        
        # N1 Loop - Party Identification
        segments.extend(self._create_party_segments(shipment_data))
        
        # HL Loop - Items
        segments.extend(self._create_item_segments(shipment_data.get('items', [])))
        
        # Count segments
        segment_count = len([s for s in segments if s.strip().startswith('ST') or 
                            (not s.strip().startswith(('ISA', 'GS', 'IEA', 'GE')) and s.strip())]) + 1
        
        # SE - Transaction Set Trailer
        segments.append(self.create_se_segment(segment_count, st_control))
        
        # GE - Functional Group Trailer
        segments.append(self.create_ge_segment(1, gs_control))
        
        # IEA - Interchange Control Trailer
        segments.append(self.create_iea_segment(1, isa_control))
        
        return ''.join(segments)
    
    def _create_bsn_segment(self, data: Dict) -> str:
        """Create BSN segment."""
        shipment_date = self.format_date(data.get('shipment_date', datetime.now()))
        shipment_time = self.format_time(data.get('shipment_date', datetime.now()))
        
        return (
            f"BSN{self.element_separator}"
            f"00{self.element_separator}"  # Purpose code (00=Original)
            f"{data.get('shipment_identifier', '')}{self.element_separator}"
            f"{shipment_date}{self.element_separator}"
            f"{shipment_time}{self.segment_terminator}\n"
        )
    
    def _create_dtm_segment(self, data: Dict) -> str:
        """Create DTM date/time segment."""
        ship_date = self.format_date(data.get('ship_date', datetime.now()))
        return (
            f"DTM{self.element_separator}"
            f"011{self.element_separator}"  # Date/time qualifier (011=Shipped)
            f"{ship_date}{self.segment_terminator}\n"
        )
    
    def _create_hl_shipment(self, data: Dict) -> str:
        """Create HL hierarchical level for shipment."""
        return (
            f"HL{self.element_separator}"
            f"1{self.element_separator}"  # Hierarchical ID
            f"{self.element_separator}"  # Parent ID (none for top level)
            f"S{self.segment_terminator}\n"  # Hierarchical level code (S=Shipment)
        )
    
    def _create_td5_segment(self, data: Dict) -> str:
        """Create TD5 carrier details segment."""
        return (
            f"TD5{self.element_separator}"
            f"{self.element_separator}"
            f"2{self.element_separator}"  # Identification code qualifier (2=SCAC)
            f"{data.get('carrier_code', '')}{self.element_separator}"
            f"{self.element_separator}"
            f"{data.get('carrier_name', '')}{self.segment_terminator}\n"
        )
    
    def _create_ref_segment(self, qualifier: str, value: str) -> str:
        """Create REF reference identification segment."""
        return (
            f"REF{self.element_separator}"
            f"{qualifier}{self.element_separator}"
            f"{value}{self.segment_terminator}\n"
        )
    
    def _create_party_segments(self, data: Dict) -> List[str]:
        """Create N1/N3/N4 party identification segments."""
        segments = []
        
        # Ship From
        if data.get('ship_from'):
            ship_from = data['ship_from']
            segments.append(
                f"N1{self.element_separator}"
                f"SF{self.element_separator}"  # Ship From
                f"{ship_from.get('name', '')}{self.segment_terminator}\n"
            )
            if ship_from.get('address'):
                addr = ship_from['address']
                if addr.get('line1'):
                    segments.append(
                        f"N3{self.element_separator}"
                        f"{addr.get('line1', '')}{self.segment_terminator}\n"
                    )
                segments.append(
                    f"N4{self.element_separator}"
                    f"{addr.get('city', '')}{self.element_separator}"
                    f"{addr.get('state', '')}{self.element_separator}"
                    f"{addr.get('zip', '')}{self.segment_terminator}\n"
                )
        
        # Ship To
        if data.get('ship_to'):
            ship_to = data['ship_to']
            segments.append(
                f"N1{self.element_separator}"
                f"ST{self.element_separator}"  # Ship To
                f"{ship_to.get('name', '')}{self.segment_terminator}\n"
            )
            if ship_to.get('address'):
                addr = ship_to['address']
                if addr.get('line1'):
                    segments.append(
                        f"N3{self.element_separator}"
                        f"{addr.get('line1', '')}{self.segment_terminator}\n"
                    )
                segments.append(
                    f"N4{self.element_separator}"
                    f"{addr.get('city', '')}{self.element_separator}"
                    f"{addr.get('state', '')}{self.element_separator}"
                    f"{addr.get('zip', '')}{self.segment_terminator}\n"
                )
        
        return segments
    
    def _create_item_segments(self, items: List[Dict]) -> List[str]:
        """Create HL/LIN/SN1/PO4/MAN segments for items."""
        segments = []
        
        for idx, item in enumerate(items, start=2):
            # HL - Hierarchical Level (Item)
            segments.append(
                f"HL{self.element_separator}"
                f"{idx}{self.element_separator}"  # Hierarchical ID
                f"1{self.element_separator}"  # Parent ID (shipment)
                f"I{self.segment_terminator}\n"  # Hierarchical level code (I=Item)
            )
            
            # LIN - Item Identification
            segments.append(
                f"LIN{self.element_separator}"
                f"{self.element_separator}"
                f"BP{self.element_separator}"  # Product ID qualifier
                f"{item.get('item_number', '')}{self.segment_terminator}\n"
            )
            
            # SN1 - Item Detail (Shipment)
            segments.append(
                f"SN1{self.element_separator}"
                f"{self.element_separator}"
                f"{item.get('quantity', 0)}{self.element_separator}"
                f"{item.get('unit_of_measure', 'LB')}{self.segment_terminator}\n"
            )
            
            # PO4 - Item Physical Details
            if item.get('weight'):
                segments.append(
                    f"PO4{self.element_separator}"
                    f"{item.get('pack_count', 1)}{self.element_separator}"
                    f"{self.element_separator}{self.element_separator}"
                    f"{self.element_separator}{self.element_separator}"
                    f"{item.get('weight', 0)}{self.element_separator}"
                    f"L{self.segment_terminator}\n"  # Weight unit (L=Pounds)
                )
            
            # MAN - Marks and Numbers
            if item.get('coil_number'):
                segments.append(
                    f"MAN{self.element_separator}"
                    f"L{self.element_separator}"  # Marks and numbers qualifier (L=Line Item)
                    f"{item['coil_number']}{self.segment_terminator}\n"
                )
            if item.get('heat_number'):
                segments.append(
                    f"MAN{self.element_separator}"
                    f"S{self.element_separator}"  # Marks and numbers qualifier (S=Serial)
                    f"{item['heat_number']}{self.segment_terminator}\n"
                )
        
        return segments


class EDI863Generator(X12Generator):
    """Generator for EDI 863 Material Test Report."""
    
    def generate(self, test_data: Dict) -> str:
        """Generate 863 transaction from test report data."""
        timestamp = datetime.now()
        isa_control = self.generate_control_number()
        gs_control = self.generate_control_number()
        st_control = self.generate_control_number()
        
        segments = []
        
        # ISA - Interchange Control Header
        segments.append(self.create_isa_segment(isa_control, timestamp))
        
        # GS - Functional Group Header
        segments.append(self.create_gs_segment('863', gs_control, timestamp))
        
        # ST - Transaction Set Header
        segments.append(self.create_st_segment('863', st_control))
        
        # BTR - Beginning Segment for Test Results
        segments.append(self._create_btr_segment(test_data))
        
        # REF - Reference Identification
        if test_data.get('heat_number'):
            segments.append(self._create_ref_segment('HT', test_data['heat_number']))
        if test_data.get('coil_number'):
            segments.append(self._create_ref_segment('CO', test_data['coil_number']))
        
        # LIN - Item Identification
        segments.append(self._create_lin_segment(test_data))
        
        # PID - Product Description
        if test_data.get('product_description'):
            segments.append(self._create_pid_segment(test_data['product_description']))
        
        # MEA - Measurements (Physical)
        if test_data.get('gauge'):
            segments.append(self._create_mea_segment('TH', test_data['gauge'], 'IN'))
        if test_data.get('width'):
            segments.append(self._create_mea_segment('WD', test_data['width'], 'IN'))
        if test_data.get('weight'):
            segments.append(self._create_mea_segment('G', test_data['weight'], 'LB'))
        
        # Chemical composition
        if test_data.get('chemical_composition'):
            for element, value in test_data['chemical_composition'].items():
                segments.append(self._create_tes_segment(element, value, 'PCT'))
        
        # Mechanical properties
        if test_data.get('mechanical_properties'):
            for prop, value in test_data['mechanical_properties'].items():
                segments.append(self._create_tes_segment(prop, value, 'KSI'))
        
        # Count segments
        segment_count = len([s for s in segments if s.strip().startswith('ST') or 
                            (not s.strip().startswith(('ISA', 'GS', 'IEA', 'GE')) and s.strip())]) + 1
        
        # SE - Transaction Set Trailer
        segments.append(self.create_se_segment(segment_count, st_control))
        
        # GE - Functional Group Trailer
        segments.append(self.create_ge_segment(1, gs_control))
        
        # IEA - Interchange Control Trailer
        segments.append(self.create_iea_segment(1, isa_control))
        
        return ''.join(segments)
    
    def _create_btr_segment(self, data: Dict) -> str:
        """Create BTR beginning segment."""
        report_date = self.format_date(data.get('report_date', datetime.now()))
        
        return (
            f"BTR{self.element_separator}"
            f"MT{self.element_separator}"  # Report type (MT=Mill Test Report)
            f"{data.get('report_number', '')}{self.element_separator}"
            f"{report_date}{self.segment_terminator}\n"
        )
    
    def _create_ref_segment(self, qualifier: str, value: str) -> str:
        """Create REF reference segment."""
        return (
            f"REF{self.element_separator}"
            f"{qualifier}{self.element_separator}"
            f"{value}{self.segment_terminator}\n"
        )
    
    def _create_lin_segment(self, data: Dict) -> str:
        """Create LIN item identification segment."""
        return (
            f"LIN{self.element_separator}"
            f"{self.element_separator}"
            f"BP{self.element_separator}"
            f"{data.get('alloy', '')}{self.segment_terminator}\n"
        )
    
    def _create_pid_segment(self, description: str) -> str:
        """Create PID product description segment."""
        return (
            f"PID{self.element_separator}"
            f"F{self.element_separator}"  # Item description type (F=Free-form)
            f"{self.element_separator}{self.element_separator}{self.element_separator}"
            f"{description}{self.segment_terminator}\n"
        )
    
    def _create_mea_segment(self, measure_code: str, value: float, unit: str) -> str:
        """Create MEA measurement segment."""
        return (
            f"MEA{self.element_separator}"
            f"PD{self.element_separator}"  # Measurement reference ID (PD=Physical Dimensions)
            f"{measure_code}{self.element_separator}"
            f"{value}{self.element_separator}"
            f"{unit}{self.segment_terminator}\n"
        )
    
    def _create_tes_segment(self, test_code: str, result: float, unit: str) -> str:
        """Create TES test result segment."""
        return (
            f"TES{self.element_separator}"
            f"{test_code}{self.element_separator}"
            f"{result}{self.element_separator}"
            f"{unit}{self.segment_terminator}\n"
        )


class EDI870Generator(X12Generator):
    """Generator for EDI 870 Order Status Report."""
    
    def generate(self, order_data: Dict) -> str:
        """Generate 870 transaction from order status data."""
        timestamp = datetime.now()
        isa_control = self.generate_control_number()
        gs_control = self.generate_control_number()
        st_control = self.generate_control_number()
        
        segments = []
        
        # ISA - Interchange Control Header
        segments.append(self.create_isa_segment(isa_control, timestamp))
        
        # GS - Functional Group Header
        segments.append(self.create_gs_segment('870', gs_control, timestamp))
        
        # ST - Transaction Set Header
        segments.append(self.create_st_segment('870', st_control))
        
        # BSR - Beginning Segment for Order Status Report
        segments.append(self._create_bsr_segment(order_data))
        
        # REF - Reference Identification
        if order_data.get('customer_po'):
            segments.append(self._create_ref_segment('PO', order_data['customer_po']))
        if order_data.get('job_number'):
            segments.append(self._create_ref_segment('JB', order_data['job_number']))
        
        # OID - Order Identification
        segments.append(self._create_oid_segment(order_data))
        
        # QTY - Quantity segments
        if order_data.get('quantity_ordered'):
            segments.append(self._create_qty_segment('OR', order_data['quantity_ordered']))
        if order_data.get('quantity_completed'):
            segments.append(self._create_qty_segment('CP', order_data['quantity_completed']))
        if order_data.get('quantity_shipped'):
            segments.append(self._create_qty_segment('SH', order_data['quantity_shipped']))
        
        # DTM - Date/Time segments
        if order_data.get('scheduled_ship_date'):
            segments.append(self._create_dtm_segment('002', order_data['scheduled_ship_date']))
        if order_data.get('estimated_completion_date'):
            segments.append(self._create_dtm_segment('004', order_data['estimated_completion_date']))
        
        # Count segments
        segment_count = len([s for s in segments if s.strip().startswith('ST') or 
                            (not s.strip().startswith(('ISA', 'GS', 'IEA', 'GE')) and s.strip())]) + 1
        
        # SE - Transaction Set Trailer
        segments.append(self.create_se_segment(segment_count, st_control))
        
        # GE - Functional Group Trailer
        segments.append(self.create_ge_segment(1, gs_control))
        
        # IEA - Interchange Control Trailer
        segments.append(self.create_iea_segment(1, isa_control))
        
        return ''.join(segments)
    
    def _create_bsr_segment(self, data: Dict) -> str:
        """Create BSR beginning segment."""
        report_date = self.format_date(data.get('report_date', datetime.now()))
        
        return (
            f"BSR{self.element_separator}"
            f"OS{self.element_separator}"  # Transaction set purpose (OS=Order Status)
            f"{data.get('report_number', '')}{self.element_separator}"
            f"{report_date}{self.segment_terminator}\n"
        )
    
    def _create_ref_segment(self, qualifier: str, value: str) -> str:
        """Create REF reference segment."""
        return (
            f"REF{self.element_separator}"
            f"{qualifier}{self.element_separator}"
            f"{value}{self.segment_terminator}\n"
        )
    
    def _create_oid_segment(self, data: Dict) -> str:
        """Create OID order identification segment."""
        return (
            f"OID{self.element_separator}"
            f"{self.element_separator}"
            f"{data.get('order_status', 'IP')}{self.segment_terminator}\n"  # IP=In Process
        )
    
    def _create_qty_segment(self, qualifier: str, quantity: float) -> str:
        """Create QTY quantity segment."""
        return (
            f"QTY{self.element_separator}"
            f"{qualifier}{self.element_separator}"
            f"{quantity}{self.segment_terminator}\n"
        )
    
    def _create_dtm_segment(self, qualifier: str, date_value) -> str:
        """Create DTM date/time segment."""
        if isinstance(date_value, str):
            date_str = date_value.replace('-', '')
        else:
            date_str = self.format_date(date_value)
        
        return (
            f"DTM{self.element_separator}"
            f"{qualifier}{self.element_separator}"
            f"{date_str}{self.segment_terminator}\n"
        )
