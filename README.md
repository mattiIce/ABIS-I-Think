# ABIS Modern - Aluminum Business Information System

## Overview

This is a modern conversion of the legacy PowerBuilder ABIS system to Python/Django. ABIS is a comprehensive manufacturing ERP system for aluminum coil processing, featuring:

- **Inventory Management**: Track aluminum coils, finished skids, and scrap
- **Production Scheduling**: Job management, line scheduling, and shift tracking
- **Shipping & Logistics**: BOL generation, carrier management, shipment tracking
- **Quality Control**: QA workflows, testing, and compliance
- **EDI Integration**: ASN (856), Test Results (863), Order Status (870)
- **Reporting**: Production reports, inventory summaries, quality metrics
- **Maintenance**: Equipment tracking and preventive maintenance

## Technology Stack

- **Backend**: Python 3.11+ with Django 5.0
- **API**: Django REST Framework with JWT authentication
- **Database**: PostgreSQL 14+
- **Task Queue**: Celery with Redis
- **Documentation**: OpenAPI/Swagger via drf-spectacular
- **Reports**: ReportLab, WeasyPrint for PDFs
- **EDI**: pyx12 for X12 transaction processing

## Project Structure

```
abis_modern/
├── abis_modern/          # Project configuration
│   ├── settings.py       # Django settings
│   ├── urls.py          # URL routing
│   ├── celery.py        # Celery configuration
│   └── wsgi.py          # WSGI application
├── core/                # Core shared models
│   ├── models.py        # Base models, Lines, Shifts, Alloys
│   └── admin.py
├── customers/           # Customer management
│   ├── models.py        # Customer, Contact, Carrier models
│   └── admin.py
├── inventory/           # Inventory tracking
│   ├── models.py        # Coil, Skid, ScrapSkid models
│   └── admin.py
├── production/          # Production management
│   ├── models.py        # Job, DailyProduction, Downtime
│   └── admin.py
├── shipping/            # Shipping and BOL
│   ├── models.py        # Shipment, EDITransaction models
│   └── admin.py
├── quality/             # Quality control (stub)
├── maintenance/         # Maintenance tracking (stub)
├── reports/             # Report generation (stub)
└── edi/                 # EDI processing (stub)
```

## Setup Instructions

### Prerequisites

- Python 3.11 or higher
- PostgreSQL 14 or higher
- Redis 6 or higher

### Installation

1. **Clone the repository**
   ```bash
   cd abis_modern
   ```

2. **Create virtual environment**
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Linux/Mac
   # or
   venv\Scripts\activate  # On Windows
   ```

3. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

4. **Configure environment**
   ```bash
   cp .env.example .env
   # Edit .env with your database credentials and settings
   ```

5. **Create PostgreSQL database**
   ```bash
   createdb abis_db
   createuser abis_user
   psql -c "ALTER USER abis_user WITH PASSWORD 'your_password';"
   psql -c "GRANT ALL PRIVILEGES ON DATABASE abis_db TO abis_user;"
   ```

6. **Run migrations**
   ```bash
   python manage.py makemigrations
   python manage.py migrate
   ```

7. **Create superuser**
   ```bash
   python manage.py createsuperuser
   ```

8. **Load initial data (optional)**
   ```bash
   python manage.py loaddata fixtures/initial_data.json
   ```

9. **Run development server**
   ```bash
   python manage.py runserver
   ```

10. **Access the application**
    - Admin interface: http://localhost:8000/admin/
    - API documentation: http://localhost:8000/api/docs/
    - API schema: http://localhost:8000/api/schema/

### Running Celery (for background tasks)

In separate terminals:

```bash
# Start Redis
redis-server

# Start Celery worker
celery -A abis_modern worker -l info

# Start Celery beat (scheduler)
celery -A abis_modern beat -l info
```

## API Endpoints

### Authentication
- `POST /api/auth/token/` - Obtain JWT token
- `POST /api/auth/token/refresh/` - Refresh JWT token

### Inventory
- `/api/inventory/coils/` - Coil management
- `/api/inventory/skids/` - Skid management
- `/api/inventory/scrap-skids/` - Scrap skid management

### Production
- `/api/production/jobs/` - Job management
- `/api/production/daily-production/` - Daily production tracking
- `/api/production/downtime/` - Downtime tracking

### Shipping
- `/api/shipping/shipments/` - Shipment/BOL management
- `/api/shipping/edi-transactions/` - EDI transaction tracking

### Customers
- `/api/customers/customers/` - Customer management
- `/api/customers/contacts/` - Customer contacts
- `/api/customers/carriers/` - Carrier management

## Key Features

### 1. Coil Tracking
- Receive coils with full material specifications
- Track original and ABC coil numbers
- Quality approval workflows
- Location tracking

### 2. Job Management
- Schedule jobs on production lines
- Assign coils to jobs
- Track production quantities
- Monitor job status

### 3. Production Tracking
- Daily production summaries by line and shift
- Downtime logging with categorization
- Efficiency calculations
- Real-time status updates

### 4. Shipping
- Create bills of lading
- Assign skids to shipments
- Generate packing lists
- Track shipment status

### 5. EDI Integration
- 856 ASN (Advanced Ship Notice)
- 863 Report of Test Results
- 870 Order Status Report
- Automated transaction processing

## Development

### Running Tests
```bash
python manage.py test
```

### Code Style
```bash
# Format code with black
black .

# Lint with flake8
flake8 .
```

### Create New App
```bash
python manage.py startapp app_name
```

## Deployment

### Using Docker (Recommended)

```bash
docker-compose up -d
```

### Manual Deployment

1. Set `DEBUG=False` in `.env`
2. Configure production database
3. Set up Gunicorn/uWSGI
4. Configure nginx as reverse proxy
5. Set up SSL certificates
6. Configure Celery with supervisor

## Migration from PowerBuilder

The legacy PowerBuilder system used the following libraries:
- `silverdome*.pbl` - Main application libraries
- `pfcmain.pbl`, `pfcutil.pbl` - PowerBuilder Foundation Classes
- DataWindow objects (`.srd` files) for data display

Key conversions:
- PowerBuilder Windows → Django REST API + React frontend
- DataWindows → Django ORM models + serializers
- PowerScript functions → Python service classes
- .ini files → Django settings + environment variables

## Contributing

1. Create feature branch
2. Make changes
3. Write tests
4. Submit pull request

## License

Proprietary - All rights reserved

## Support

For questions or issues, contact the development team.
