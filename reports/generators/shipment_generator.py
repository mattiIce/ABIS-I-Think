"""
Shipment Document Generator (BOL, Packing Lists)
"""
from reportlab.lib.units import inch
from reportlab.platypus import Paragraph, Spacer, Table, PageBreak
from reportlab.lib import colors
from datetime import datetime
from .pdf_generator import PDFGenerator


class ShipmentDocumentGenerator(PDFGenerator):
    """Generate shipping documents (Bill of Lading, Packing Lists)"""
    
    def generate_bill_of_lading(self, shipment_data):
        """
        Generate a Bill of Lading (BOL) document
        
        Args:
            shipment_data: Dictionary containing shipment information
        
        Returns:
            BytesIO buffer containing the BOL PDF
        """
        content = []
        
        # Title
        title = Paragraph("BILL OF LADING", self.styles['CustomTitle'])
        content.append(title)
        content.append(Spacer(1, 0.2*inch))
        
        # BOL Number and Date
        bol_header_data = [
            ['BOL Number:', f"<b>{shipment_data.get('bol_number', 'N/A')}</b>"],
            ['Date:', datetime.now().strftime("%Y-%m-%d")],
            ['Shipment Date:', shipment_data.get('ship_date', 'N/A')],
        ]
        bol_header_table = Table(bol_header_data, colWidths=[1.5*inch, 5*inch])
        bol_header_table.setStyle([
            ('FONTNAME', (0, 0), (0, -1), 'Helvetica-Bold'),
            ('FONTSIZE', (0, 0), (-1, -1), 11),
        ])
        content.append(bol_header_table)
        content.append(Spacer(1, 0.2*inch))
        
        # Shipper Information
        content.append(Paragraph("Shipper Information", self.styles['CustomHeading']))
        shipper_data = [
            ['Company:', shipment_data.get('shipper_name', 'ABIS')],
            ['Address:', shipment_data.get('shipper_address', '')],
            ['City, State, ZIP:', shipment_data.get('shipper_city_state_zip', '')],
            ['Phone:', shipment_data.get('shipper_phone', '')],
        ]
        shipper_table = Table(shipper_data, colWidths=[1.5*inch, 5*inch])
        content.append(shipper_table)
        content.append(Spacer(1, 0.2*inch))
        
        # Consignee Information
        content.append(Paragraph("Consignee Information", self.styles['CustomHeading']))
        consignee_data = [
            ['Company:', shipment_data.get('customer_name', 'N/A')],
            ['Address:', shipment_data.get('customer_address', '')],
            ['City, State, ZIP:', shipment_data.get('customer_city_state_zip', '')],
            ['Phone:', shipment_data.get('customer_phone', '')],
        ]
        consignee_table = Table(consignee_data, colWidths=[1.5*inch, 5*inch])
        content.append(consignee_table)
        content.append(Spacer(1, 0.2*inch))
        
        # Carrier Information
        content.append(Paragraph("Carrier Information", self.styles['CustomHeading']))
        carrier_data = [
            ['Carrier:', shipment_data.get('carrier_name', 'N/A')],
            ['Trailer #:', shipment_data.get('trailer_number', 'N/A')],
            ['Seal #:', shipment_data.get('seal_number', 'N/A')],
            ['PRO #:', shipment_data.get('pro_number', 'N/A')],
        ]
        carrier_table = Table(carrier_data, colWidths=[1.5*inch, 5*inch])
        content.append(carrier_table)
        content.append(Spacer(1, 0.3*inch))
        
        # Items Table
        content.append(Paragraph("Items", self.styles['CustomHeading']))
        items_data = [['Item #', 'Description', 'Quantity', 'Weight (lbs)', 'Package Type']]
        
        for item in shipment_data.get('items', []):
            items_data.append([
                item.get('item_number', ''),
                item.get('description', ''),
                str(item.get('quantity', 0)),
                f"{item.get('weight', 0):,.0f}",
                item.get('package_type', 'Coil'),
            ])
        
        # Totals row
        total_qty = sum(item.get('quantity', 0) for item in shipment_data.get('items', []))
        total_weight = sum(item.get('weight', 0) for item in shipment_data.get('items', []))
        items_data.append([
            '', '<b>TOTALS:</b>', f'<b>{total_qty}</b>', f'<b>{total_weight:,.0f}</b>', ''
        ])
        
        items_table = self.create_table(items_data, col_widths=[0.75*inch, 2.5*inch, 1*inch, 1.25*inch, 1*inch])
        content.append(items_table)
        content.append(Spacer(1, 0.3*inch))
        
        # Special Instructions
        if shipment_data.get('special_instructions'):
            content.append(Paragraph("Special Instructions", self.styles['CustomHeading']))
            content.append(Paragraph(shipment_data['special_instructions'], self.styles['CustomBody']))
            content.append(Spacer(1, 0.3*inch))
        
        # Signature Section
        signature_data = [
            ['Shipper Signature:', '_' * 30, 'Date:', '_' * 15],
            ['', '', '', ''],
            ['Carrier Signature:', '_' * 30, 'Date:', '_' * 15],
            ['', '', '', ''],
            ['Receiver Signature:', '_' * 30, 'Date:', '_' * 15],
        ]
        
        signature_table = Table(signature_data, colWidths=[1.5*inch, 2.5*inch, 0.75*inch, 1.5*inch])
        signature_table.setStyle([
            ('FONTNAME', (0, 0), (0, -1), 'Helvetica-Bold'),
            ('FONTSIZE', (0, 0), (-1, -1), 9),
            ('VALIGN', (0, 0), (-1, -1), 'TOP'),
        ])
        content.append(signature_table)
        
        # Generate PDF
        filename = f"BOL_{shipment_data.get('bol_number', 'unknown')}.pdf"
        return self.generate(content, filename=filename, header_title="Bill of Lading")
    
    def generate_packing_list(self, shipment_data):
        """
        Generate a Packing List
        
        Args:
            shipment_data: Dictionary containing shipment information
        
        Returns:
            BytesIO buffer containing the packing list PDF
        """
        content = []
        
        # Title
        title = Paragraph("PACKING LIST", self.styles['CustomTitle'])
        content.append(title)
        content.append(Spacer(1, 0.2*inch))
        
        # Header Information
        header_data = [
            ['Packing List #:', f"<b>{shipment_data.get('packing_list_number', 'N/A')}</b>"],
            ['Date:', datetime.now().strftime("%Y-%m-%d")],
            ['Customer:', shipment_data.get('customer_name', 'N/A')],
            ['PO Number:', shipment_data.get('po_number', 'N/A')],
            ['Job Number:', shipment_data.get('job_number', 'N/A')],
        ]
        header_table = Table(header_data, colWidths=[2*inch, 4.5*inch])
        header_table.setStyle([
            ('FONTNAME', (0, 0), (0, -1), 'Helvetica-Bold'),
            ('FONTSIZE', (0, 0), (-1, -1), 11),
        ])
        content.append(header_table)
        content.append(Spacer(1, 0.3*inch))
        
        # Items Detail Table
        content.append(Paragraph("Items Detail", self.styles['CustomHeading']))
        items_data = [['Item', 'Part Number', 'Description', 'Qty', 'Weight', 'Package']]
        
        for idx, item in enumerate(shipment_data.get('items', []), 1):
            items_data.append([
                str(idx),
                item.get('part_number', ''),
                item.get('description', ''),
                str(item.get('quantity', 0)),
                f"{item.get('weight', 0):,.0f}",
                item.get('package_id', ''),
            ])
        
        # Add totals
        total_qty = sum(item.get('quantity', 0) for item in shipment_data.get('items', []))
        total_weight = sum(item.get('weight', 0) for item in shipment_data.get('items', []))
        items_data.append([
            '', '', '<b>TOTALS:</b>', f'<b>{total_qty}</b>', f'<b>{total_weight:,.0f}</b>', ''
        ])
        
        items_table = self.create_table(
            items_data,
            col_widths=[0.5*inch, 1.25*inch, 2*inch, 0.75*inch, 1*inch, 1*inch]
        )
        content.append(items_table)
        content.append(Spacer(1, 0.3*inch))
        
        # Notes
        if shipment_data.get('notes'):
            content.append(Paragraph("Notes", self.styles['CustomHeading']))
            content.append(Paragraph(shipment_data['notes'], self.styles['CustomBody']))
        
        # Generate PDF
        filename = f"PackingList_{shipment_data.get('packing_list_number', 'unknown')}.pdf"
        return self.generate(content, filename=filename, header_title="Packing List")
