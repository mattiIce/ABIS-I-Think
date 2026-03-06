# CLAUDE.md

## Project Overview

ABIS Modern is a manufacturing ERP system for aluminum coil processing, modernized from a legacy PowerBuilder application. It manages the full lifecycle: raw material receipt, coil inventory, production job scheduling, quality control, shipping/BOL generation, EDI (ASC X12) B2B communication, and notifications.

## Tech Stack

- **Backend**: Django 5.1 + Django REST Framework, PostgreSQL 16 (SQLite in dev), Celery 5.4 + Redis 7
- **Frontend**: React 18.3 + TypeScript 5.7, Vite 6, TailwindCSS 3.4, Zustand 5, TanStack React Query 5.6
- **Infrastructure**: Docker Compose (PostgreSQL, Redis, Nginx, Gunicorn, Celery worker + beat)
- **Auth**: JWT via `djangorestframework-simplejwt`, object-level permissions via `django-guardian`
- **Reports**: ReportLab, WeasyPrint (PDF), python-barcode, qrcode
- **EDI**: Custom X12 parsers/generators for 856, 863, 870 transactions

## Project Structure

```
abis_modern/              # Django project config
  settings.py             # Main settings (SQLite in DEBUG, PostgreSQL in prod)
  urls.py                 # Root URL config — all API routes mounted under /api/
  celery.py               # Celery app config
  wsgi.py                 # WSGI entry point

abis_frontend/            # React/TypeScript SPA
  src/
    api/                  # Axios API functions (analytics.ts, notifications.ts)
    components/           # Reusable UI (Layout.tsx — sidebar nav + routing shell)
    lib/                  # api.ts — Axios instance with JWT interceptor + token refresh
    pages/                # Page components (see Frontend Pages below)
    stores/               # authStore.ts — Zustand auth state persisted to localStorage
    types/                # index.ts — all TypeScript interfaces
    App.tsx               # React Router routes + PrivateRoute guard
    main.tsx              # Entry point: React Query provider, BrowserRouter, Toast
    index.css             # Tailwind directives + custom .card/.btn/.input/.label classes
  vite.config.ts          # Dev server port 3000, proxy /api → localhost:8000
  tailwind.config.js      # Custom primary color scale (sky blue)
  tsconfig.json           # Strict mode, path alias @/* → ./src/*
  .prettierrc             # No semicolons, single quotes, tabWidth 2, printWidth 100

core/                     # Shared models + analytics
  models.py               # TimeStampedModel, SystemLog, SystemOption, Line, Shift, Alloy, Temper
  analytics.py            # ProductionAnalytics, QualityAnalytics, InventoryAnalytics, CustomerAnalytics
  analytics_views.py      # Dashboard API views for analytics
  views.py                # CRUD ViewSets for core models
  serializers.py          # ModelSerializers for core models
  urls.py                 # Router + analytics endpoints

inventory/                # Coil tracking and finished goods
  models.py               # Coil, CoilHistory, Skid, ScrapSkid
  views.py                # CoilViewSet, SkidViewSet, ScrapSkidViewSet
  serializers.py          # CoilSerializer, CoilDetailSerializer (with history), SkidSerializer, ScrapSkidSerializer
  urls.py

production/               # Job management and production tracking
  models.py               # Job, JobCoil, DailyProduction, Downtime
  views.py                # JobViewSet, JobCoilViewSet, DailyProductionViewSet, DowntimeViewSet
  serializers.py          # JobSerializer, JobDetailSerializer (with job_coils), DailyProductionSerializer, DowntimeSerializer
  urls.py

shipping/                 # Shipments and BOL
  models.py               # Shipment, EDITransaction (shipping-specific)
  views.py                # ShipmentViewSet, EDITransactionViewSet (shipping)
  serializers.py          # ShipmentSerializer, ShipmentDetailSerializer (with skids), EDITransactionSerializer
  urls.py

customers/                # Customer and carrier management
  models.py               # Customer, CustomerContact, Carrier
  views.py                # CustomerViewSet, CustomerContactViewSet, CarrierViewSet
  serializers.py          # CustomerSerializer, CustomerDetailSerializer (with contacts), CarrierSerializer
  urls.py

notifications/            # Notification system
  models.py               # NotificationTemplate, Notification, UserNotificationPreference
  services.py             # NotificationService — create, send, bulk send, event-specific helpers
  signals.py              # Django signals: post_save on Job, Shipment, Coil → auto-notify
  views.py                # NotificationViewSet, NotificationTemplateViewSet, UserNotificationPreferenceViewSet
  urls.py

edi/                      # EDI X12 processing
  models.py               # EDIPartner, EDITransaction, EDI856ShipNotice, EDI856Item, EDI863TestReport, EDI870OrderStatus, EDILog
  views.py                # EDIPartnerViewSet, EDITransactionViewSet (generate_856/863/870, parse_edi), read-only ViewSets for 856/863/870
  parsers.py              # EDI856Parser, EDI863Parser, EDI870Parser, X12Parser
  generators.py           # EDI856Generator, EDI863Generator, EDI870Generator
  serializers.py
  urls.py

reports/                  # Document generation
  views.py                # generate_coil_certificate, generate_coil_label, generate_skid_label, generate_bol, generate_packing_list, generate_barcode, generate_qr_code, generate_batch_labels
  generators/             # CertificateGenerator, LabelGenerator, ShipmentDocumentGenerator, BarcodeGenerator
  urls.py

quality/                  # Stub app (future: QA testing, inspections)
maintenance/              # Stub app (future: equipment maintenance tracking)
```

