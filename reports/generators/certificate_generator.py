"""
Mill Test Certificate (MTC) Generator
"""
from reportlab.lib.units import inch
from reportlab.platypus import Paragraph, Spacer, Table, PageBreak
from reportlab.lib import colors
from datetime import datetime
from .pdf_generator import PDFGenerator


class CertificateGenerator(PDFGenerator):
    """Generate Mill Test Certificates for coils"""
    
    def generate_mtc(self, coil_data, test_results=None):
        """
        Generate a Mill Test Certificate PDF
        
        Args:
            coil_data: Dictionary containing coil information
            test_results: Dictionary containing test results (chemical, mechanical)
        
        Returns:
            BytesIO buffer containing the PDF
        """
        content = []
        
        # Title
        title = Paragraph("MILL TEST CERTIFICATE", self.styles['CustomTitle'])
        content.append(title)
        content.append(Spacer(1, 0.3*inch))
        
        # Certificate Number
        cert_number = coil_data.get('certificate_number', 'N/A')
        cert_para = Paragraph(f"Certificate No: <b>{cert_number}</b>", self.styles['CustomHeading'])
        content.append(cert_para)
        content.append(Spacer(1, 0.2*inch))
        
        # Coil Information Section
        content.append(Paragraph("Coil Information", self.styles['CustomHeading']))
        
        coil_info_data = [
            ['Field', 'Value'],
            ['Coil Number', coil_data.get('coil_number', 'N/A')],
            ['Heat Number', coil_data.get('heat_number', 'N/A')],
            ['Alloy', coil_data.get('alloy', 'N/A')],
            ['Temper', coil_data.get('temper', 'N/A')],
            ['Gauge', f"{coil_data.get('gauge', 0):.4f} in"],
            ['Width', f"{coil_data.get('width', 0):.3f} in"],
            ['Weight', f"{coil_data.get('weight', 0):,.0f} lbs"],
            ['Mill', coil_data.get('mill', 'N/A')],
        ]
        
        coil_info_table = self.create_table(coil_info_data, col_widths=[2.5*inch, 4*inch])
        content.append(coil_info_table)
        content.append(Spacer(1, 0.3*inch))
        
        # Chemical Analysis Section
        if test_results and 'chemical' in test_results:
            content.append(Paragraph("Chemical Analysis (%)", self.styles['CustomHeading']))
            
            chemical_data = [['Element', 'Specification', 'Actual']]
            for element, values in test_results['chemical'].items():
                chemical_data.append([
                    element,
                    values.get('spec', 'N/A'),
                    f"{values.get('actual', 0):.4f}"
                ])
            
            chemical_table = self.create_table(chemical_data, col_widths=[2*inch, 2*inch, 2.5*inch])
            content.append(chemical_table)
            content.append(Spacer(1, 0.3*inch))
        
        # Mechanical Properties Section
        if test_results and 'mechanical' in test_results:
            content.append(Paragraph("Mechanical Properties", self.styles['CustomHeading']))
            
            mechanical_data = [['Property', 'Specification', 'Actual', 'Unit']]
            for prop, values in test_results['mechanical'].items():
                mechanical_data.append([
                    prop,
                    values.get('spec', 'N/A'),
                    f"{values.get('actual', 0):.2f}",
                    values.get('unit', '')
                ])
            
            mechanical_table = self.create_table(mechanical_data, col_widths=[2.5*inch, 1.5*inch, 1.5*inch, 1*inch])
            content.append(mechanical_table)
            content.append(Spacer(1, 0.3*inch))
        
        # Certification Statement
        content.append(Spacer(1, 0.3*inch))
        cert_statement = """
        This is to certify that the material described above has been manufactured 
        and tested in accordance with the applicable specifications and standards. 
        The test results shown are representative of the material supplied.
        """
        content.append(Paragraph(cert_statement, self.styles['CustomBody']))
        content.append(Spacer(1, 0.5*inch))
        
        # Signature Section
        signature_data = [
            ['Certified By:', '_' * 30, 'Date:', '_' * 20],
            ['Quality Manager', '', datetime.now().strftime("%Y-%m-%d"), '']
        ]
        
        signature_table = Table(signature_data, colWidths=[1.5*inch, 2.5*inch, 0.75*inch, 1.5*inch])
        signature_table.setStyle([
            ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
            ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
            ('FONTSIZE', (0, 0), (-1, -1), 10),
            ('VALIGN', (0, 0), (-1, -1), 'TOP'),
        ])
        content.append(signature_table)
        
        # Generate PDF
        filename = f"MTC_{coil_data.get('coil_number', 'unknown')}.pdf"
        return self.generate(content, filename=filename, header_title="Mill Test Certificate")
    
    def generate_certificate_batch(self, coils_data):
        """
        Generate a batch of certificates for multiple coils
        
        Args:
            coils_data: List of dictionaries containing coil information
        
        Returns:
            BytesIO buffer containing the PDF with all certificates
        """
        content = []
        
        for i, coil_data in enumerate(coils_data):
            # Generate certificate content for this coil
            cert_content = self._generate_single_certificate_content(coil_data)
            content.extend(cert_content)
            
            # Add page break between certificates (except for the last one)
            if i < len(coils_data) - 1:
                content.append(PageBreak())
        
        # Generate PDF
        filename = f"MTC_Batch_{datetime.now().strftime('%Y%m%d_%H%M%S')}.pdf"
        return self.generate(content, filename=filename, header_title="Mill Test Certificates")
    
    def _generate_single_certificate_content(self, coil_data):
        """Helper method to generate content for a single certificate"""
        content = []
        
        # Title
        title = Paragraph("MILL TEST CERTIFICATE", self.styles['CustomTitle'])
        content.append(title)
        content.append(Spacer(1, 0.2*inch))
        
        # Basic coil info table
        coil_info_data = [
            ['Field', 'Value'],
            ['Coil Number', coil_data.get('coil_number', 'N/A')],
            ['Heat Number', coil_data.get('heat_number', 'N/A')],
            ['Alloy', coil_data.get('alloy', 'N/A')],
            ['Gauge', f"{coil_data.get('gauge', 0):.4f} in"],
            ['Weight', f"{coil_data.get('weight', 0):,.0f} lbs"],
        ]
        
        coil_info_table = self.create_table(coil_info_data, col_widths=[2*inch, 4*inch])
        content.append(coil_info_table)
        
        return content
