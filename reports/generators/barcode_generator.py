"""
Barcode and QR Code Generator
"""
from io import BytesIO
import barcode
from barcode.writer import ImageWriter
import qrcode
from PIL import Image, ImageDraw, ImageFont


class BarcodeGenerator:
    """Generate barcodes and QR codes for inventory tracking"""
    
    @staticmethod
    def generate_barcode(code, barcode_type='code128', add_text=True):
        """
        Generate a barcode image
        
        Args:
            code: The code to encode
            barcode_type: Type of barcode (code128, code39, ean13, etc.)
            add_text: Whether to include human-readable text
        
        Returns:
            BytesIO buffer containing the barcode image
        """
        try:
            # Get the barcode class
            barcode_class = barcode.get_barcode_class(barcode_type)
            
            # Create the barcode
            code_instance = barcode_class(str(code), writer=ImageWriter())
            
            # Generate to buffer
            buffer = BytesIO()
            code_instance.write(buffer, options={
                'module_width': 0.3,
                'module_height': 15.0,
                'quiet_zone': 6.5,
                'font_size': 10 if add_text else 0,
                'text_distance': 5.0,
                'write_text': add_text,
            })
            
            buffer.seek(0)
            return buffer
            
        except Exception as e:
            raise ValueError(f"Error generating barcode: {str(e)}")
    
    @staticmethod
    def generate_qr_code(data, size=200, error_correction='M'):
        """
        Generate a QR code image
        
        Args:
            data: Data to encode in the QR code
            size: Size of the QR code in pixels
            error_correction: Error correction level (L, M, Q, H)
        
        Returns:
            BytesIO buffer containing the QR code image
        """
        error_levels = {
            'L': qrcode.constants.ERROR_CORRECT_L,
            'M': qrcode.constants.ERROR_CORRECT_M,
            'Q': qrcode.constants.ERROR_CORRECT_Q,
            'H': qrcode.constants.ERROR_CORRECT_H,
        }
        
        qr = qrcode.QRCode(
            version=1,
            error_correction=error_levels.get(error_correction, qrcode.constants.ERROR_CORRECT_M),
            box_size=10,
            border=4,
        )
        
        qr.add_data(str(data))
        qr.make(fit=True)
        
        img = qr.make_image(fill_color="black", back_color="white")
        img = img.resize((size, size), Image.Resampling.LANCZOS)
        
        buffer = BytesIO()
        img.save(buffer, format='PNG')
        buffer.seek(0)
        
        return buffer
    
    @staticmethod
    def create_label_with_barcode(text, barcode_data, width=400, height=200):
        """
        Create a label image with text and barcode
        
        Args:
            text: Text to display above the barcode
            barcode_data: Data to encode in the barcode
            width: Label width in pixels
            height: Label height in pixels
        
        Returns:
            BytesIO buffer containing the label image
        """
        # Create a white background
        img = Image.new('RGB', (width, height), 'white')
        draw = ImageDraw.Draw(img)
        
        try:
            # Try to use a better font
            font_large = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf", 20)
            font_small = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf", 14)
        except:
            # Fallback to default font
            font_large = ImageFont.load_default()
            font_small = ImageFont.load_default()
        
        # Draw text
        text_bbox = draw.textbbox((0, 0), text, font=font_large)
        text_width = text_bbox[2] - text_bbox[0]
        text_x = (width - text_width) // 2
        draw.text((text_x, 20), text, fill='black', font=font_large)
        
        # Generate barcode
        barcode_buffer = BarcodeGenerator.generate_barcode(barcode_data, add_text=True)
        barcode_img = Image.open(barcode_buffer)
        
        # Resize barcode to fit
        barcode_width = width - 40
        barcode_height = height - 80
        barcode_img.thumbnail((barcode_width, barcode_height), Image.Resampling.LANCZOS)
        
        # Paste barcode
        barcode_x = (width - barcode_img.width) // 2
        barcode_y = 60
        img.paste(barcode_img, (barcode_x, barcode_y))
        
        # Save to buffer
        buffer = BytesIO()
        img.save(buffer, format='PNG')
        buffer.seek(0)
        
        return buffer
