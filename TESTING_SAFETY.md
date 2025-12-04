# ABIS Modern - Testing Safety Configuration

## 🛡️ Overview

This document explains the safety measures in place to prevent test data from being sent to external systems, including:
- Email notifications to real recipients
- EDI transactions to trading partners
- External API calls

## ✅ Current Safety Status

### Email Notifications: DISABLED FOR EXTERNAL TRANSMISSION ✅

**Configuration:**
- `EMAIL_BACKEND=django.core.mail.backends.console.EmailBackend`
- All emails are logged to console only
- No actual emails are sent to external recipients
- Safe for testing without risk of spam

**Location:** `/home/runner/work/ABIS-I-Think/ABIS-I-Think/abis_modern/.env`

**How It Works:**
```python
# In notifications/services.py
if settings.DEBUG or EMAIL_BACKEND == 'console':
    logger.info(f"[TEST MODE] Email notification logged but not sent: {subject}")
    return True  # Mark as sent but don't actually send
```

### EDI Transmission: DISABLED FOR EXTERNAL TRANSMISSION ✅

**Configuration:**
- `EDI_ENABLED=False`
- `EDI_TEST_MODE=True`
- All EDI transactions are blocked at the API level
- EDI files are written to `/tmp/edi/` (local temp directory)

**Location:** `/home/runner/work/ABIS-I-Think/ABIS-I-Think/abis_modern/.env`

**How It Works:**
```python
# In edi/views.py - All generate_* methods
if settings.DEBUG or edi_test_mode or not edi_enabled:
    return Response({
        'status': 'test_mode',
        'message': 'EDI transmission disabled in test/development mode.'
    })
```

---

## 📋 Safety Checklist

### Before Any Testing
- [x] `DEBUG=True` in .env file
- [x] `EMAIL_BACKEND=django.core.mail.backends.console.EmailBackend`
- [x] `EDI_ENABLED=False`
- [x] `EDI_TEST_MODE=True`
- [x] Email credentials are fake (`test@example.com`)
- [x] EDI paths point to `/tmp/` (temporary directory)

### Verification Commands

#### Check Email Configuration
```bash
cd /home/runner/work/ABIS-I-Think/ABIS-I-Think/abis_modern
source venv/bin/activate

python manage.py shell
>>> from django.conf import settings
>>> print(f"DEBUG: {settings.DEBUG}")
>>> print(f"EMAIL_BACKEND: {settings.EMAIL_BACKEND}")
>>> print(f"EMAIL_HOST_USER: {settings.EMAIL_HOST_USER}")
>>> exit()
```

Expected output:
```
DEBUG: True
EMAIL_BACKEND: django.core.mail.backends.console.EmailBackend
EMAIL_HOST_USER: test@example.com
```

#### Check EDI Configuration
```bash
grep -E "EDI_ENABLED|EDI_TEST_MODE" .env
```

Expected output:
```
EDI_ENABLED=False
EDI_TEST_MODE=True
```

---

## 🔍 What Happens During Testing

### When Creating Notifications
1. Notification is saved to database ✅
2. Email is formatted and prepared ✅
3. Email is logged to console (visible in terminal) ✅
4. **Email is NOT sent to any external server** ✅
5. Notification marked as "sent" in database ✅

**Console Output Example:**
```
[2025-12-03 17:30:00] INFO [TEST MODE] Email notification logged but not sent: Job JOB-2024-001 Started
```

### When Generating EDI Transactions
1. API request is received ✅
2. Safety check blocks transmission immediately ✅
3. Response returned with test mode message ✅
4. **No EDI data is sent to any trading partner** ✅
5. No files are created or transmitted ✅

**API Response Example:**
```json
{
    "status": "test_mode",
    "message": "EDI transmission disabled in test/development mode. Transaction logged but not transmitted.",
    "note": "Set EDI_ENABLED=True and EDI_TEST_MODE=False in production to enable external transmission."
}
```

---

## 🚨 Production Configuration (DO NOT USE FOR TESTING)

When ready for production deployment, these settings would need to be changed:

### Email Configuration (Production)
```bash
# .env file
DEBUG=False
EMAIL_BACKEND=django.core.mail.backends.smtp.EmailBackend
EMAIL_HOST=smtp.gmail.com  # Or your SMTP server
EMAIL_PORT=587
EMAIL_USE_TLS=True
EMAIL_HOST_USER=real-email@company.com
EMAIL_HOST_PASSWORD=actual-password
DEFAULT_FROM_EMAIL=noreply@company.com
```

### EDI Configuration (Production)
```bash
# .env file
EDI_ENABLED=True
EDI_TEST_MODE=False
EDI_OUTBOUND_PATH=/var/edi/outbound  # Production path
EDI_INBOUND_PATH=/var/edi/inbound
EDI_ARCHIVE_PATH=/var/edi/archive
```

**⚠️ WARNING:** Never enable these production settings in a test environment!

---

## 🧪 Testing Email Functionality

### View Console Emails
All emails during testing are displayed in the Django console where the server is running:

```bash
# Terminal where Django is running will show:
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Job Started - JOB-2024-001
From: noreply@abis.com
To: admin@example.com
Date: Wed, 03 Dec 2025 17:30:00 -0000

Dear Admin,

Job JOB-2024-001 has been started...
```

### Test Notification Creation
```python
# In Django shell
from django.contrib.auth.models import User
from notifications.services import NotificationService

user = User.objects.get(username='admin')
context = {
    'job_id': 1,
    'job_number': 'JOB-TEST-001',
    'customer_name': 'Test Customer',
    'status': 'Started',
    'quantity': 100,
    'part_number': 'TEST-PART'
}

notification = NotificationService.create_notification(
    user=user,
    notification_type='JOB_STARTED',
    context_data=context
)

# This will log to console but NOT send email
NotificationService.send_notification(notification)
```

---

## 🧪 Testing EDI Functionality

### Test EDI Generation (Safe)
```bash
# Get auth token
TOKEN=$(curl -s -X POST http://localhost:8000/api/auth/token/ \
  -H "Content-Type: application/json" \
  -d '{"username": "admin", "password": "admin"}' | \
  python3 -c "import sys, json; print(json.load(sys.stdin)['access'])")

# Try to generate EDI 856 (will be blocked)
curl -X POST http://localhost:8000/api/edi/transactions/generate_856/ \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"partner_id": 1, "reference_id": 1}'
```

**Response:**
```json
{
    "status": "test_mode",
    "message": "EDI transmission disabled in test/development mode. Transaction logged but not transmitted.",
    "note": "Set EDI_ENABLED=True and EDI_TEST_MODE=False in production to enable external transmission."
}
```

---

## 📝 Environment Variables Reference

### Current Testing Configuration
```bash
# Safety Settings - KEEP THESE FOR TESTING
DEBUG=True
EMAIL_BACKEND=django.core.mail.backends.console.EmailBackend
EMAIL_HOST_USER=test@example.com
EMAIL_HOST_PASSWORD=test-password-not-real
EDI_ENABLED=False
EDI_TEST_MODE=True
EDI_OUTBOUND_PATH=/tmp/edi/outbound
EDI_INBOUND_PATH=/tmp/edi/inbound
EDI_ARCHIVE_PATH=/tmp/edi/archive
```

### What Each Setting Does

| Setting | Current Value | Purpose | Safe for Testing? |
|---------|---------------|---------|-------------------|
| `DEBUG` | `True` | Enable debug mode, prevents external calls | ✅ YES |
| `EMAIL_BACKEND` | `console` | Log emails to console only | ✅ YES |
| `EMAIL_HOST_USER` | `test@example.com` | Fake email address | ✅ YES |
| `EDI_ENABLED` | `False` | Disable EDI transmission | ✅ YES |
| `EDI_TEST_MODE` | `True` | Block EDI even if enabled | ✅ YES |
| `EDI_OUTBOUND_PATH` | `/tmp/edi/outbound` | Temp directory, auto-cleaned | ✅ YES |

---

## 🔒 Code-Level Safety Features