## Common Commands

### Backend

```bash
pip install -r requirements.txt          # Install Python dependencies
python manage.py migrate                 # Run database migrations
python manage.py runserver               # Start dev server (port 8000)
pytest                                   # Run tests (pytest + pytest-django)
python manage.py createsuperuser         # Create admin user
python manage.py collectstatic --noinput # Collect static files
python manage.py loaddata <fixture>      # Load fixture data
```

### Frontend

```bash
cd abis_frontend
npm install                              # Install Node dependencies
npm run dev                              # Start Vite dev server (port 3000)
npm run build                            # TypeScript check + Vite production build
npm run lint                             # ESLint (ts/tsx, max-warnings 0)
npm run format                           # Prettier (src/**/*.{ts,tsx,css})
```

### Docker

```bash
docker compose up -d                     # Start all services (db, redis, web, celery, celery-beat, nginx)
docker compose down                      # Stop all services
```

## Environment Variables

Key variables (see `.env.example` for full list):

| Variable | Default | Description |
|----------|---------|-------------|
| `DEBUG` | `True` | Django debug mode |
| `USE_SQLITE` | `True` | Use SQLite instead of PostgreSQL in debug |
| `SECRET_KEY` | insecure default | Django secret key |
| `DB_NAME/USER/PASSWORD/HOST/PORT` | abis_db/abis_user/.../localhost/5432 | PostgreSQL connection |
| `REDIS_URL` | `redis://localhost:6379/0` | Celery broker and result backend |
| `EDI_ENABLED` | `False` | Enable EDI transmission (safety flag) |
| `EDI_TEST_MODE` | `True` | EDI test mode — logs but doesn't transmit |
| `TIME_ZONE` | `America/New_York` | Server timezone |
| `VITE_API_URL` | `http://localhost:8000/api` | Frontend API base URL |

## Database Schema

### core app

**TimeStampedModel** (abstract base):
- `created_at` DateTimeField (auto_now_add)
- `updated_at` DateTimeField (auto_now)
- `created_by` FK → User (SET_NULL, nullable)
- `updated_by` FK → User (SET_NULL, nullable)

**SystemLog** (db_table: `system_log`, extends TimeStampedModel):
- `user` FK → User, `action` CharField(100), `table_name` CharField(100), `record_id` CharField(100), `description` TextField, `ip_address` GenericIPAddressField
- Ordering: `-created_at`

**SystemOption** (db_table: `system_options`):
- `key` CharField(100, unique), `value` TextField, `description` TextField, `category` CharField(50, default='general')

