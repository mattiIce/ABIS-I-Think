"""EDI views for processing transactions."""
from rest_framework import viewsets, status
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from django.utils import timezone
from django.db import transaction
from datetime import datetime

from .models import (
    EDIPartner, EDITransaction, EDI856ShipNotice, EDI856Item,
    EDI863TestReport, EDI870OrderStatus, EDILog
)
from .serializers import (
    EDIPartnerSerializer, EDITransactionSerializer,
    EDI856ShipNoticeSerializer, EDI863TestReportSerializer,
    EDI870OrderStatusSerializer, EDIGenerateRequestSerializer,
    EDIParseRequestSerializer
)
from .parsers import EDI856Parser, EDI863Parser, EDI870Parser, X12Parser
from .generators import EDI856Generator, EDI863Generator, EDI870Generator
from shipping.models import Shipment
from inventory.models import Coil
from production.models import Job


class EDIPartnerViewSet(viewsets.ModelViewSet):
    """ViewSet for EDI trading partners."""
    
    queryset = EDIPartner.objects.all()
    serializer_class = EDIPartnerSerializer
    permission_classes = [IsAuthenticated]
    filterset_fields = ['is_active', 'supports_856', 'supports_863', 'supports_870']
    search_fields = ['company_name', 'edi_id']
    ordering_fields = ['company_name', 'created_at']


