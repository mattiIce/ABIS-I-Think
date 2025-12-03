# ABIS Modern - Quick Start Guide

## 🚀 Application is Ready!

Both backend and frontend servers are currently running and fully configured with sample data.

**🛡️ TESTING SAFETY:** All external communications are disabled. No emails or EDI will be sent to external systems.  
See [TESTING_SAFETY.md](TESTING_SAFETY.md) for details.

---

## 📍 Access Points

| Service | URL | Credentials |
|---------|-----|-------------|
| **Frontend** | http://localhost:3000 | admin / admin |
| **Admin Panel** | http://localhost:8000/admin | admin / admin |
| **API Root** | http://localhost:8000 | - |
| **API Docs** | http://localhost:8000/api/docs | - |
| **API Schema** | http://localhost:8000/api/schema | - |

---

## 🎯 Quick Actions

### Test the API (Terminal)
```bash
# Get authentication token
curl -X POST http://localhost:8000/api/auth/token/ \
  -H "Content-Type: application/json" \
  -d '{"username": "admin", "password": "admin"}'

# List customers (with token)
TOKEN="<your_access_token>"
curl http://localhost:8000/api/customers/customers/ \
  -H "Authorization: Bearer $TOKEN"
```

### Access the Frontend (Browser)
1. Open http://localhost:3000
2. Login with: **admin** / **admin**
3. Explore:
   - Dashboard - System overview
   - Inventory → Coils - View 4 sample coils
   - Production → Jobs - View 3 sample jobs
   - Customers - View 4 sample customers

### Access Admin Panel (Browser)
1. Open http://localhost:8000/admin
2. Login with: **admin** / **admin**
3. Browse all data models and configurations

---

## 📦 Sample Data Loaded

✅ **7 Production Lines** (24", 36", 60", 75", 84", 108", 110")  
✅ **3 Work Shifts** (Day, Evening, Night)  
✅ **6 Alloy Types** (3003, 3004, 3104, 5052, 5182, 6061)  
✅ **6 Tempers** (H14, H16, H18, H19, O, T6)  
✅ **3 Carriers** (ABC Trucking, XYZ Logistics, FastFreight)  
✅ **4 Customers** (Ford, GM, Tesla, Alcoa)  
✅ **4 Coils** (3 approved, 1 in quarantine)  
✅ **3 Jobs** (2 scheduled, 1 in progress)  
✅ **9 Notification Templates** (initialized)

---

## 🔄 Server Management

### Check Server Status
```bash
# Backend should show: "Django version 5.1.15, using settings 'abis_modern.settings'"
curl -I http://localhost:8000

# Frontend should show: "200 OK"
curl -I http://localhost:3000
```

### Restart Servers (if needed)

**Backend:**
```bash
cd /home/runner/work/ABIS-I-Think/ABIS-I-Think/abis_modern
source venv/bin/activate
python manage.py runserver 0.0.0.0:8000
```

**Frontend:**
```bash
cd /home/runner/work/ABIS-I-Think/ABIS-I-Think/abis_frontend
npm run dev -- --host 0.0.0.0 --port 3000
```

---

## 📚 Documentation

- **Testing Guide**: [TESTING_GUIDE.md](TESTING_GUIDE.md) - Comprehensive testing procedures
- **Backend README**: [abis_modern/README.md](abis_modern/README.md) - Django backend documentation
- **Frontend README**: [abis_frontend/README.md](abis_frontend/README.md) - React frontend documentation
- **Project Complete**: [abis_modern/PROJECT_COMPLETE.md](abis_modern/PROJECT_COMPLETE.md) - Full feature list

---

## 🔧 Common Tasks

### View Database
```bash
# Connect to PostgreSQL
psql -U abis_user -d abis_db -h localhost

# Inside psql:
\dt                    # List tables
SELECT * FROM customers;
SELECT * FROM inventory_coils;
SELECT * FROM production_jobs;
\q                     # Quit
```

### Django Management Commands
```bash
cd /home/runner/work/ABIS-I-Think/ABIS-I-Think/abis_modern
source venv/bin/activate

# Create another superuser
python manage.py createsuperuser

# Run migrations
python manage.py migrate

# Collect static files
python manage.py collectstatic

# Shell access
python manage.py shell
```

### Reload Sample Data
```bash
cd /home/runner/work/ABIS-I-Think/ABIS-I-Think/abis_modern
source venv/bin/activate
python load_sample_data.py
```

---

## 🧪 Quick Test

Run this to verify everything works:

```bash
# Test authentication
curl -X POST http://localhost:8000/api/auth/token/ \
  -H "Content-Type: application/json" \
  -d '{"username": "admin", "password": "admin"}' | python3 -m json.tool

# Test API (should return list of customers)
TOKEN=$(curl -s -X POST http://localhost:8000/api/auth/token/ \
  -H "Content-Type: application/json" \
  -d '{"username": "admin", "password": "admin"}' | \
  python3 -c "import sys, json; print(json.load(sys.stdin)['access'])")

curl -s http://localhost:8000/api/customers/customers/ \
  -H "Authorization: Bearer $TOKEN" | python3 -m json.tool
```

Expected output: JSON with 4 customers (Ford, GM, Tesla, Alcoa)

---

## 🎨 Screenshots

### Frontend Dashboard
Access at: http://localhost:3000

### Admin Panel
Access at: http://localhost:8000/admin

### API Documentation
Access at: http://localhost:8000/api/docs

---

## 🚨 Troubleshooting

### Backend not responding?
```bash
# Check if server is running
ps aux | grep "python manage.py runserver"

# Check port is listening
sudo netstat -tlnp | grep 8000
```

### Frontend not loading?
```bash
# Check if Node server is running
ps aux | grep "vite"

# Check port is listening
sudo netstat -tlnp | grep 3000
```

### Database connection error?
```bash
# Check PostgreSQL is running
sudo systemctl status postgresql

# Test connection
psql -U abis_user -d abis_db -h localhost -c "SELECT 1;"
```

---

## 📝 Next Steps

1. **Explore the UI**: Log in to the frontend and explore all features
2. **Test API**: Use the API documentation to test endpoints
3. **Add Data**: Create your own customers, coils, and jobs
4. **Run Tests**: Follow the [TESTING_GUIDE.md](TESTING_GUIDE.md)
5. **Customize**: Modify configurations in `.env` files

---

## 💡 Tips

- **API Token**: Access tokens expire after 60 minutes. Use refresh token to get a new one.
- **Sample Data**: All sample data can be deleted/modified in the admin panel.
- **Database**: PostgreSQL data persists between restarts.
- **Frontend**: React development server hot-reloads on code changes.
- **Backend**: Django development server reloads on code changes.

---

## 🆘 Support

For detailed information, refer to:
- Main documentation in `abis_modern/README.md`
- Testing procedures in `TESTING_GUIDE.md`
- Project overview in `abis_modern/PROJECT_COMPLETE.md`

---

**Status**: ✅ Application fully functional and ready for testing!

**Last Updated**: December 3, 2025