**Line** (db_table: `lines`, PK: `line_id`):
- `line_number` CharField(10, unique), `description` CharField(200), `is_active` BooleanField, `capacity` DecimalField (lbs/hr)
- Production lines: 24", 36", 60", 75", 84", 108", 110"

**Shift** (db_table: `shifts`, PK: `shift_id`):
- `shift_number` CharField(1, choices: 1/2/3), `start_time` TimeField, `end_time` TimeField, `description` CharField(100)

**Alloy** (db_table: `alloys`, PK: `alloy_id`):
- `alloy_code` CharField(20, unique), `description` CharField(200), `density` DecimalField (lbs/in³)

**Temper** (db_table: `tempers`, PK: `temper_id`):
- `temper_code` CharField(20, unique), `description` CharField(200)

### inventory app

**Coil** (db_table: `coils`, PK: `coil_id`, extends TimeStampedModel):
- Identification: `original_coil_number`, `abc_coil_number` (unique), `supplier_coil_number`
- Ownership: `customer` FK → Customer (PROTECT), `supplier` FK → Customer (PROTECT, nullable)
- Material specs: `alloy` FK → Alloy (PROTECT), `temper` FK → Temper (PROTECT), `gauge` Decimal (inches), `width` Decimal (inches)
- Weights: `gross_weight`, `tare_weight`, `net_weight` (all DecimalField in lbs)
- Dimensions: `outside_diameter`, `inside_diameter` (nullable)
- Receiving: `received_date` DateField, `receiving_number`, `mill_certificate`, `heat_treatment`, `lot_number`
- Status: choices = RECEIVED | AVAILABLE | IN_PROCESS | PROCESSED | ON_HOLD | REJECTED | SHIPPED
- Quality: `qa_approved` bool, `qa_hold` bool, `qa_notes` text
- EDI: `has_863_report` bool, `edi_sent_date` datetime
- `location` CharField, `notes` TextField
- Indexes: (customer, status), (received_date), (abc_coil_number)
- Auto-calculates `net_weight = gross_weight - tare_weight` on save

**CoilHistory** (db_table: `coil_history`, PK: `history_id`, extends TimeStampedModel):
- `coil` FK → Coil (CASCADE), `action` CharField(100), `old_status`, `new_status`, `description` TextField, `location`

**Skid** (db_table: `skids`, PK: `skid_id`, extends TimeStampedModel):
- `skid_number` (unique), `package_number`, `customer` FK → Customer
- Weights: `gross_weight`, `tare_weight`, `net_weight`, `piece_count` int
- Dimensions: `length`, `width`, `height`
- Status: IN_PROGRESS | COMPLETE | QC_HOLD | AVAILABLE | ASSIGNED | SHIPPED
- QA: `qa_approved`, `qa_inspector`, `qa_date`
- `shipment` FK → Shipment (SET_NULL, nullable), `production_date`, `completion_date`

**ScrapSkid** (db_table: `scrap_skids`, PK: `scrap_skid_id`, extends TimeStampedModel):
- `scrap_skid_number` (unique), `scrap_type` (EDGE_TRIM | SKELETON | REJECTS | PROCESS_SCRAP | OTHER)
- `customer` FK → Customer, weights, status, `shipment` FK → Shipment (nullable)

### production app

**Job** (db_table: `jobs`, PK: `job_id`, extends TimeStampedModel):
- `job_number` (unique), `customer` FK → Customer, `part_number`, `part_description`
- Order: `customer_po`, `order_line`
- Production: `line` FK → Line, `shift` FK → Shift (nullable)
- Quantities: `ordered_quantity`, `produced_quantity`, `scrap_quantity`
- Targets: `target_gauge`, `target_width`, `target_length`
- Scheduling: `scheduled_start/end`, `actual_start/end` (all DateTimeField, nullable)
- Status: SCHEDULED | IN_PROGRESS | COMPLETED | ON_HOLD | CANCELLED
- `priority` int (lower = higher priority, default 100)
- Ordering: priority, -created_at
- Indexes: (customer, status), (line, status), (scheduled_start)