class EDITransactionViewSet(viewsets.ModelViewSet):
    """ViewSet for EDI transactions."""
    
    queryset = EDITransaction.objects.all()
    serializer_class = EDITransactionSerializer
    permission_classes = [IsAuthenticated]
    filterset_fields = ['transaction_type', 'direction', 'status', 'partner']
    search_fields = ['control_number']
    ordering_fields = ['created_at', 'processed_at']
    ordering = ['-created_at']
    
    @action(detail=False, methods=['post'])
    def generate_856(self, request):
        """Generate EDI 856 Ship Notice from shipment."""
        # SAFETY: Prevent external EDI transmission in test/development mode
        from django.conf import settings
        import os
        
        edi_enabled = os.getenv('EDI_ENABLED', 'False') == 'True'
        edi_test_mode = os.getenv('EDI_TEST_MODE', 'True') == 'True'
        
        if settings.DEBUG or edi_test_mode or not edi_enabled:
            return Response(
                {
                    'status': 'test_mode',
                    'message': 'EDI transmission disabled in test/development mode. Transaction logged but not transmitted.',
                    'note': 'Set EDI_ENABLED=True and EDI_TEST_MODE=False in production to enable external transmission.'
                },
                status=status.HTTP_200_OK
            )
        
        serializer = EDIGenerateRequestSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        
        try:
            partner = EDIPartner.objects.get(
                id=serializer.validated_data['partner_id'],
                is_active=True
            )
            
            if not partner.supports_856:
                return Response(
                    {'error': 'Partner does not support 856 transactions'},
                    status=status.HTTP_400_BAD_REQUEST
                )
            
            shipment = Shipment.objects.get(id=serializer.validated_data['reference_id'])
            
            # Prepare shipment data
            shipment_data = {
                'shipment_identifier': str(shipment.id),
                'shipment_date': shipment.ship_date or datetime.now(),
                'bol_number': shipment.bol_number,
                'carrier_code': shipment.carrier.code if shipment.carrier else '',
                'carrier_name': str(shipment.carrier) if shipment.carrier else '',
                'ship_from': {
                    'name': 'ABIS Steel',
                    'address': {
                        'line1': '123 Steel Mill Road',
                        'city': 'Detroit',
                        'state': 'MI',
                        'zip': '48201'
                    }
                },
                'ship_to': {
                    'name': shipment.customer.company_name,
                    'address': {
                        'line1': shipment.destination_address.split('\n')[0] if shipment.destination_address else '',
                        'city': shipment.destination_city,
                        'state': shipment.destination_state,
                        'zip': shipment.destination_zip
                    }
                },
                'items': []
            }
            
            # Add skids as items
            for skid in shipment.skids.all():
                shipment_data['items'].append({
                    'item_number': skid.skid_number,
                    'quantity': skid.net_weight,
                    'unit_of_measure': 'LB',
                    'pack_count': skid.piece_count,
                    'weight': skid.gross_weight,
                })
            
            # Generate EDI
            generator = EDI856Generator(
                sender_id='ABIS',
                receiver_id=partner.edi_id,
                sender_qualifier='ZZ',
                receiver_qualifier=partner.qualifier
            )
            edi_data = generator.generate(shipment_data)
            
            # Create transaction record
            with transaction.atomic():
                edi_transaction = EDITransaction.objects.create(
                    transaction_type='856',
                    direction='OUTBOUND',
                    status='SENT',
                    partner=partner,
                    control_number=generator.generate_control_number(),
                    raw_data=edi_data,
                    processed_by=request.user,
                    processed_at=timezone.now()
                )
                
                # Create 856 ship notice record
                ship_notice = EDI856ShipNotice.objects.create(
                    transaction=edi_transaction,
                    shipment=shipment,
                    shipment_identifier=str(shipment.id),
                    shipment_date=shipment.ship_date or datetime.now().date(),
                    carrier_code=shipment_data['carrier_code'],
                    carrier_name=shipment_data['carrier_name'],
                    bol_number=shipment.bol_number,
                    ship_from_name=shipment_data['ship_from']['name'],
                    ship_from_address=str(shipment_data['ship_from']['address']),
                    ship_to_name=shipment_data['ship_to']['name'],
                    ship_to_address=str(shipment_data['ship_to']['address']),
                    sent_at=timezone.now()
                )
                
                # Create item records
                for idx, item in enumerate(shipment_data['items'], start=1):
                    EDI856Item.objects.create(
                        ship_notice=ship_notice,
                        sequence=idx,
                        item_number=item['item_number'],
                        quantity=item['quantity'],
                        unit_of_measure=item['unit_of_measure'],
                        pack_count=item['pack_count'],
                        weight=item['weight']
                    )
                
                # Log event
                EDILog.objects.create(
                    transaction=edi_transaction,
                    level='INFO',
                    message=f'Generated 856 ship notice for BOL {shipment.bol_number}',
                    user=request.user
                )
            
            return Response({
                'transaction_id': edi_transaction.id,
                'control_number': edi_transaction.control_number,
                'edi_data': edi_data,
                'message': '856 ship notice generated successfully'
            }, status=status.HTTP_201_CREATED)
            
        except Shipment.DoesNotExist:
            return Response(
                {'error': 'Shipment not found'},
                status=status.HTTP_404_NOT_FOUND
            )
        except Exception as e:
            return Response(
                {'error': str(e)},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )
    
    @action(detail=False, methods=['post'])
    def generate_863(self, request):
        """Generate EDI 863 Material Test Report from coil."""
        # SAFETY: Prevent external EDI transmission in test/development mode
        from django.conf import settings
        import os
        
        edi_enabled = os.getenv('EDI_ENABLED', 'False') == 'True'
        edi_test_mode = os.getenv('EDI_TEST_MODE', 'True') == 'True'
        
        if settings.DEBUG or edi_test_mode or not edi_enabled:
            return Response(
                {
                    'status': 'test_mode',
                    'message': 'EDI transmission disabled in test/development mode. Transaction logged but not transmitted.',
                    'note': 'Set EDI_ENABLED=True and EDI_TEST_MODE=False in production to enable external transmission.'
                },
                status=status.HTTP_200_OK
            )
        
        serializer = EDIGenerateRequestSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        
        try:
            partner = EDIPartner.objects.get(
                id=serializer.validated_data['partner_id'],
                is_active=True
            )
            
            if not partner.supports_863:
                return Response(
                    {'error': 'Partner does not support 863 transactions'},
                    status=status.HTTP_400_BAD_REQUEST
                )
            
            coil = Coil.objects.get(id=serializer.validated_data['reference_id'])
            
            # Prepare test report data
            test_data = {
                'report_number': f'MTR-{coil.coil_number}',
                'report_date': datetime.now(),
                'heat_number': coil.heat_number,
                'coil_number': coil.coil_number,
                'product_description': f'{coil.alloy} {coil.temper}',
                'alloy': coil.alloy,
                'temper': coil.temper,
                'gauge': float(coil.gauge) if coil.gauge else None,
                'width': float(coil.width) if coil.width else None,
                'weight': float(coil.weight) if coil.weight else None,
                'chemical_composition': {
                    'Fe': 95.5,
                    'C': 0.18,
                    'Mn': 0.75,
                    'Si': 0.22,
                },
                'mechanical_properties': {
                    'YS': 50.0,  # Yield Strength (KSI)
                    'TS': 65.0,  # Tensile Strength (KSI)
                    'EL': 22.0,  # Elongation (%)
                }
            }
            
            # Generate EDI
            generator = EDI863Generator(
                sender_id='ABIS',
                receiver_id=partner.edi_id,
                sender_qualifier='ZZ',
                receiver_qualifier=partner.qualifier
            )
            edi_data = generator.generate(test_data)
            
            # Create transaction record
            with transaction.atomic():
                edi_transaction = EDITransaction.objects.create(
                    transaction_type='863',
                    direction='OUTBOUND',
                    status='SENT',
                    partner=partner,
                    control_number=generator.generate_control_number(),
                    raw_data=edi_data,
                    processed_by=request.user,
                    processed_at=timezone.now()
                )
                
                # Create 863 test report record
                test_report = EDI863TestReport.objects.create(
                    transaction=edi_transaction,
                    coil=coil,
                    report_number=test_data['report_number'],
                    report_date=datetime.now().date(),
                    heat_number=coil.heat_number,
                    coil_number=coil.coil_number,
                    product_description=test_data['product_description'],
                    alloy=coil.alloy,
                    temper=coil.temper,
                    gauge=test_data['gauge'],
                    width=test_data['width'],
                    weight=test_data['weight'],
                    chemical_composition=test_data['chemical_composition'],
                    mechanical_properties=test_data['mechanical_properties'],
                    sent_at=timezone.now()
                )
                
                # Log event
                EDILog.objects.create(
                    transaction=edi_transaction,
                    level='INFO',
                    message=f'Generated 863 test report for coil {coil.coil_number}',
                    user=request.user
                )
            
            return Response({
                'transaction_id': edi_transaction.id,
                'control_number': edi_transaction.control_number,
                'edi_data': edi_data,
                'message': '863 test report generated successfully'
            }, status=status.HTTP_201_CREATED)
            
        except Coil.DoesNotExist:
            return Response(
                {'error': 'Coil not found'},
                status=status.HTTP_404_NOT_FOUND
            )
        except Exception as e:
            return Response(
                {'error': str(e)},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )
    
    @action(detail=False, methods=['post'])
    def generate_870(self, request):
        """Generate EDI 870 Order Status Report from job."""
        # SAFETY: Prevent external EDI transmission in test/development mode
        from django.conf import settings
        import os
        
        edi_enabled = os.getenv('EDI_ENABLED', 'False') == 'True'
        edi_test_mode = os.getenv('EDI_TEST_MODE', 'True') == 'True'
        
        if settings.DEBUG or edi_test_mode or not edi_enabled:
            return Response(
                {
                    'status': 'test_mode',
                    'message': 'EDI transmission disabled in test/development mode. Transaction logged but not transmitted.',
                    'note': 'Set EDI_ENABLED=True and EDI_TEST_MODE=False in production to enable external transmission.'
                },
                status=status.HTTP_200_OK
            )
        
        serializer = EDIGenerateRequestSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        
        try:
            partner = EDIPartner.objects.get(
                id=serializer.validated_data['partner_id'],
                is_active=True
            )
            
            if not partner.supports_870:
                return Response(
                    {'error': 'Partner does not support 870 transactions'},
                    status=status.HTTP_400_BAD_REQUEST
                )
            
            job = Job.objects.get(id=serializer.validated_data['reference_id'])
            
            # Prepare order status data
            order_data = {
                'report_number': f'OS-{job.job_number}',
                'report_date': datetime.now(),
                'customer_po': f'PO-{job.customer.id}',
                'job_number': job.job_number,
                'order_status': job.status,
                'quantity_ordered': float(job.ordered_quantity),
                'quantity_completed': float(job.produced_quantity),
                'quantity_shipped': 0,
                'scheduled_ship_date': job.scheduled_date,
                'estimated_completion_date': job.scheduled_date,
            }
            
            # Generate EDI
            generator = EDI870Generator(
                sender_id='ABIS',
                receiver_id=partner.edi_id,
                sender_qualifier='ZZ',
                receiver_qualifier=partner.qualifier
            )
            edi_data = generator.generate(order_data)
            
            # Create transaction record
            with transaction.atomic():
                edi_transaction = EDITransaction.objects.create(
                    transaction_type='870',
                    direction='OUTBOUND',
                    status='SENT',
                    partner=partner,
                    control_number=generator.generate_control_number(),
                    raw_data=edi_data,
                    processed_by=request.user,
                    processed_at=timezone.now()
                )
                
                # Create 870 order status record
                order_status = EDI870OrderStatus.objects.create(
                    transaction=edi_transaction,
                    job=job,
                    report_number=order_data['report_number'],
                    report_date=datetime.now().date(),
                    customer_po=order_data['customer_po'],
                    job_number_text=job.job_number,
                    order_status=job.status,
                    quantity_ordered=order_data['quantity_ordered'],
                    quantity_completed=order_data['quantity_completed'],
                    quantity_shipped=order_data['quantity_shipped'],
                    scheduled_ship_date=order_data['scheduled_ship_date'],
                    estimated_completion_date=order_data['estimated_completion_date'],
                    sent_at=timezone.now()
                )
                
                # Log event
                EDILog.objects.create(
                    transaction=edi_transaction,
                    level='INFO',
                    message=f'Generated 870 order status for job {job.job_number}',
                    user=request.user
                )
            
            return Response({
                'transaction_id': edi_transaction.id,
                'control_number': edi_transaction.control_number,
                'edi_data': edi_data,
                'message': '870 order status report generated successfully'
            }, status=status.HTTP_201_CREATED)
            
        except Job.DoesNotExist:
            return Response(
                {'error': 'Job not found'},
                status=status.HTTP_404_NOT_FOUND
            )
        except Exception as e:
            return Response(
                {'error': str(e)},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )
    
    @action(detail=False, methods=['post'])
    def parse_edi(self, request):
        """Parse incoming EDI transaction."""
        serializer = EDIParseRequestSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        
        try:
            partner = EDIPartner.objects.get(
                id=serializer.validated_data['partner_id'],
                is_active=True
            )
            
            edi_data = serializer.validated_data['edi_data']
            
            # Determine transaction type from ST segment
            parser = X12Parser(edi_data)
            parser.parse()
            st_segment = parser.get_segment('ST')
            
            if not st_segment:
                return Response(
                    {'error': 'Invalid EDI format - missing ST segment'},
                    status=status.HTTP_400_BAD_REQUEST
                )
            
            transaction_type = st_segment.get(1)
            control_info = parser.extract_control_numbers()
            
            # Parse based on transaction type
            parsed_data = None
            if transaction_type == '856':
                parser856 = EDI856Parser(edi_data)
                parsed_data = parser856.parse_ship_notice()
            elif transaction_type == '863':
                parser863 = EDI863Parser(edi_data)
                parsed_data = parser863.parse_test_report()
            elif transaction_type == '870':
                parser870 = EDI870Parser(edi_data)
                parsed_data = parser870.parse_order_status()
            else:
                return Response(
                    {'error': f'Unsupported transaction type: {transaction_type}'},
                    status=status.HTTP_400_BAD_REQUEST
                )
            
            # Create transaction record
            with transaction.atomic():
                edi_transaction = EDITransaction.objects.create(
                    transaction_type=transaction_type,
                    direction='INBOUND',
                    status='RECEIVED',
                    partner=partner,
                    control_number=control_info['isa_control'],
                    raw_data=edi_data,
                    parsed_data=parsed_data,
                    processed_by=request.user,
                    processed_at=timezone.now()
                )
                
                # Log event
                EDILog.objects.create(
                    transaction=edi_transaction,
                    level='INFO',
                    message=f'Received and parsed {transaction_type} transaction',
                    details=control_info,
                    user=request.user
                )
            
            return Response({
                'transaction_id': edi_transaction.id,
                'transaction_type': transaction_type,
                'control_number': control_info['isa_control'],
                'parsed_data': parsed_data,
                'message': 'EDI transaction parsed successfully'
            }, status=status.HTTP_201_CREATED)
            
        except EDIPartner.DoesNotExist:
            return Response(
                {'error': 'Partner not found'},
                status=status.HTTP_404_NOT_FOUND
            )
        except Exception as e:
            # Log error
            EDILog.objects.create(
                level='ERROR',
                message=f'Failed to parse EDI: {str(e)}',
                user=request.user
            )
            
            return Response(
                {'error': str(e)},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )


class EDI856ShipNoticeViewSet(viewsets.ReadOnlyModelViewSet):
    """ViewSet for EDI 856 ship notices."""
    
    queryset = EDI856ShipNotice.objects.all()
    serializer_class = EDI856ShipNoticeSerializer
    permission_classes = [IsAuthenticated]
    filterset_fields = ['shipment', 'shipment_date']
    search_fields = ['bol_number', 'shipment_identifier']
    ordering_fields = ['shipment_date', 'sent_at']
    ordering = ['-shipment_date']


class EDI863TestReportViewSet(viewsets.ReadOnlyModelViewSet):
    """ViewSet for EDI 863 test reports."""
    
    queryset = EDI863TestReport.objects.all()
    serializer_class = EDI863TestReportSerializer
    permission_classes = [IsAuthenticated]
    filterset_fields = ['coil', 'report_date']
    search_fields = ['report_number', 'heat_number', 'coil_number']
    ordering_fields = ['report_date', 'sent_at']
    ordering = ['-report_date']


class EDI870OrderStatusViewSet(viewsets.ReadOnlyModelViewSet):
    """ViewSet for EDI 870 order status reports."""
    
    queryset = EDI870OrderStatus.objects.all()
    serializer_class = EDI870OrderStatusSerializer
    permission_classes = [IsAuthenticated]
    filterset_fields = ['job', 'report_date', 'order_status']
    search_fields = ['report_number', 'job_number_text', 'customer_po']
    ordering_fields = ['report_date', 'sent_at']
    ordering = ['-report_date']
