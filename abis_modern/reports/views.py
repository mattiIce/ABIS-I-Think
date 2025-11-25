"""
Report generation API views
"""
from django.http import HttpResponse, FileResponse
from rest_framework import status
from rest_framework.decorators import api_view, permission_classes, action
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import viewsets

from inventory.models import Coil, Skid
from shipping.models import Shipment
from production.models import Job

from .generators import (
    CertificateGenerator,
    LabelGenerator,
    ShipmentDocumentGenerator,
    BarcodeGenerator
)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def generate_coil_certificate(request, coil_id):
    """Generate Mill Test Certificate for a coil"""
    try:
        coil = Coil.objects.get(id=coil_id)
        
        # Prepare coil data
        coil_data = {
            'certificate_number': f"MTC-{coil.coil_number}",
            'coil_number': coil.coil_number,
            'heat_number': coil.heat_number or 'N/A',
            'alloy': coil.alloy or 'N/A',
            'temper': coil.temper or 'N/A',
            'gauge': float(coil.gauge) if coil.gauge else 0,
            'width': float(coil.width) if coil.width else 0,
            'weight': float(coil.weight) if coil.weight else 0,
            'mill': coil.mill or 'N/A',
        }
        
        # Get test results if available
        test_results = None
        if hasattr(coil, 'test_results') and coil.test_results:
            test_results = coil.test_results
        
        # Generate PDF
        generator = CertificateGenerator()
        pdf_buffer = generator.generate_mtc(coil_data, test_results)
        
        # Return as downloadable file
        response = HttpResponse(pdf_buffer.read(), content_type='application/pdf')
        response['Content-Disposition'] = f'attachment; filename="MTC_{coil.coil_number}.pdf"'
        return response
        
    except Coil.DoesNotExist:
        return Response({'error': 'Coil not found'}, status=status.HTTP_404_NOT_FOUND)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def generate_coil_label(request, coil_id):
    """Generate printable label for a coil"""
    try:
        coil = Coil.objects.get(id=coil_id)
        
        coil_data = {
            'coil_number': coil.coil_number,
            'heat_number': coil.heat_number or 'N/A',
            'alloy': coil.alloy or 'N/A',
            'temper': coil.temper or 'N/A',
            'gauge': float(coil.gauge) if coil.gauge else 0,
            'width': float(coil.width) if coil.width else 0,
            'weight': float(coil.weight) if coil.weight else 0,
        }
        
        generator = LabelGenerator()
        pdf_buffer = generator.generate_coil_label(coil_data)
        
        response = HttpResponse(pdf_buffer.read(), content_type='application/pdf')
        response['Content-Disposition'] = f'attachment; filename="Label_{coil.coil_number}.pdf"'
        return response
        
    except Coil.DoesNotExist:
        return Response({'error': 'Coil not found'}, status=status.HTTP_404_NOT_FOUND)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def generate_skid_label(request, skid_id):
    """Generate printable label for a skid"""
    try:
        skid = Skid.objects.select_related('job', 'job__customer').get(id=skid_id)
        
        skid_data = {
            'skid_number': skid.skid_number,
            'customer': skid.job.customer.name if skid.job and skid.job.customer else 'N/A',
            'job_number': skid.job.job_number if skid.job else 'N/A',
            'piece_count': skid.piece_count or 0,
            'total_weight': float(skid.total_weight) if skid.total_weight else 0,
        }
        
        generator = LabelGenerator()
        pdf_buffer = generator.generate_skid_label(skid_data)
        
        response = HttpResponse(pdf_buffer.read(), content_type='application/pdf')
        response['Content-Disposition'] = f'attachment; filename="Label_Skid_{skid.skid_number}.pdf"'
        return response
        
    except Skid.DoesNotExist:
        return Response({'error': 'Skid not found'}, status=status.HTTP_404_NOT_FOUND)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def generate_bol(request, bol_id):
    """Generate Bill of Lading document"""
    try:
        shipment = Shipment.objects.select_related(
            'customer',
            'carrier'
        ).prefetch_related('skids').get(id=bol_id)
        
        shipment_data = {
            'bol_number': shipment.bol_number,
            'ship_date': shipment.ship_date.strftime('%Y-%m-%d') if shipment.ship_date else 'N/A',
            'shipper_name': 'ABIS',
            'shipper_address': '',  # Add your company address
            'shipper_city_state_zip': '',
            'shipper_phone': '',
            'customer_name': shipment.customer.company_name if shipment.customer else 'N/A',
            'customer_address': shipment.destination_address or '',
            'customer_city_state_zip': f"{shipment.destination_city}, {shipment.destination_state} {shipment.destination_zip}" if shipment.destination_city else '',
            'customer_phone': shipment.customer.phone if shipment.customer else '',
            'carrier_name': str(shipment.carrier) if shipment.carrier else 'N/A',
            'trailer_number': shipment.trailer_number or 'N/A',
            'seal_number': shipment.seal_number or 'N/A',
            'pro_number': shipment.pro_number or 'N/A',
            'items': [],
            'special_instructions': shipment.notes or '',
        }
        
        # Add skids as items
        for idx, skid in enumerate(shipment.skids.all(), 1):
            shipment_data['items'].append({
                'item_number': str(idx),
                'description': f'Skid {skid.skid_number}',
                'quantity': skid.piece_count or 0,
                'weight': float(skid.gross_weight) if skid.gross_weight else 0,
                'package_type': 'Skid',
            })
        
        generator = ShipmentDocumentGenerator()
        pdf_buffer = generator.generate_bill_of_lading(shipment_data)
        
        response = HttpResponse(pdf_buffer.read(), content_type='application/pdf')
        response['Content-Disposition'] = f'attachment; filename="BOL_{shipment.bol_number}.pdf"'
        return response
        
    except Shipment.DoesNotExist:
        return Response({'error': 'Shipment not found'}, status=status.HTTP_404_NOT_FOUND)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def generate_packing_list(request, shipment_id):
    """Generate Packing List for a shipment"""
    try:
        shipment = Shipment.objects.select_related('customer', 'job').prefetch_related('items').get(id=shipment_id)
        
        shipment_data = {
            'packing_list_number': f"PL-{shipment.shipment_number}",
            'customer_name': shipment.customer.name if shipment.customer else 'N/A',
            'po_number': shipment.customer_po if hasattr(shipment, 'customer_po') else 'N/A',
            'job_number': shipment.job.job_number if shipment.job else 'N/A',
            'items': [],
            'notes': shipment.notes if hasattr(shipment, 'notes') else '',
        }
        
        # Add items from shipment
        for item in shipment.items.all():
            shipment_data['items'].append({
                'part_number': item.part_number if hasattr(item, 'part_number') else '',
                'description': item.description or 'Material',
                'quantity': item.quantity or 0,
                'weight': float(item.weight) if item.weight else 0,
                'package_id': item.package_id if hasattr(item, 'package_id') else '',
            })
        
        generator = ShipmentDocumentGenerator()
        pdf_buffer = generator.generate_packing_list(shipment_data)
        
        response = HttpResponse(pdf_buffer.read(), content_type='application/pdf')
        response['Content-Disposition'] = f'attachment; filename="PackingList_{shipment.shipment_number}.pdf"'
        return response
        
    except Shipment.DoesNotExist:
        return Response({'error': 'Shipment not found'}, status=status.HTTP_404_NOT_FOUND)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def generate_barcode(request):
    """Generate a standalone barcode image"""
    try:
        code = request.GET.get('code')
        barcode_type = request.GET.get('type', 'code128')
        
        if not code:
            return Response({'error': 'Code parameter required'}, status=status.HTTP_400_BAD_REQUEST)
        
        barcode_buffer = BarcodeGenerator.generate_barcode(code, barcode_type=barcode_type)
        
        response = HttpResponse(barcode_buffer.read(), content_type='image/png')
        response['Content-Disposition'] = f'inline; filename="barcode_{code}.png"'
        return response
        
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def generate_qr_code(request):
    """Generate a standalone QR code image"""
    try:
        data = request.GET.get('data')
        size = int(request.GET.get('size', 200))
        
        if not data:
            return Response({'error': 'Data parameter required'}, status=status.HTTP_400_BAD_REQUEST)
        
        qr_buffer = BarcodeGenerator.generate_qr_code(data, size=size)
        
        response = HttpResponse(qr_buffer.read(), content_type='image/png')
        response['Content-Disposition'] = f'inline; filename="qrcode.png"'
        return response
        
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['POST'])
@permission_classes([IsAuthenticated])
def generate_batch_labels(request):
    """Generate batch labels for multiple items"""
    try:
        item_ids = request.data.get('item_ids', [])
        label_type = request.data.get('label_type', 'coil')  # 'coil' or 'skid'
        
        if not item_ids:
            return Response({'error': 'item_ids required'}, status=status.HTTP_400_BAD_REQUEST)
        
        items_data = []
        
        if label_type == 'coil':
            coils = Coil.objects.filter(id__in=item_ids)
            for coil in coils:
                items_data.append({
                    'coil_number': coil.coil_number,
                    'heat_number': coil.heat_number or 'N/A',
                    'alloy': coil.alloy or 'N/A',
                    'temper': coil.temper or 'N/A',
                    'gauge': float(coil.gauge) if coil.gauge else 0,
                    'width': float(coil.width) if coil.width else 0,
                    'weight': float(coil.weight) if coil.weight else 0,
                })
        else:  # skid
            skids = Skid.objects.select_related('job', 'job__customer').filter(id__in=item_ids)
            for skid in skids:
                items_data.append({
                    'skid_number': skid.skid_number,
                    'customer': skid.job.customer.name if skid.job and skid.job.customer else 'N/A',
                    'job_number': skid.job.job_number if skid.job else 'N/A',
                    'piece_count': skid.piece_count or 0,
                    'total_weight': float(skid.total_weight) if skid.total_weight else 0,
                })
        
        generator = LabelGenerator()
        pdf_buffer = generator.generate_batch_labels(items_data, label_type=label_type)
        
        response = HttpResponse(pdf_buffer.read(), content_type='application/pdf')
        response['Content-Disposition'] = f'attachment; filename="Labels_Batch_{label_type}.pdf"'
        return response
        
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