**JobCoil** (db_table: `job_coils`, PK: `job_coil_id`, extends TimeStampedModel):
- `job` FK → Job (CASCADE), `coil` FK → Coil (PROTECT)
- `sequence` int, `quantity_used` Decimal, `is_active` bool
- Unique together: (job, coil)

**DailyProduction** (db_table: `daily_production`, PK: `daily_prod_id`, extends TimeStampedModel):
- `production_date` DateField, `line` FK → Line, `shift` FK → Shift
- Metrics: `total_pieces`, `total_weight`, `scrap_weight`
- Time: `scheduled_runtime` (hours), `actual_runtime`, `downtime`
- `efficiency_percent` Decimal
- Unique together: (production_date, line, shift)

**Downtime** (db_table: `downtime`, PK: `downtime_id`, extends TimeStampedModel):
- `line` FK → Line, `job` FK → Job (nullable)
- `start_time` DateTimeField, `end_time` (nullable), `duration_minutes` int (auto-calculated on save)
- `category`: MECHANICAL | ELECTRICAL | TOOLING | MATERIAL | QUALITY | CHANGEOVER | OTHER
- `cause` CharField(200), `description` TextField, `corrective_action` TextField

### customers app

**Customer** (db_table: `customers`, PK: `customer_id`, extends TimeStampedModel):
- `customer_code` (unique), `company_name`, `parent` FK → self (SET_NULL, nullable)
- Address: `address_line1/2`, `city`, `state`, `zip_code`, `country` (default USA)
- Contact: `phone`, `fax`, `email`
- Business: `duns_number`, `tax_id`
- EDI config: `requires_edi`, `edi_qualifier`, `edi_identifier`, `requires_856_asn`, `requires_863_report`, `requires_870_order`
- Certification: `requires_cert_label`, `requires_cash_date`
- `is_active` bool, `notes` text

**CustomerContact** (db_table: `customer_contacts`, PK: `contact_id`, extends TimeStampedModel):
- `customer` FK → Customer (CASCADE), `first_name`, `last_name`, `title`, `email`, `phone`, `mobile`
- `is_primary` bool, `receive_reports` bool

**Carrier** (db_table: `carriers`, PK: `carrier_id`, extends TimeStampedModel):
- `carrier_code` (unique), `company_name`, `scac_code` (Standard Carrier Alpha Code)
- Address: `address_line1`, `city`, `state`, `zip_code`
- `phone`, `email`, `is_active`, `notes`

### shipping app

**Shipment** (db_table: `shipments`, PK: `shipment_id`, extends TimeStampedModel):
- `bol_number` (unique), `customer` FK → Customer, `carrier` FK → Carrier
- Ship-to: `ship_to_name`, `ship_to_address1/2`, `ship_to_city/state/zip`, `ship_to_country` (default USA)
- Details: `trailer_number`, `seal_number`, `pro_number`
- Dates: `ship_date`, `delivery_date`
- Totals: `total_weight`, `total_pieces`, `total_skids`
- Status: OPEN | IN_PROGRESS | READY | SHIPPED | DELIVERED
- EDI: `edi_856_sent` bool, `edi_856_sent_date`
- Related: `skids` (from Skid.shipment), `scrap_skids` (from ScrapSkid.shipment)

**EDITransaction** (db_table: `edi_transactions`, shipping-specific):
- `transaction_type` (856 | 863 | 870), `customer` FK, `shipment` FK (nullable)
- `control_number` (unique), `file_name`, `file_path`
- Status: PENDING | SENT | ACKNOWLEDGED | ERROR
- `sent_date`, `acknowledged_date`, `error_message`, `retry_count`, `edi_content`

### edi app

**EDIPartner** (db_table: `edi_partner`):
- `company_name`, `edi_id` (unique), `qualifier` (01-DUNS | 02-SCAC | ZZ-Mutual)
- Capabilities: `supports_856`, `supports_863`, `supports_870`
- Communication: `email`, `ftp_host`, `ftp_username`, `ftp_path`
- `is_active`, timestamps