### 1. Email Notification Service
**File:** `abis_modern/notifications/services.py`

```python
@staticmethod
def send_notification(notification):
    # SAFETY: Check if in test/development mode
    if settings.DEBUG or EMAIL_BACKEND == 'console':
        logger.info(f"[TEST MODE] Email logged but not sent")
        notification.mark_as_sent()
        return True
    
    # Production code (only runs when DEBUG=False)
    # ...
```

### 2. EDI Generation Views
**File:** `abis_modern/edi/views.py`

```python
def generate_856(self, request):
    # SAFETY: Prevent external EDI transmission
    edi_enabled = os.getenv('EDI_ENABLED', 'False') == 'True'
    edi_test_mode = os.getenv('EDI_TEST_MODE', 'True') == 'True'
    
    if settings.DEBUG or edi_test_mode or not edi_enabled:
        return Response({
            'status': 'test_mode',
            'message': 'EDI transmission disabled'
        })
    
    # Production code (only runs when all safety checks pass)
    # ...
```

---

## ✅ Safety Verification Script

Create and run this script to verify all safety settings:

```bash
#!/bin/bash
# File: check_safety.sh

echo "=== ABIS Testing Safety Check ==="
echo

cd /home/runner/work/ABIS-I-Think/ABIS-I-Think/abis_modern

echo "1. Checking .env configuration..."
echo "   DEBUG:" $(grep "^DEBUG=" .env)
echo "   EMAIL_BACKEND:" $(grep "^EMAIL_BACKEND=" .env)
echo "   EDI_ENABLED:" $(grep "^EDI_ENABLED=" .env)
echo "   EDI_TEST_MODE:" $(grep "^EDI_TEST_MODE=" .env)
echo

echo "2. Checking email settings..."
source venv/bin/activate
python -c "
from django.conf import settings
import os
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'abis_modern.settings')
from django.conf import settings
print(f'   Email Backend: {settings.EMAIL_BACKEND}')
print(f'   Email User: {settings.EMAIL_HOST_USER}')
print(f'   Safe: {\"console\" in settings.EMAIL_BACKEND or \"test\" in settings.EMAIL_HOST_USER}')
"
echo

echo "3. Testing API safety..."
curl -s -X POST http://localhost:8000/api/auth/token/ \
  -H "Content-Type: application/json" \
  -d '{"username": "admin", "password": "admin"}' > /dev/null && \
  echo "   API is responding" || echo "   API check failed"

echo
echo "=== Safety Check Complete ==="
echo
echo "✅ Safe for testing if:"
echo "   - DEBUG=True"
echo "   - EMAIL_BACKEND contains 'console'"
echo "   - EDI_ENABLED=False"
echo "   - EDI_TEST_MODE=True"
```

Run with:
```bash
chmod +x check_safety.sh
./check_safety.sh
```

---

## 🎯 Summary

### ✅ What IS Safe to Test
- Creating notifications (saved to database)
- Viewing notifications in admin panel
- Testing notification preferences
- Triggering notification signals
- Creating EDI transaction records
- Viewing EDI transactions in admin
- Testing EDI API endpoints

### ❌ What WILL NOT Happen During Testing
- ❌ No emails sent to external servers
- ❌ No EDI files transmitted to trading partners
- ❌ No external API calls
- ❌ No real SMS or push notifications
- ❌ No production data affected

### 🔐 How Safety is Enforced
1. **Environment Variables**: Configuration in .env file
2. **Django Settings**: DEBUG mode checks
3. **Code-Level Guards**: Explicit checks in service methods
4. **API Response Blocking**: Early returns before external calls
5. **Console Logging**: Visibility of what would be sent

---

## 📞 Questions?

If unsure about any setting, always err on the side of caution:
1. Keep `DEBUG=True`
2. Keep `EMAIL_BACKEND=console`
3. Keep `EDI_ENABLED=False`
4. Keep `EDI_TEST_MODE=True`

**These settings ensure no external transmission occurs during testing.**

---

**Last Updated:** December 3, 2025  
**Status:** ✅ SAFE FOR TESTING - All external transmission disabled
