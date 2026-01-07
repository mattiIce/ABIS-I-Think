#!/bin/bash

echo "🔧 Running Django migrations..."
cd /workspaces/ABIS-I-Think/abis_modern

echo ""
echo "Step 1: Making migrations..."
python manage.py makemigrations

echo ""
echo "Step 2: Running migrations..."
python manage.py migrate

echo ""
echo "✅ Migrations complete!"
echo ""
echo "Database tables are now created."
echo "You can now access the analytics endpoints."