**EDITransaction** (db_table: `edi_transaction`, edi-specific):
- `transaction_type` (856 | 863 | 870), `direction` (INBOUND | OUTBOUND)
- Status: PENDING | PROCESSING | SENT | RECEIVED | ERROR | ACKNOWLEDGED
- `partner` FK → EDIPartner, `control_number` (unique)
- `raw_data` TextField (X12 format), `parsed_data` JSONField
- `error_message`, `processed_at`, `processed_by` FK → User

**EDI856ShipNotice** (db_table: `edi_856_ship_notice`):
- `transaction` OneToOne → EDITransaction, `shipment` FK → Shipment
- BSN segment: `shipment_identifier`, `shipment_date`, `shipment_time`
- TD5: `carrier_code`, `carrier_name`
- REF: `bol_number`, `pro_number`
- N1/N3/N4: `ship_from_name/address`, `ship_to_name/address`

**EDI856Item** (db_table: `edi_856_item`):
- `ship_notice` FK → EDI856ShipNotice, `sequence`, `item_number`, `item_description`
- SN1: `quantity`, `unit_of_measure` (default LB)
- PO4: `pack_count`, `weight`
- MAN: `coil_number`, `heat_number`

**EDI863TestReport** (db_table: `edi_863_test_report`):
- `transaction` OneToOne → EDITransaction, `coil` FK → Coil (nullable)
- `report_number` (unique), `report_date`, `heat_number`, `coil_number`
- Material: `product_description`, `alloy`, `temper`, `gauge`, `width`, `weight`
- `chemical_composition` JSONField, `mechanical_properties` JSONField

**EDI870OrderStatus** (db_table: `edi_870_order_status`):
- `transaction` OneToOne → EDITransaction, `job` FK → Job (nullable)
- `report_number` (unique), `report_date`, `customer_po`, `job_number_text`
- `order_status`, quantities: `quantity_ordered/completed/shipped`
- `scheduled_ship_date`, `estimated_completion_date`

**EDILog** (db_table: `edi_log`):
- `transaction` FK → EDITransaction (nullable), `level` (INFO | WARNING | ERROR)
- `message` TextField, `details` JSONField, `user` FK → User

### notifications app

**NotificationTemplate** (db_table: `notification_templates`):
- `name` (unique), `notification_type` (unique, choices below), `subject`, `body_text`, `body_html`
- `is_active` bool, timestamps
- Types: JOB_STARTED | JOB_COMPLETED | JOB_ON_HOLD | SHIPMENT_CREATED | SHIPMENT_SHIPPED | QA_FAILED | QA_PASSED | INVENTORY_LOW | INVENTORY_RECEIVED | CUSTOMER_ORDER | MAINTENANCE_DUE | DOWNTIME_ALERT

**Notification** (db_table: `notifications`):
- `user` FK → User, `notification_type`, `subject`, `message`, `html_message`
- References: `job_id`, `shipment_id`, `coil_id`, `customer_id` (all CharField, nullable)
- Status: PENDING | SENT | FAILED | READ
- `sent_at`, `read_at`, `error_message`, timestamps
- Methods: `mark_as_sent()`, `mark_as_failed(error)`, `mark_as_read()`

**UserNotificationPreference** (db_table: `user_notification_preferences`):
- `user` OneToOne → User
- Email toggles: `email_enabled` + 12 type-specific booleans
- App toggles: `app_enabled` + 12 type-specific booleans
- Digest: `daily_digest`, `weekly_digest`
- Methods: `should_send_email(type)`, `should_send_app_notification(type)`

## API Reference

### Authentication
- `POST /api/auth/token/` — Obtain JWT token pair (username, password → access, refresh)
- `POST /api/auth/token/refresh/` — Refresh access token
- `GET /api/auth/user/` — Current user info (id, username, email, first_name, last_name)

