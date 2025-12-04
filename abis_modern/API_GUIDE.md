# ABIS Modern REST API - Quick Reference

## 🎉 Complete REST API Built!

All REST API endpoints are now implemented with full CRUD operations, filtering, searching, and custom actions.

## 🚀 Start the Server

```bash
cd /workspaces/ABIS-I-Think/abis_modern
source venv/bin/activate
python manage.py migrate
python manage.py createsuperuser
python manage.py runserver
```

Visit: **http://localhost:8000/api/docs/** for interactive API documentation

## 📡 API Endpoints

### Authentication
```bash
POST /api/auth/token/
POST /api/auth/token/refresh/
```

### Core (/api/core/)
- `GET /api/core/lines/` - Production lines
- `GET /api/core/shifts/` - Work shifts
- `GET /api/core/alloys/` - Aluminum alloys
- `GET /api/core/tempers/` - Temper designations
- `GET /api/core/system-options/` - System configuration
- `GET /api/core/system-logs/` - Activity logs (read-only)

### Customers (/api/customers/)
- `GET/POST /api/customers/customers/` - Customer CRUD
- `GET /api/customers/customers/{id}/contacts/` - Customer contacts
- `GET /api/customers/customers/{id}/shipments/` - Customer shipments
- `GET/POST /api/customers/contacts/` - Contact management
- `GET/POST /api/customers/carriers/` - Carrier management

### Inventory (/api/inventory/)
- `GET/POST /api/inventory/coils/` - Coil inventory
- `GET /api/inventory/coils/{id}/` - Coil detail with history
- `GET /api/inventory/coils/{id}/history/` - Coil audit trail
- `POST /api/inventory/coils/{id}/approve_qa/` - QA approval
- `GET /api/inventory/coils/statistics/` - Inventory stats
- `GET/POST /api/inventory/skids/` - Finished skids
- `GET /api/inventory/skids/available/` - Available for shipment
- `GET /api/inventory/skids/statistics/` - Skid stats
- `GET/POST /api/inventory/scrap-skids/` - Scrap tracking
- `GET /api/inventory/scrap-skids/by_type/` - Scrap by type

### Production (/api/production/)
- `GET/POST /api/production/jobs/` - Job management
- `GET /api/production/jobs/active/` - Currently running jobs
- `GET /api/production/jobs/scheduled/` - Today's schedule
- `POST /api/production/jobs/{id}/start/` - Start job
- `POST /api/production/jobs/{id}/complete/` - Complete job
- `GET /api/production/jobs/{id}/coils/` - Job coils
- `GET/POST /api/production/job-coils/` - Coil assignments
- `GET/POST /api/production/daily-production/` - Daily tracking
- `GET /api/production/daily-production/summary/` - Production summary
- `GET /api/production/daily-production/by_line/` - By line report
- `GET/POST /api/production/downtime/` - Downtime logs
- `GET /api/production/downtime/by_category/` - Downtime summary
- `GET /api/production/downtime/recent/` - Last 7 days

### Shipping (/api/shipping/)
- `GET/POST /api/shipping/shipments/` - BOL management
- `GET /api/shipping/shipments/open/` - Open shipments
- `POST /api/shipping/shipments/{id}/ship/` - Mark shipped
- `POST /api/shipping/shipments/{id}/add_skid/` - Add skid to BOL
- `POST /api/shipping/shipments/{id}/send_edi/` - Send EDI 856
- `GET /api/shipping/shipments/statistics/` - Shipment stats
- `GET/POST /api/shipping/edi-transactions/` - EDI tracking
- `GET /api/shipping/edi-transactions/pending/` - Pending EDI
- `GET /api/shipping/edi-transactions/errors/` - Failed EDI
- `POST /api/shipping/edi-transactions/{id}/retry/` - Retry EDI

## 🔐 Authentication Example

```bash
# Get token
curl -X POST http://localhost:8000/api/auth/token/ \
  -H "Content-Type: application/json" \
  -d '{"username": "admin", "password": "yourpassword"}'

# Response:
{
  "access": "eyJ0eXAiOiJKV1QiLCJhbGc...",
  "refresh": "eyJ0eXAiOiJKV1QiLCJhbGc..."
}

# Use token in requests
curl -X GET http://localhost:8000/api/inventory/coils/ \
  -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGc..."
```

## 📊 Example API Calls

### Create Customer
```bash
curl -X POST http://localhost:8000/api/customers/customers/ \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "customer_code": "CUST001",
    "company_name": "Example Corp",
    "address_line1": "123 Main St",
    "city": "Detroit",
    "state": "MI",
    "zip_code": "48201",
    "is_active": true
  }'
```

### Receive New Coil
```bash
curl -X POST http://localhost:8000/api/inventory/coils/ \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "original_coil_number": "SUPPLIER-12345",
    "abc_coil_number": "ABC-000001",
    "customer": 1,
    "alloy": 1,
    "temper": 1,
    "gauge": 0.040,
    "width": 48.0,
    "gross_weight": 15000.00,
    "net_weight": 14950.00,
    "received_date": "2024-01-15",
    "status": "RECEIVED"
  }'
```

### Create Production Job
```bash
curl -X POST http://localhost:8000/api/production/jobs/ \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "job_number": "JOB-2024-001",
    "customer": 1,
    "line": 1,
    "part_number": "PART-001",
    "part_description": "Aluminum Sheet",
    "ordered_quantity": 1000,
    "target_gauge": 0.040,
    "target_width": 48.0,
    "status": "SCHEDULED"
  }'
```

### Create Shipment
```bash
curl -X POST http://localhost:8000/api/shipping/shipments/ \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "bol_number": "BOL-2024-001",
    "customer": 1,
    "carrier": 1,
    "ship_to_name": "Example Corp",
    "ship_to_address1": "123 Main St",
    "ship_to_city": "Detroit",
    "ship_to_state": "MI",
    "ship_to_zip": "48201",
    "ship_date": "2024-01-15",
    "status": "OPEN"
  }'
```

## 🎯 Features Implemented

### ✅ Full CRUD Operations
- List, Create, Retrieve, Update, Delete for all models

### ✅ Filtering & Search
- Filter by status, customer, date ranges
- Full-text search on codes, names, descriptions
- Ordering by any field

### ✅ Custom Actions
- Job start/complete
- Coil QA approval
- Shipment processing
- EDI sending
- Statistical summaries

### ✅ Nested Data
- Customers with contacts
- Jobs with assigned coils
- Shipments with skids
- Coils with history

### ✅ Audit Trail
- created_by, updated_by on all models
- Coil history tracking
- System logging

## 📖 Next Steps

1. **Test the API**: Use the Swagger UI at http://localhost:8000/api/docs/
2. **Load Sample Data**: Create customers, coils, jobs via admin or API
3. **Build Frontend**: React app to consume these APIs
4. **Add Reports**: PDF generation endpoints
5. **Integration**: Scale, barcode printer, EDI automation

## 🎉 Complete!

The REST API layer is fully implemented with:
- **50+ endpoints**
- **JWT authentication**
- **Full filtering/search**
- **Custom business logic actions**
- **Audit trails**
- **Statistics and summaries**

Ready for frontend development and integration!
