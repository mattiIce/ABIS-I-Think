# 🎯 Quick Start Guide - ABIS Modern

Welcome to the modernized ABIS (Aluminum Business Information System)! This guide will get you up and running in minutes.

## Prerequisites

- **Python 3.11+** (for backend)
- **Node.js 18+** (for frontend)
- **PostgreSQL 14+** (database)
- **Redis 6+** (optional, for background tasks)

Or just use **Docker** and skip manual setup!

## Option 1: Docker (Recommended) 🐳

The fastest way to get started:

```bash
# Start all services (backend, frontend, database, redis)
docker-compose up -d

# Access the application
Frontend:  http://localhost:3000
Backend:   http://localhost:8000
Admin:     http://localhost:8000/admin
API Docs:  http://localhost:8000/api/docs

# Login credentials
Username: admin
Password: admin
```

That's it! The application is running with sample data.

## Option 2: Manual Setup 🛠️

### Backend Setup (5 minutes)

```bash
# 1. Create virtual environment
python -m venv venv
source venv/bin/activate  # On Linux/Mac
# or
venv\Scripts\activate     # On Windows

# 2. Install dependencies
pip install -r requirements.txt

# 3. Configure environment
cp .env.example .env
# Edit .env with your database credentials

# 4. Set up database
createdb abis_db  # PostgreSQL
python manage.py migrate

# 5. Create admin user
python manage.py createsuperuser

# 6. Load sample data (optional)
python manage.py loaddata sample_data.json

# 7. Run development server
python manage.py runserver
```

Backend now running at http://localhost:8000

### Frontend Setup (3 minutes)

```bash
# 1. Navigate to frontend
cd abis_frontend

# 2. Install dependencies
npm install

# 3. Start development server
npm run dev
```

Frontend now running at http://localhost:3000

## What You Get 📦

### Features Available

✅ **Inventory Management**
- Track aluminum coils, skids, and scrap
- Barcode generation and scanning
- Location tracking
- Quality approval workflows

✅ **Production Management**
- Job scheduling and tracking
- Line management (24", 36", 60", 75", 84", 108", 110")
- Shift tracking
- Downtime logging
- Efficiency calculations

✅ **Shipping & Logistics**
- Bill of lading (BOL) generation
- Shipment tracking
- Carrier management
- Package numbering

✅ **Customer Management**
- Customer profiles
- Contact management
- EDI configuration
- Order tracking

✅ **Quality Assurance**
- QA workflows
- Test result tracking
- Compliance reporting

✅ **Analytics Dashboards**
- Production analytics
- Inventory trends
- Quality metrics
- Shipping performance

✅ **Email Notifications**
- Job status alerts
- Shipment updates
- QA notifications
- Inventory warnings

✅ **EDI Integration**
- 850 Purchase Orders
- 856 Advance Ship Notices
- 863 Test Results
- 870 Order Status
- 997 Acknowledgments

### Sample Data Included

- 7 Production Lines
- 3 Work Shifts
- 4 Major Customers (Ford, GM, Tesla, Alcoa)
- 4 Aluminum Coils
- 3 Production Jobs
- 9 Notification Templates

## Application Structure 📁

```
/
├── Backend (Django)
│   ├── core/              # Base models and utilities
│   ├── inventory/         # Coil/skid management
│   ├── production/        # Job tracking
│   ├── shipping/          # BOL and shipments
│   ├── customers/         # Customer data
│   ├── quality/           # QA workflows
│   ├── reports/           # Report generation
│   ├── edi/               # EDI processing
│   └── notifications/     # Email alerts
│
├── Frontend (React)
│   ├── src/pages/         # Page components
│   ├── src/components/    # Reusable components
│   └── src/api/           # API integration
│
└── Configuration
    ├── abis_modern/       # Django settings
    ├── docker-compose.yml # Container setup
    └── requirements.txt   # Python deps
```

## Common Tasks 🔧

### Start Development

```bash
# Backend
python manage.py runserver

# Frontend (separate terminal)
cd abis_frontend && npm run dev

# Background tasks (optional, separate terminal)
celery -A abis_modern worker -l info
```

### Run Tests

```bash
# Backend tests
python manage.py test

# Frontend tests
cd abis_frontend && npm test
```

### Create Database Migrations

```bash
# After modifying models
python manage.py makemigrations
python manage.py migrate
```

### Access Admin Panel

1. Go to http://localhost:8000/admin
2. Login with superuser credentials
3. Manage data directly

### View API Documentation

Go to http://localhost:8000/api/docs for interactive Swagger UI

## Troubleshooting 🔍

### Backend won't start

```bash
# Check Python version
python --version  # Should be 3.11+

# Reinstall dependencies
pip install -r requirements.txt --force-reinstall

# Check database connection
python manage.py check
```

### Frontend won't start

```bash
# Clear node modules
rm -rf node_modules package-lock.json
npm install

# Check Node version
node --version  # Should be 18+
```

### Database errors

```bash
# Reset migrations (development only!)
python manage.py migrate --fake inventory zero
python manage.py migrate inventory

# Or recreate database
dropdb abis_db && createdb abis_db
python manage.py migrate
```

## Next Steps 🚀

1. **Explore the Application**
   - Login and navigate through different sections
   - Try creating a job, coil, or shipment
   - Check out the analytics dashboards

2. **Read Documentation**
   - `GETTING_STARTED.md` - Detailed setup guide
   - `API_GUIDE.md` - API endpoint reference
   - `PROJECT_COMPLETE.md` - Complete feature list

3. **Customize**
   - Update `.env` with your settings
   - Configure email (SMTP) for notifications
   - Set up EDI connections
   - Load your actual data

4. **Deploy to Production**
   - See `docker-compose.yml` for containerized deployment
   - Configure Nginx for SSL
   - Set up automated backups
   - Configure monitoring

## Need Help? 📖

- **Documentation**: Check the `/docs` folder
- **API Docs**: http://localhost:8000/api/docs
- **Django Admin**: http://localhost:8000/admin
- **Source Code**: Well-commented and organized

## Technology Stack 💻

| Component | Technology |
|-----------|-----------|
| Backend Language | Python 3.11+ |
| Backend Framework | Django 5.0 |
| API | Django REST Framework |
| Database | PostgreSQL 14+ |
| Task Queue | Celery + Redis |
| Frontend Language | TypeScript |
| Frontend Framework | React 18 |
| Build Tool | Vite |
| Styling | TailwindCSS |
| HTTP Client | Axios |
| State Management | Zustand |

## Quick Reference ⚡

```bash
# Start everything with Docker
docker-compose up -d

# Or start manually
python manage.py runserver          # Backend
cd abis_frontend && npm run dev     # Frontend

# Access application
http://localhost:3000               # Main app
http://localhost:8000/admin         # Admin
http://localhost:8000/api/docs      # API docs

# Default login
Username: admin
Password: admin
```

---

**Ready to build!** 🎉

For more details, see:
- `README.md` - Main documentation
- `GETTING_STARTED.md` - Comprehensive setup guide
- `CLEANUP_COMPLETE.md` - Migration summary