### Core (`/api/core/`)
- `system-logs/` — ReadOnlyModelViewSet. Filter: user, action, table_name. Search: action, description
- `system-options/` — ModelViewSet. Filter: category. Search: key, description
- `lines/` — ModelViewSet. Filter: is_active. Search: line_number, description
- `shifts/` — ModelViewSet
- `alloys/` — ModelViewSet. Search: alloy_code, description
- `tempers/` — ModelViewSet. Search: temper_code, description

### Analytics (`/api/core/analytics/`)
- `GET production/?days=30` — trends, by_line, efficiency, downtime
- `GET quality/?days=30` — trends, defect_distribution, metrics, by_inspector
- `GET inventory/?days=90` — levels, turnover, value, aging
- `GET customer/?days=90&limit=10` — top_customers, order_trends, shipment_analysis, distribution
- `GET overview/` — combined key metrics from all areas

### Inventory (`/api/inventory/`)
- `coils/` — ModelViewSet. Filter: status, customer, alloy, temper, qa_approved, qa_hold. Search: abc_coil_number, original_coil_number, supplier_coil_number
  - `GET coils/{id}/history/` — Coil movement history
  - `GET coils/statistics/` — Aggregate stats (total_count, total_weight, available_count, in_process_count)
  - `POST coils/{id}/approve_qa/` — Approve coil QA
  - Detail view uses `CoilDetailSerializer` (includes nested history)
  - Create/update auto-creates `CoilHistory` entries
- `skids/` — ModelViewSet. Filter: status, customer, qa_approved, shipment. Search: skid_number, package_number
  - `GET skids/available/` — QA-approved skids not assigned to shipment
  - `GET skids/statistics/` — Aggregate stats
- `scrap-skids/` — ModelViewSet. Filter: status, customer, scrap_type, shipment. Search: scrap_skid_number
  - `GET scrap-skids/by_type/` — Scrap summary grouped by type

### Production (`/api/production/`)
- `jobs/` — ModelViewSet. Filter: status, customer, line, shift. Search: job_number, part_number, customer_po
  - `POST jobs/{id}/start/` — Set status=IN_PROGRESS, record actual_start
  - `POST jobs/{id}/complete/` — Set status=COMPLETED, record actual_end
  - `GET jobs/{id}/coils/` — Active coils assigned to job
  - `GET jobs/active/` — Jobs with status=IN_PROGRESS
  - `GET jobs/scheduled/` — Jobs scheduled for today
  - Detail view uses `JobDetailSerializer` (includes nested job_coils)
- `job-coils/` — ModelViewSet. Filter: job, coil, is_active
- `daily-production/` — ModelViewSet. Filter: production_date, line, shift
  - `GET daily-production/summary/?start_date=&end_date=` — Aggregate production stats
  - `GET daily-production/by_line/` — Production grouped by line
- `downtime/` — ModelViewSet. Filter: line, job, category. Search: cause, description
  - `GET downtime/by_category/` — Downtime summary grouped by category
  - `GET downtime/recent/` — Last 7 days of downtime

### Shipping (`/api/shipping/`)
- `shipments/` — ModelViewSet. Filter: status, customer, carrier, ship_date. Search: bol_number, trailer_number, pro_number
  - `POST shipments/{id}/ship/` — Mark as SHIPPED + update all skid statuses
  - `POST shipments/{id}/add_skid/` — Assign skid to shipment (body: {skid_id})
  - `POST shipments/{id}/send_edi/` — Create EDI 856 ASN transaction
  - `GET shipments/open/` — Shipments with status=OPEN
  - `GET shipments/statistics/` — Aggregate stats
  - Detail view uses `ShipmentDetailSerializer` (includes nested skids + scrap_skids)
- `edi-transactions/` (shipping) — ModelViewSet. Filter: transaction_type, customer, status, shipment
  - `GET edi-transactions/pending/` — Pending transactions
  - `GET edi-transactions/errors/` — Failed transactions
  - `POST edi-transactions/{id}/retry/` — Reset status to PENDING, increment retry_count

### Customers (`/api/customers/`)
- `customers/` — ModelViewSet. Filter: is_active, requires_edi, state, parent. Search: customer_code, company_name, city
  - `GET customers/{id}/contacts/` — Customer's contacts
  - `GET customers/{id}/shipments/` — Recent shipments (last 10)
  - Detail view uses `CustomerDetailSerializer` (includes nested contacts)
