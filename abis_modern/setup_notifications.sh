#!/bin/bash

echo "Setting up Email Notifications system..."
echo "=========================================="

# Navigate to the Django project directory
cd "$(dirname "$0")"

echo ""
echo "Step 1: Running database migrations..."
python manage.py makemigrations notifications
python manage.py migrate

echo ""
echo "Step 2: Initializing notification templates..."
python manage.py init_notification_templates

echo ""
echo "=========================================="
echo "Email Notifications setup complete!"
echo ""
echo "Next steps:"
echo "1. Configure email settings in .env file:"
echo "   EMAIL_BACKEND=django.core.mail.backends.smtp.EmailBackend"
echo "   EMAIL_HOST=smtp.gmail.com"
echo "   EMAIL_PORT=587"
echo "   EMAIL_USE_TLS=True"
echo "   EMAIL_HOST_USER=your-email@gmail.com"
echo "   EMAIL_HOST_PASSWORD=your-app-password"
echo "   DEFAULT_FROM_EMAIL=noreply@abis.com"
echo ""
echo "2. For development, you can use console backend (default):"
echo "   EMAIL_BACKEND=django.core.mail.backends.console.EmailBackend"
echo ""
echo "3. Access notifications in the admin panel at /admin/"
echo "4. Users can manage preferences at /notifications/preferences/"
echo ""
