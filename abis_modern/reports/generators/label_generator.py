"""
Coil Label Generator
"""
from reportlab.lib.units import inch
from reportlab.lib.pagesizes import letter
from reportlab.platypus import Paragraph, Spacer, Table, Image as RLImage
from reportlab.lib import colors
from reportlab.lib.styles import ParagraphStyle
from reportlab.lib.enums import TA_CENTER
from .pdf_generator import PDFGenerator
from .barcode_generator import BarcodeGenerator


class LabelGenerator(PDFGenerator):
    """Generate printable labels for coils and inventory"""
    
    def __init__(self):
        # Use smaller page size for labels (4x6 inch)
        super().__init__(page_size=(4*inch, 6*inch))
        
        # Add label-specific styles
        self.styles.add(ParagraphStyle(
            name='LabelTitle',
            parent=self.styles['Heading1'],
            fontSize=18,
            textColor=colors.black,
            spaceAfter=10,
            alignment=TA_CENTER,
            fontName='Helvetica-Bold'
        ))
        
        self.styles.add(ParagraphStyle(
            name='LabelText',
            parent=self.styles['Normal'],
            fontSize=12,
            textColor=colors.black,
            spaceAfter=6,
            fontName='Helvetica'
        ))
    
    def generate_coil_label(self, coil_data):
        """
        Generate a label for a coil with barcode
        
        Args:
            coil_data: Dictionary containing coil information
        
        Returns:
            BytesIO buffer containing the label PDF
        """
        content = []
        
        # Company name
        content.append(Paragraph("ABIS", self.styles['LabelTitle']))
        content.append(Spacer(1, 0.1*inch))
        
        # Coil information table
        label_data = [
            ['Coil:', f"<b>{coil_data.get('coil_number', 'N/A')}</b>"],
            ['Heat:', coil_data.get('heat_number', 'N/A')],
            ['Alloy:', coil_data.get('alloy', 'N/A')],
            ['Temper:', coil_data.get('temper', 'N/A')],
            ['Gauge:', f"{coil_data.get('gauge', 0):.4f}\""],
            ['Width:', f"{coil_data.get('width', 0):.2f}\""],
            ['Weight:', f"{coil_data.get('weight', 0):,.0f} lbs"],
        ]
        
        label_table = Table(label_data, colWidths=[1*inch, 2.5*inch])
        label_table.setStyle([
            ('ALIGN', (0, 0), (0, -1), 'RIGHT'),
            ('ALIGN', (1, 0), (1, -1), 'LEFT'),
            ('FONTNAME', (0, 0), (0, -1), 'Helvetica-Bold'),
            ('FONTNAME', (1, 0), (1, -1), 'Helvetica'),
            ('FONTSIZE', (0, 0), (-1, -1), 11),
            ('VALIGN', (0, 0), (-1, -1), 'MIDDLE'),
            ('TOPPADDING', (0, 0), (-1, -1), 3),
            ('BOTTOMPADDING', (0, 0), (-1, -1), 3),
        ])
        
        content.append(label_table)
        content.append(Spacer(1, 0.15*inch))
        
        # Generate barcode
        coil_number = coil_data.get('coil_number', 'UNKNOWN')
        try:
            barcode_buffer = BarcodeGenerator.generate_barcode(coil_number, barcode_type='code128')
            barcode_img = RLImage(barcode_buffer, width=3*inch, height=0.8*inch)
            content.append(barcode_img)
        except Exception as e:
            # If barcode generation fails, just add text
            content.append(Paragraph(f"Barcode: {coil_number}", self.styles['LabelText']))
        
        # Generate PDF without headers/footers for labels
        buffer = self.create_buffer()
        doc = self.create_document(buffer, title=f"Label_{coil_number}.pdf")
        doc.build(content)
        
        buffer.seek(0)
        return buffer
    
    def generate_skid_label(self, skid_data):
        """
        Generate a label for a skid with QR code
        
        Args:
            skid_data: Dictionary containing skid information
        
        Returns:
            BytesIO buffer containing the label PDF
        """
        content = []
        
        # Company name
        content.append(Paragraph("ABIS - SKID LABEL", self.styles['LabelTitle']))
        content.append(Spacer(1, 0.1*inch))
        
        # Skid information table
        label_data = [
            ['Skid #:', f"<b>{skid_data.get('skid_number', 'N/A')}</b>"],
            ['Customer:', skid_data.get('customer', 'N/A')],
            ['Job #:', skid_data.get('job_number', 'N/A')],
            ['Pieces:', str(skid_data.get('piece_count', 0))],
            ['Weight:', f"{skid_data.get('total_weight', 0):,.0f} lbs"],
        ]
        
        label_table = Table(label_data, colWidths=[1*inch, 2.5*inch])
        label_table.setStyle([
            ('ALIGN', (0, 0), (0, -1), 'RIGHT'),
            ('ALIGN', (1, 0), (1, -1), 'LEFT'),
            ('FONTNAME', (0, 0), (0, -1), 'Helvetica-Bold'),
            ('FONTNAME', (1, 0), (1, -1), 'Helvetica'),
            ('FONTSIZE', (0, 0), (-1, -1), 11),
            ('VALIGN', (0, 0), (-1, -1), 'MIDDLE'),
            ('TOPPADDING', (0, 0), (-1, -1), 3),
            ('BOTTOMPADDING', (0, 0), (-1, -1), 3),
        ])
        
        content.append(label_table)
        content.append(Spacer(1, 0.2*inch))
        
        # Generate QR code with skid data
        skid_number = skid_data.get('skid_number', 'UNKNOWN')
        try:
            qr_data = f"SKID:{skid_number}|JOB:{skid_data.get('job_number', '')}"
            qr_buffer = BarcodeGenerator.generate_qr_code(qr_data, size=150)
            qr_img = RLImage(qr_buffer, width=1.5*inch, height=1.5*inch)
            content.append(qr_img)
        except Exception as e:
            content.append(Paragraph(f"Skid: {skid_number}", self.styles['LabelText']))
        
        # Generate PDF
        buffer = self.create_buffer()
        doc = self.create_document(buffer, title=f"Label_Skid_{skid_number}.pdf")
        doc.build(content)
        
        buffer.seek(0)
        return buffer
    
    def generate_batch_labels(self, items_data, label_type='coil'):
        """
        Generate multiple labels on a single page
        
        Args:
            items_data: List of dictionaries containing item information
            label_type: Type of label ('coil' or 'skid')
        
        Returns:
            BytesIO buffer containing the PDF with all labels
        """
        from reportlab.platypus import PageBreak
        
        content = []
        
        for i, item_data in enumerate(items_data):
            if label_type == 'coil':
                # Generate coil label content (without creating separate PDF)
                content.extend(self._generate_coil_label_content(item_data))
            else:
                # Generate skid label content
                content.extend(self._generate_skid_label_content(item_data))
            
            # Add page break between labels
            if i < len(items_data) - 1:
                content.append(PageBreak())
        
        # Generate single PDF with all labels
        buffer = self.create_buffer()
        doc = self.create_document(buffer, title=f"Labels_Batch.pdf")
        doc.build(content)
        
        buffer.seek(0)
        return buffer
    
    def _generate_coil_label_content(self, coil_data):
        """Helper to generate coil label content without PDF wrapper"""
        content = []
        content.append(Paragraph("ABIS", self.styles['LabelTitle']))
        content.append(Spacer(1, 0.1*inch))
        
        label_data = [
            ['Coil:', f"<b>{coil_data.get('coil_number', 'N/A')}</b>"],
            ['Alloy:', coil_data.get('alloy', 'N/A')],
            ['Gauge:', f"{coil_data.get('gauge', 0):.4f}\""],
            ['Weight:', f"{coil_data.get('weight', 0):,.0f} lbs"],
        ]
        
        label_table = Table(label_data, colWidths=[1*inch, 2.5*inch])
        label_table.setStyle([
            ('FONTSIZE', (0, 0), (-1, -1), 11),
            ('VALIGN', (0, 0), (-1, -1), 'MIDDLE'),
        ])
        content.append(label_table)
        
        return content
    
    def _generate_skid_label_content(self, skid_data):
        """Helper to generate skid label content without PDF wrapper"""
        content = []
        content.append(Paragraph("ABIS - SKID", self.styles['LabelTitle']))
        content.append(Spacer(1, 0.1*inch))
        
        label_data = [
            ['Skid:', f"<b>{skid_data.get('skid_number', 'N/A')}</b>"],
            ['Job:', skid_data.get('job_number', 'N/A')],
            ['Weight:', f"{skid_data.get('total_weight', 0):,.0f} lbs"],
        ]
        
        label_table = Table(label_data, colWidths=[1*inch, 2.5*inch])
        label_table.setStyle([
            ('FONTSIZE', (0, 0), (-1, -1), 11),
        ])
        content.append(label_table)
        
        return content