- `contacts/` — ModelViewSet. Filter: customer, is_primary, receive_reports. Search: first_name, last_name, email
- `carriers/` — ModelViewSet. Filter: is_active. Search: carrier_code, company_name, scac_code

### EDI (`/api/edi/`)
- `partners/` — ModelViewSet. Filter: is_active, supports_856/863/870. Search: company_name, edi_id
- `transactions/` — ModelViewSet. Filter: transaction_type, direction, status, partner
  - `POST transactions/generate_856/` — Generate 856 Ship Notice (body: {partner_id, reference_id})
  - `POST transactions/generate_863/` — Generate 863 Test Report (body: {partner_id, reference_id})
  - `POST transactions/generate_870/` — Generate 870 Order Status (body: {partner_id, reference_id})
  - `POST transactions/parse_edi/` — Parse incoming EDI data (body: {partner_id, edi_data})
  - **Safety**: All generate endpoints return test_mode response when `DEBUG=True`, `EDI_TEST_MODE=True`, or `EDI_ENABLED=False`
- `856-ship-notices/` — ReadOnlyModelViewSet
- `863-test-reports/` — ReadOnlyModelViewSet
- `870-order-status/` — ReadOnlyModelViewSet

### Notifications (`/api/notifications/`)
- `notifications/` — ModelViewSet (scoped to current user). Filter via query params: status, type, days
  - `POST notifications/{id}/mark_read/` — Mark single notification as read
  - `POST notifications/mark_all_read/` — Mark all as read
  - `GET notifications/unread_count/` — Unread count
  - `GET notifications/summary/` — Stats: total, unread, recent, by_type
- `templates/` — ModelViewSet (admin only). Filter: is_active
- `preferences/` — ModelViewSet (scoped to current user)
  - `GET preferences/my_preferences/` — Get or create preferences
  - `POST/PUT/PATCH preferences/update_preferences/` — Update preferences
- `POST test/` — Send test notification (admin only, body: {notification_type})

### Reports (`/api/reports/`)
- `GET certificate/coil/<coil_id>/` — Mill Test Certificate PDF
- `GET label/coil/<coil_id>/` — Coil label PDF
- `GET label/skid/<skid_id>/` — Skid label PDF
- `POST label/batch/` — Batch labels PDF (body: {item_ids, label_type: 'coil'|'skid'})
- `GET bol/<bol_id>/` — Bill of Lading PDF
- `GET packing-list/<shipment_id>/` — Packing List PDF
- `GET barcode/?code=&type=code128` — Barcode PNG
- `GET qrcode/?data=&size=200` — QR code PNG

### Utility Endpoints
- `GET /api/health/` — Health check (no auth required)
- `GET /` — API root with endpoint directory
- `GET /api/schema/` — OpenAPI schema
- `GET /api/docs/` — Swagger UI

## Django Signals (Auto-notifications)

Defined in `notifications/signals.py`:
- **Job created** (status=SCHEDULED) → `JOB_STARTED` notification
- **Job completed** → `JOB_COMPLETED` notification
- **Job on hold** → `JOB_ON_HOLD` notification
- **Shipment created** → `SHIPMENT_CREATED` notification
- **Shipment shipped** → `SHIPMENT_SHIPPED` notification
- **Coil created** → `INVENTORY_RECEIVED` notification

Notifications are sent to users in relevant groups (Production, Managers, CustomerService, Shipping, Quality, Inventory).

## Frontend Pages & Routes

