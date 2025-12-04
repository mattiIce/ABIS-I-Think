# Email Notifications System

A comprehensive email notification system for the ABIS Production Management System that automatically sends alerts for key events.

## Features

- **Automatic Notifications**: Real-time notifications for production, shipping, quality, and inventory events
- **User Preferences**: Granular control over notification types for both email and in-app
- **Email Templates**: Professional HTML email templates for all notification types
- **Django Signals**: Event-driven notifications triggered by model changes
- **Admin Interface**: Full admin panel for managing templates and viewing notification history
- **REST API**: Complete API for frontend notification management
- **Test Notifications**: Send test emails to verify configuration

## Notification Types

1. **Production Events**
   - Job Started
   - Job Completed
   - Job On Hold

2. **Shipping Events**
   - Shipment Created
   - Shipment Shipped

3. **Quality Events**
   - QA Test Failed
   - QA Test Passed

4. **Inventory Events**
   - Low Inventory Alert
   - Inventory Received

5. **Other Events**
   - Customer Order
   - Maintenance Due
   - Downtime Alert

## Setup

### 1. Run Setup Script

```bash
cd abis_modern
chmod +x setup_notifications.sh
./setup_notifications.sh
```

This will:
- Run database migrations
- Create notification tables
- Initialize default email templates

### 2. Configure Email Settings

#### For Development (Console Backend)
No configuration needed. Emails will be printed to the console.

#### For Production (SMTP)
Add to your `.env` file:

```env
EMAIL_BACKEND=django.core.mail.backends.smtp.EmailBackend
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USE_TLS=True
EMAIL_HOST_USER=your-email@gmail.com
EMAIL_HOST_PASSWORD=your-app-password
DEFAULT_FROM_EMAIL=noreply@abis.com
SERVER_EMAIL=noreply@abis.com
```

#### Gmail Setup
1. Enable 2-factor authentication on your Gmail account
2. Generate an App Password: https://myaccount.google.com/apppasswords
3. Use the app password in `EMAIL_HOST_PASSWORD`

## Usage

### Backend (Django)

#### Send Notification Programmatically

```python
from notifications.services import NotificationService

# Send notification to specific user
user = User.objects.get(username='john')
context = {
    'job_id': 'JOB-001',
    'job_number': 'JOB-2024-001',
    'customer_name': 'Acme Corp',
    'status': 'In Progress',
    'quantity': 5000,
    'alloy': '3003',
}
notification = NotificationService.create_notification(
    user, 'JOB_STARTED', context
)
NotificationService.send_notification(notification)

# Send to multiple users
NotificationService.send_bulk_notification(
    'INVENTORY_LOW',
    context_data,
    user_filter=Q(groups__name='Inventory')
)
```

#### Automatic Notifications via Signals

Notifications are automatically sent when:
- A Job status changes
- A Shipment is created or shipped
- A QA test is completed
- A new Coil is received

### Frontend (React)

#### View Notifications

```typescript
import { notificationsApi } from '../api/notifications';

// Get all notifications
const notifications = await notificationsApi.getNotifications();

// Filter notifications
const unread = await notificationsApi.getNotifications({ status: 'SENT' });

// Get unread count
const { unread_count } = await notificationsApi.getUnreadCount();

// Mark as read
await notificationsApi.markAsRead(notificationId);
await notificationsApi.markAllAsRead();
```

#### Manage Preferences

```typescript
// Get preferences
const prefs = await notificationsApi.getPreferences();

// Update preferences
await notificationsApi.updatePreferences({
  email_job_started: true,
  email_qa_failed: true,
  app_inventory_low: true,
});
```

## API Endpoints

### Notifications

- `GET /api/notifications/notifications/` - List notifications
- `GET /api/notifications/notifications/{id}/` - Get notification detail
- `POST /api/notifications/notifications/{id}/mark_read/` - Mark as read
- `POST /api/notifications/notifications/mark_all_read/` - Mark all as read
- `GET /api/notifications/notifications/unread_count/` - Get unread count
- `GET /api/notifications/notifications/summary/` - Get statistics

### Preferences

