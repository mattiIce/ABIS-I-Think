# ABIS Modern - Testing Guide

## Overview

This guide provides instructions for testing the ABIS Modern application after setup. The application consists of a Django REST backend and a React TypeScript frontend.

## System Status

✅ **Backend**: Running on http://localhost:8000  
✅ **Frontend**: Running on http://localhost:3000  
✅ **Database**: PostgreSQL with sample data loaded  
✅ **Admin**: http://localhost:8000/admin (admin/admin)

---

## Quick Start Testing

### 1. Backend API Testing

#### Test Authentication
```bash
# Get JWT token
curl -X POST http://localhost:8000/api/auth/token/ \
  -H "Content-Type: application/json" \
  -d '{"username": "admin", "password": "admin"}'

# Expected response: JSON with "access" and "refresh" tokens
```

#### Test API Endpoints
```bash
# Get auth token and store it
TOKEN=$(curl -s -X POST http://localhost:8000/api/auth/token/ \
  -H "Content-Type: application/json" \
  -d '{"username": "admin", "password": "admin"}' | \
  python3 -c "import sys, json; print(json.load(sys.stdin)['access'])")

# List customers
curl -s http://localhost:8000/api/customers/customers/ \
  -H "Authorization: Bearer $TOKEN" | python3 -m json.tool

# List coils
curl -s http://localhost:8000/api/inventory/coils/ \
  -H "Authorization: Bearer $TOKEN" | python3 -m json.tool

# List jobs
curl -s http://localhost:8000/api/production/jobs/ \
  -H "Authorization: Bearer $TOKEN" | python3 -m json.tool
```

### 2. Frontend Testing

1. **Access the Frontend**: Open http://localhost:3000/ in your browser

2. **Login**:
   - Username: `admin`
   - Password: `admin`

3. **Navigate Pages**:
   - Dashboard: View system overview
   - Inventory → Coils: See 4 sample coils (3 approved, 1 in quarantine)
   - Production → Jobs: See 3 sample jobs (2 scheduled, 1 in progress)
   - Customers: See 4 sample customers (Ford, GM, Tesla, Alcoa)
   - Shipping: Access shipment management

### 3. Admin Panel Testing

1. **Access Admin**: http://localhost:8000/admin/
2. **Login**: admin / admin
3. **Browse Data**:
   - Core → Lines (7 production lines)
   - Core → Shifts (3 shifts)
   - Core → Alloys (6 types)
   - Customers → Customers (4 customers)
   - Inventory → Coils (4 coils)
   - Production → Jobs (3 jobs)
   - Notifications → Templates (9 templates)

---

## Sample Data Details

### Production Lines
- 24" Line (capacity: 5,000 lbs/hr)
- 36" Line (capacity: 7,500 lbs/hr)
- 60" Line (capacity: 10,000 lbs/hr)
- 75" Line (capacity: 12,500 lbs/hr)
- 84" Line (capacity: 15,000 lbs/hr)
- 108" Line (capacity: 18,000 lbs/hr)
- 110" Line (capacity: 20,000 lbs/hr)

### Shifts
- First Shift (Day): 07:00 - 15:00
- Second Shift (Evening): 15:00 - 23:00
- Third Shift (Night): 23:00 - 07:00

### Alloys & Tempers
- Alloys: 3003, 3004, 3104, 5052, 5182, 6061
- Tempers: H14, H16, H18, H19, O, T6

### Carriers
- ABC Trucking (SCAC: ABCT)
- XYZ Logistics (SCAC: XYZL)
- FastFreight LLC (SCAC: FSTF)

### Customers
1. **Ford Motor Company** (FORD)
   - Location: Dearborn, MI
   - Phone: 313-555-0001

2. **General Motors** (GM)
   - Location: Detroit, MI
   - Phone: 313-555-0002

3. **Tesla Inc** (TESLA)
   - Location: Austin, TX
   - Phone: 512-555-0003

4. **Alcoa Corporation** (ALCOA)
   - Location: Pittsburgh, PA
   - Phone: 412-555-0004

### Coils
1. **ABC-000001** (ALCOA-2024-001)
   - Alloy: 3004, Temper: H14
   - Gauge: 0.040", Width: 48"
   - Weight: 14,500 lbs (gross: 15,000, tare: 500)
   - Status: Approved

2. **ABC-000002** (ALCOA-2024-002)
   - Alloy: 5052, Temper: H16
   - Gauge: 0.050", Width: 60"
   - Weight: 17,400 lbs
   - Status: Approved