| Route | Component | Description |
|-------|-----------|-------------|
| `/login` | Login | JWT authentication form |
| `/` | Dashboard | Stats cards (coils, QA pending, active jobs, open shipments) + recent activity |
| `/inventory/coils` | CoilList | Paginated table with search + status filter |
| `/inventory/coils/:id` | CoilDetail | Full coil info, history timeline, QA actions |
| `/inventory/skids` | SkidList | Paginated skid table with label download |
| `/production/jobs` | JobList | Paginated table with start/complete actions |
| `/production/jobs/:id` | JobDetail | Job info, assigned coils, progress tracking |
| `/shipping/shipments` | ShipmentList | Paginated table with BOL/packing list PDF downloads |
| `/customers` | CustomerList | Card grid layout with search + active filter |
| `/reports` | Reports | MTC certificates, labels, shipping docs, barcode/QR generation |
| `/analytics/production` | ProductionAnalytics | Line/bar/pie charts: trends, by line, downtime (Recharts) |
| `/analytics/quality` | QualityAnalytics | QA trends, defect distribution, by inspector |
| `/analytics/inventory` | InventoryAnalytics | By alloy, age distribution, weight distribution |
| `/analytics/customer` | CustomerAnalytics | Top customers, geographic distribution, order trends |
| `/notifications` | NotificationsList | Summary cards, filters, mark as read |
| `/notifications/preferences` | NotificationPreferences | Email/app toggle matrix, digest settings |

## Frontend Architecture

### API Layer (`src/lib/api.ts`)
- Axios instance with `baseURL = VITE_API_URL || http://localhost:8000/api`
- Request interceptor: injects `Authorization: Bearer <token>` from localStorage
- Response interceptor: on 401, attempts token refresh via `/auth/token/refresh/`, retries original request; on refresh failure, redirects to `/login`

### State Management
- **Auth**: Zustand store (`authStore.ts`) persisted to localStorage under key `auth-storage`. Stores user, accessToken, refreshToken, isAuthenticated.
- **Server state**: TanStack React Query with 5-minute staleTime, no refetch on window focus
- **UI state**: Local `useState` for filters, pagination, modals

### Routing
- `PrivateRoute` component checks `isAuthenticated` from authStore; redirects to `/login` if false
- Layout component provides collapsible sidebar navigation with icon-based menu groups

## Code Conventions

### Backend
- All transactional models extend `TimeStampedModel` (auto audit fields: created_at/by, updated_at/by)
- All models use explicit `db_table` names and custom AutoField primary keys (e.g., `coil_id`, `job_id`)
- ViewSets use `select_related`/`prefetch_related` for query optimization
- List vs detail serializers: `get_serializer_class()` returns nested serializer for `retrieve` action
- Serializers expose computed/display fields (e.g., `customer_name`, `category_display`) as read-only
- All serializers use `fields = '__all__'` with explicit `read_only_fields`
- `on_delete=PROTECT` for business-critical FKs (customer, alloy, temper, line); `CASCADE` for owned relations; `SET_NULL` for optional references
- REST API uses `PageNumberPagination` with page size 50
- Filter backends: `DjangoFilterBackend`, `SearchFilter`, `OrderingFilter`

### Frontend
- TypeScript strict mode with `noUnusedLocals`, `noUnusedParameters`
- Prettier: no semicolons, single quotes, 2-space indent, 100 char width, trailing comma es5, no parens on single arrow params
- TailwindCSS utility classes + `clsx`/`tailwind-merge` for conditional classes
- Custom CSS component classes: `.card`, `.btn`, `.btn-primary/secondary/danger`, `.input`, `.label` (defined in `index.css`)
- Primary color scale: sky blue (#0284c7 at 600)
- Data fetching pattern: React Query hooks with array keys like `['coils', page, search, statusFilter]`
- API functions return `response.data` (unwrapped Axios response)
- Icons: Lucide React
- Charts: Recharts (Line, Bar, Pie)
- Toasts: react-hot-toast (top-right position)
- Date formatting: date-fns

## Key Safety Features

- EDI transmission disabled by default (triple check: `DEBUG`, `EDI_TEST_MODE`, `EDI_ENABLED`)
- Email uses console backend in development
- `on_delete=PROTECT` prevents accidental deletion of referenced records
- JWT auth on all API endpoints except health check
- CSRF protection with trusted origins for Codespaces
- Production mode enables: SSL redirect, HSTS, secure cookies, XSS filter, content type nosniff
