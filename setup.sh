#!/bin/bash
# Quick setup script for ABIS Modern

set -e

echo "========================================="
echo "ABIS Modern - Quick Setup"
echo "========================================="
echo ""

# Check Python version
echo "Checking Python version..."
python3 --version

# Create virtual environment
echo ""
echo "Creating virtual environment..."
python3 -m venv venv

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Install dependencies
echo ""
echo "Installing Python dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

# Copy environment file
if [ ! -f .env ]; then
    echo ""
    echo "Creating .env file from template..."
    cp .env.example .env
    echo "⚠️  IMPORTANT: Edit .env file with your database credentials!"
fi

# Create logs directory
mkdir -p logs

echo ""
echo "========================================="
echo "Setup Complete!"
echo "========================================="
echo ""
echo "Next steps:"
echo ""
echo "1. Edit .env file with your database settings:"
echo "   nano .env"
echo ""
echo "2. Create PostgreSQL database:"
echo "   createdb abis_db"
echo "   createuser abis_user"
echo "   psql -c \"ALTER USER abis_user WITH PASSWORD 'your_password';\""
echo "   psql -c \"GRANT ALL PRIVILEGES ON DATABASE abis_db TO abis_user;\""
echo ""
echo "3. Run database migrations:"
echo "   python manage.py migrate"
echo ""
echo "4. Create superuser:"
echo "   python manage.py createsuperuser"
echo ""
echo "5. Run development server:"
echo "   python manage.py runserver"
echo ""
echo "6. Access the application:"
echo "   Admin: http://localhost:8000/admin/"
echo "   API Docs: http://localhost:8000/api/docs/"
echo ""