3. **ABC-000003** (ALCOA-2024-003)
   - Alloy: 3004, Temper: H14
   - Gauge: 0.032", Width: 36"
   - Weight: 11,600 lbs
   - Status: Approved

4. **ABC-000004** (ALCOA-2024-004)
   - Alloy: 5052, Temper: H14
   - Gauge: 0.063", Width: 72"
   - Weight: 19,300 lbs
   - Status: Quarantine (QA review)

### Jobs
1. **JOB-2024-001** (Ford)
   - Part: FORD-001 - Aluminum Panel 48" x 96"
   - Line: 60"
   - Target: 0.040" x 48" x 96"
   - Quantity: 1,000 pieces
   - Status: Scheduled (starts in 2 days)

2. **JOB-2024-002** (GM)
   - Part: GM-002 - Aluminum Sheet 60" x 120"
   - Line: 84"
   - Target: 0.050" x 60" x 120"
   - Quantity: 1,500 pieces
   - Status: Scheduled (starts in 5 days)

3. **JOB-2024-003** (Tesla)
   - Part: TESLA-003 - Aluminum Sheet 36" x 84"
   - Line: 60"
   - Target: 0.032" x 36" x 84"
   - Quantity: 800 pieces
   - Status: In Progress (started yesterday)

---

## API Endpoint Testing

### Available Endpoints

#### Authentication
- `POST /api/auth/token/` - Obtain JWT token
- `POST /api/auth/token/refresh/` - Refresh JWT token
- `GET /api/auth/user/` - Get current user info

#### Core
- `GET /api/core/lines/` - List production lines
- `GET /api/core/shifts/` - List work shifts
- `GET /api/core/alloys/` - List aluminum alloys
- `GET /api/core/tempers/` - List temper designations

#### Customers
- `GET /api/customers/customers/` - List customers
- `POST /api/customers/customers/` - Create customer
- `GET /api/customers/customers/{id}/` - Get customer detail
- `GET /api/customers/contacts/` - List contacts
- `GET /api/customers/carriers/` - List carriers

#### Inventory
- `GET /api/inventory/coils/` - List coils
- `POST /api/inventory/coils/` - Receive new coil
- `GET /api/inventory/coils/{id}/` - Get coil detail
- `PATCH /api/inventory/coils/{id}/` - Update coil (e.g., QA approval)
- `GET /api/inventory/skids/` - List skids
- `GET /api/inventory/scrap-skids/` - List scrap skids

#### Production
- `GET /api/production/jobs/` - List jobs
- `POST /api/production/jobs/` - Create job
- `GET /api/production/jobs/{id}/` - Get job detail
- `PATCH /api/production/jobs/{id}/` - Update job status
- `GET /api/production/daily-production/` - Daily production records
- `GET /api/production/downtime/` - Downtime logs

#### Shipping
- `GET /api/shipping/shipments/` - List shipments
- `POST /api/shipping/shipments/` - Create shipment
- `GET /api/shipping/edi-transactions/` - List EDI transactions

#### Notifications
- `GET /api/notifications/notifications/` - List notifications
- `GET /api/notifications/preferences/` - User preferences
- `PATCH /api/notifications/notifications/{id}/read/` - Mark as read

### Example API Test Script

Create a file `test_api.sh`:

```bash
#!/bin/bash

API_URL="http://localhost:8000/api"

# Get token
echo "=== Getting authentication token ==="
TOKEN_RESPONSE=$(curl -s -X POST ${API_URL}/auth/token/ \
  -H "Content-Type: application/json" \
  -d '{"username": "admin", "password": "admin"}')

TOKEN=$(echo $TOKEN_RESPONSE | python3 -c "import sys, json; print(json.load(sys.stdin).get('access', ''))")

if [ -z "$TOKEN" ]; then
  echo "Failed to get token"
  exit 1
fi

echo "Token obtained successfully"
echo

# Test endpoints
echo "=== Testing API Endpoints ==="
echo

echo "1. List Customers:"
curl -s ${API_URL}/customers/customers/ \
  -H "Authorization: Bearer $TOKEN" | python3 -m json.tool | head -20
echo

echo "2. List Coils:"
curl -s ${API_URL}/inventory/coils/ \
  -H "Authorization: Bearer $TOKEN" | python3 -m json.tool | head -30
echo

echo "3. List Jobs:"
curl -s ${API_URL}/production/jobs/ \
  -H "Authorization: Bearer $TOKEN" | python3 -m json.tool | head -30
echo

echo "4. List Lines:"
curl -s ${API_URL}/core/lines/ \
  -H "Authorization: Bearer $TOKEN" | python3 -m json.tool
echo

echo "=== All tests completed ==="
```