- `GET /api/notifications/preferences/my_preferences/` - Get user preferences
- `POST /api/notifications/preferences/update_preferences/` - Update preferences

### Templates (Admin Only)

- `GET /api/notifications/templates/` - List templates
- `GET /api/notifications/templates/{id}/` - Get template detail
- `POST /api/notifications/templates/` - Create template
- `PUT /api/notifications/templates/{id}/` - Update template
- `DELETE /api/notifications/templates/{id}/` - Delete template

### Testing

- `POST /api/notifications/test/` - Send test notification (admin only)

## Admin Panel

Access at: `http://localhost:8000/admin/notifications/`

### Manage Templates
- Edit subject and body text/HTML
- Enable/disable templates
- Preview templates

### View Notifications
- See all sent notifications
- Filter by status, type, user
- View error messages for failed notifications

### User Preferences
- View and edit user notification preferences
- Set defaults for new users

## Email Templates

Located in: `notifications/templates/emails/`

Templates support Django template variables:

```html
<p>Job Number: {{ job_number }}</p>
<p>Customer: {{ customer_name }}</p>
<p>Status: {{ status }}</p>
```

### Customize Templates

1. Edit HTML files in `notifications/templates/emails/`
2. Or edit in admin panel: Admin → Notification Templates
3. Run `python manage.py init_notification_templates` to reload from files

## Frontend Pages

### Notifications List
- **Path**: `/notifications`
- View all notifications
- Filter by status and type
- Mark as read individually or all at once
- See notification summary statistics

### Notification Preferences
- **Path**: `/notifications/preferences`
- Toggle email/in-app notifications
- Configure per-notification-type settings
- Set up daily/weekly digests
- Send test notifications

## Database Models

### NotificationTemplate
Stores email templates for each notification type.

### Notification
Stores individual notification records with status tracking.

### UserNotificationPreference
Stores user-specific notification preferences.

## Troubleshooting

### Emails Not Sending

1. Check email configuration in `.env`
2. Verify EMAIL_BACKEND is set correctly
3. For Gmail, ensure app password is used (not regular password)
4. Check Django logs for SMTP errors
5. Test with console backend first: `EMAIL_BACKEND=django.core.mail.backends.console.EmailBackend`

### Notifications Not Triggering

1. Ensure signals are connected: Check `notifications/apps.py` imports signals
2. Verify notification templates exist: Run `init_notification_templates` command
3. Check user preferences: Users may have disabled certain notifications
4. Look for errors in Django logs

### Template Not Found

1. Run: `python manage.py init_notification_templates`
2. Verify HTML files exist in `notifications/templates/emails/`
3. Check template is marked as active in admin panel

## Testing

### Send Test Email

```bash
# Via Django shell
python manage.py shell
>>> from notifications.services import NotificationService
>>> from django.contrib.auth.models import User
>>> user = User.objects.first()
>>> context = {'job_number': 'TEST-001', 'customer_name': 'Test', ...}
>>> notif = NotificationService.create_notification(user, 'JOB_STARTED', context)
>>> NotificationService.send_notification(notif)
```

### Via API (Admin Only)

```bash
curl -X POST http://localhost:8000/api/notifications/test/ \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"notification_type": "JOB_STARTED"}'
```

### Via Frontend

1. Log in as admin
2. Navigate to Notifications → Preferences
3. Click "Send Test Email" button

## Environment Variables

```env
# Email Backend
EMAIL_BACKEND=django.core.mail.backends.smtp.EmailBackend  # or console for dev

# SMTP Settings
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USE_TLS=True
EMAIL_HOST_USER=your-email@gmail.com
EMAIL_HOST_PASSWORD=your-app-password

# From Addresses
DEFAULT_FROM_EMAIL=noreply@abis.com
SERVER_EMAIL=noreply@abis.com
```

## Future Enhancements

- [ ] SMS notifications
- [ ] Push notifications
- [ ] Webhook integrations
- [ ] Notification scheduling
- [ ] Advanced digest customization
- [ ] Notification templates per user/group
- [ ] Rich text editor for templates in admin
- [ ] Notification priority levels
- [ ] Read receipts tracking
