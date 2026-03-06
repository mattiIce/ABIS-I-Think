# CLAUDE.md

## Project Overview

ABIS Modern is a manufacturing ERP system for aluminum coil processing, modernized from a legacy PowerBuilder application. It manages coil inventory, production jobs, shipping/BOL, quality control, EDI (X12), and notifications.

## Tech Stack

- **Backend**: Django 5.1 + Django REST Framework, PostgreSQL (SQLite in dev), Celery + Redis
- **Frontend**: React 18 + TypeScript, Vite, TailwindCSS, Zustand, React Query
- **Infrastructure**: Docker Compose (PostgreSQL, Redis, Nginx, Gunicorn, Celery)

## Project Structure

```
abis_modern/          # Django project config (settings, urls, celery, wsgi)
abis_frontend/        # React/TypeScript SPA
  src/pages/          # Page components
  src/components/     # Reusable UI components
  src/api/            # Axios API layer
  src/stores/         # Zustand stores
  src/types/          # TypeScript type definitions
core/                 # Shared models: Line, Shift, Alloy, Temper, SystemLog
inventory/            # Coil, CoilHistory, Skid, ScrapSkid
production/           # Job, JobCoil, DailyProduction, Downtime
shipping/             # Shipment, EDITransaction
customers/            # Customer, CustomerContact, Carrier
notifications/        # NotificationTemplate, Notification, UserNotificationPreference
edi/                  # EDIPartner, EDITransaction (ASC X12)
quality/              # Stub app
maintenance/          # Stub app
reports/              # Report generation (PDF via ReportLab/WeasyPrint)
```

## Common Commands

### Backend

```bash
# Install dependencies
pip install -r requirements.txt

# Run migrations
python manage.py migrate

# Start dev server
python manage.py runserver

# Run tests
pytest

# Load sample data
python manage.py loaddata <fixture>

# Create superuser
python manage.py createsuperuser

# Collect static files
python manage.py collectstatic --noinput
```

### Frontend

```bash
cd abis_frontend

# Install dependencies
npm install

# Start dev server (port 3000)
npm run dev

# Build for production
npm run build

# Lint
npm run lint

# Format
npm run format
```

### Docker

```bash
docker compose up -d        # Start all services
docker compose down          # Stop all services
```

## Key Architecture Details

- **Settings**: `abis_modern/settings.py` — uses SQLite in DEBUG mode (`USE_SQLITE=True`), PostgreSQL otherwise
- **Auth**: JWT via `djangorestframework-simplejwt`, object-level permissions via `django-guardian`
- **API base**: `/api/` — all endpoints require authentication; docs at `/api/docs/` (Swagger/OpenAPI)
- **Frontend path aliases**: `@/*` maps to `./src/*` (configured in `tsconfig.json`)
- **Celery broker**: Redis (`redis://localhost:6379/0`)
- **Timezone**: `America/New_York`

## Django Apps & API Endpoints

| App | Endpoints |
|-----|-----------|
| core | `/api/core/` — lines, shifts, alloys, tempers |
| inventory | `/api/inventory/coils/`, `/api/inventory/skids/`, `/api/inventory/scrap-skids/` |
| production | `/api/production/jobs/`, `/api/production/daily-production/`, `/api/production/downtime/` |
| shipping | `/api/shipping/shipments/`, `/api/shipping/edi-transactions/` |
| customers | `/api/customers/customers/`, `/api/customers/contacts/`, `/api/customers/carriers/` |
| notifications | `/api/notifications/notifications/`, `/api/notifications/templates/`, `/api/notifications/preferences/` |
| edi | `/api/edi/partners/`, `/api/edi/transactions/` |
| reports | `/api/reports/` |

## Code Conventions

- All Django models inherit from `TimeStampedModel` (provides `created_at`, `updated_at`, `created_by`, `updated_by`)
- REST API uses `PageNumberPagination` with page size 50
- Frontend state management via Zustand stores; data fetching via React Query
- Frontend styling with TailwindCSS utility classes + `clsx`/`tailwind-merge`
- TypeScript strict mode enabled with `noUnusedLocals` and `noUnusedParameters`
