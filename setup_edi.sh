#!/bin/bash
# Script to setup EDI system and restart Django server

set -e  # Exit on error

echo "================================================"
echo "EDI System Setup & Server Restart"
echo "================================================"

cd /workspaces/ABIS-I-Think/abis_modern

echo ""
echo "Step 1: Creating EDI migrations..."
python manage.py makemigrations edi

echo ""
echo "Step 2: Running all migrations..."
python manage.py migrate

echo ""
echo "Step 3: Testing EDI system..."
python test_edi_system.py

echo ""
echo "================================================"
echo "✅ Setup Complete!"
echo "================================================"
echo ""
echo "Backend server should be running at:"
echo "  http://localhost:8000"
echo ""
echo "Try these EDI endpoints:"
echo "  http://localhost:8000/api/edi/partners/"
echo "  http://localhost:8000/api/edi/transactions/"
echo "  http://localhost:8000/admin/edi/"
echo ""
echo "Frontend should be running at:"
echo "  http://localhost:5173"
echo ""
echo "================================================"
