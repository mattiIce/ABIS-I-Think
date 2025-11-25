"""
Base PDF Generator using ReportLab
"""
from io import BytesIO
from reportlab.lib.pagesizes import letter, A4
from reportlab.lib.units import inch
from reportlab.lib import colors
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle, Image
from reportlab.platypus import PageBreak, KeepTogether
from reportlab.lib.enums import TA_CENTER, TA_LEFT, TA_RIGHT
from datetime import datetime


class PDFGenerator:
    """Base class for generating PDF documents"""
    
    def __init__(self, page_size=letter):
        self.page_size = page_size
        self.width, self.height = page_size
        self.styles = getSampleStyleSheet()
        self._setup_custom_styles()
        
    def _setup_custom_styles(self):
        """Setup custom paragraph styles"""
        self.styles.add(ParagraphStyle(
            name='CustomTitle',
            parent=self.styles['Heading1'],
            fontSize=24,
            textColor=colors.HexColor('#1f2937'),
            spaceAfter=30,
            alignment=TA_CENTER,
            fontName='Helvetica-Bold'
        ))
        
        self.styles.add(ParagraphStyle(
            name='CustomHeading',
            parent=self.styles['Heading2'],
            fontSize=14,
            textColor=colors.HexColor('#374151'),
            spaceAfter=12,
            spaceBefore=12,
            fontName='Helvetica-Bold'
        ))
        
        self.styles.add(ParagraphStyle(
            name='CustomBody',
            parent=self.styles['Normal'],
            fontSize=10,
            textColor=colors.HexColor('#4b5563'),
            spaceAfter=6,
        ))
        
        self.styles.add(ParagraphStyle(
            name='Footer',
            parent=self.styles['Normal'],
            fontSize=8,
            textColor=colors.HexColor('#9ca3af'),
            alignment=TA_CENTER,
        ))
    
    def create_buffer(self):
        """Create a BytesIO buffer for PDF content"""
        return BytesIO()
    
    def create_document(self, buffer, title="Document"):
        """Create a SimpleDocTemplate with standard settings"""
        doc = SimpleDocTemplate(
            buffer,
            pagesize=self.page_size,
            rightMargin=0.75*inch,
            leftMargin=0.75*inch,
            topMargin=0.75*inch,
            bottomMargin=0.75*inch,
            title=title
        )
        return doc
    
    def create_table(self, data, col_widths=None, style=None):
        """Create a formatted table"""
        table = Table(data, colWidths=col_widths)
        
        if style is None:
            style = TableStyle([
                ('BACKGROUND', (0, 0), (-1, 0), colors.HexColor('#3b82f6')),
                ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
                ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
                ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
                ('FONTSIZE', (0, 0), (-1, 0), 12),
                ('BOTTOMPADDING', (0, 0), (-1, 0), 12),
                ('BACKGROUND', (0, 1), (-1, -1), colors.white),
                ('TEXTCOLOR', (0, 1), (-1, -1), colors.black),
                ('FONTNAME', (0, 1), (-1, -1), 'Helvetica'),
                ('FONTSIZE', (0, 1), (-1, -1), 10),
                ('GRID', (0, 0), (-1, -1), 1, colors.HexColor('#e5e7eb')),
                ('VALIGN', (0, 0), (-1, -1), 'MIDDLE'),
                ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, colors.HexColor('#f9fafb')]),
            ])
        
        table.setStyle(style)
        return table
    
    def add_header(self, canvas, doc, company_name="ABIS", page_title=""):
        """Add header to each page"""
        canvas.saveState()
        canvas.setFont('Helvetica-Bold', 16)
        canvas.drawString(0.75*inch, self.height - 0.5*inch, company_name)
        
        if page_title:
            canvas.setFont('Helvetica', 12)
            canvas.drawRightString(self.width - 0.75*inch, self.height - 0.5*inch, page_title)
        
        canvas.setStrokeColor(colors.HexColor('#e5e7eb'))
        canvas.setLineWidth(1)
        canvas.line(0.75*inch, self.height - 0.6*inch, self.width - 0.75*inch, self.height - 0.6*inch)
        canvas.restoreState()
    
    def add_footer(self, canvas, doc):
        """Add footer to each page"""
        canvas.saveState()
        canvas.setFont('Helvetica', 8)
        canvas.setFillColor(colors.HexColor('#9ca3af'))
        
        page_num = f"Page {doc.page}"
        canvas.drawRightString(self.width - 0.75*inch, 0.5*inch, page_num)
        
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        canvas.drawString(0.75*inch, 0.5*inch, f"Generated: {timestamp}")
        
        canvas.restoreState()
    
    def generate(self, content, filename="document.pdf", header_title=""):
        """Generate PDF and return buffer"""
        buffer = self.create_buffer()
        doc = self.create_document(buffer, title=filename)
        
        def add_page_elements(canvas, doc):
            self.add_header(canvas, doc, page_title=header_title)
            self.add_footer(canvas, doc)
        
        doc.build(content, onFirstPage=add_page_elements, onLaterPages=add_page_elements)
        
        buffer.seek(0)
        return buffer