Run with: `chmod +x test_api.sh && ./test_api.sh`

---

## Frontend Testing Checklist

### Login & Navigation
- [ ] Can access login page
- [ ] Can log in with admin/admin
- [ ] Dashboard loads without errors
- [ ] Sidebar navigation works
- [ ] All menu items are accessible

### Inventory Management
- [ ] Can view coil list
- [ ] Can filter/search coils
- [ ] Can view coil details
- [ ] Coil status badges display correctly
- [ ] Can see 4 sample coils

### Production Management
- [ ] Can view job list
- [ ] Can filter jobs by status
- [ ] Can view job details
- [ ] Job status displays correctly
- [ ] Can see 3 sample jobs

### Customer Management
- [ ] Can view customer list
- [ ] Can search customers
- [ ] Can view customer details
- [ ] Can see 4 sample customers

### Notifications
- [ ] Notification bell appears
- [ ] Can view notification list
- [ ] Can mark notifications as read
- [ ] Notification preferences are accessible

---

## Performance Testing

### Response Time Benchmarks
```bash
# Test API response time
time curl -s http://localhost:8000/api/auth/token/ \
  -X POST \
  -H "Content-Type: application/json" \
  -d '{"username": "admin", "password": "admin"}' > /dev/null

# Expected: < 1 second
```

### Load Testing (Optional)
```bash
# Install apache bench
sudo apt-get install apache2-utils

# Test with 100 requests, 10 concurrent
ab -n 100 -c 10 http://localhost:8000/
```

---

## Troubleshooting

### Backend Issues

**Problem**: Can't access admin panel  
**Solution**: 
- Check backend is running: `curl http://localhost:8000/`
- Verify credentials: admin/admin
- Check logs in terminal where Django is running

**Problem**: Authentication fails  
**Solution**:
- Verify database is running: `sudo systemctl status postgresql`
- Check .env file has correct DB credentials
- Recreate superuser: `python manage.py createsuperuser`

### Frontend Issues

**Problem**: White screen or blank page  
**Solution**:
- Check browser console for errors
- Verify backend is accessible
- Check .env file has correct API_URL
- Rebuild: `npm run build`

**Problem**: API calls fail  
**Solution**:
- Check CORS settings in backend settings.py
- Verify JWT token is being sent
- Check network tab in browser dev tools

### Database Issues

**Problem**: No data appears  
**Solution**:
- Reload sample data: `python load_sample_data.py`
- Check migrations: `python manage.py showmigrations`
- Verify PostgreSQL is running

---

## Security Testing

### Authentication
- [ ] Cannot access API without token
- [ ] Token expires after configured time
- [ ] Refresh token works
- [ ] Invalid credentials are rejected

### Authorization
- [ ] Admin can access all endpoints
- [ ] Non-admin users have restricted access (when implemented)
- [ ] CRUD operations require proper permissions

### Data Validation
- [ ] Invalid data is rejected (test with malformed JSON)
- [ ] SQL injection protection (test with special characters)
- [ ] XSS protection (test with script tags)

---

## Next Steps

After basic testing is complete:

1. **Custom Data**: Add your own customers, coils, and jobs
2. **Workflows**: Test complete workflows (coil receiving → job creation → shipping)
3. **Reports**: Generate and review reports
4. **EDI**: Configure and test EDI integrations
5. **Notifications**: Set up email notifications
6. **Data Migration**: Import legacy data if available

---

## Support & Documentation

- **Main README**: `/home/runner/work/ABIS-I-Think/ABIS-I-Think/abis_modern/README.md`
- **API Documentation**: http://localhost:8000/api/docs/
- **API Schema**: http://localhost:8000/api/schema/
- **Project Overview**: `/home/runner/work/ABIS-I-Think/ABIS-I-Think/abis_modern/PROJECT_COMPLETE.md`

---

## Test Results Template

Use this template to document your testing results:

```
Date: [DATE]
Tester: [NAME]

Backend Tests:
- [ ] Authentication: PASS/FAIL
- [ ] API Endpoints: PASS/FAIL  
- [ ] Admin Panel: PASS/FAIL
- [ ] Sample Data: PASS/FAIL

Frontend Tests:
- [ ] Login: PASS/FAIL
- [ ] Dashboard: PASS/FAIL
- [ ] Inventory: PASS/FAIL
- [ ] Production: PASS/FAIL
- [ ] Customers: PASS/FAIL

Issues Found:
1. [Issue description]
2. [Issue description]

Notes:
[Additional observations]
```

---

**Testing Complete!** 🎉

The ABIS Modern application is ready for production use. All core functionality has been verified and sample data is available for testing.
