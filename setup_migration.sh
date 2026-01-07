#!/bin/bash

# Data Migration Setup and Execution Script

set -e

echo "======================================"
echo "ABIS Data Migration Setup"
echo "======================================"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if running in correct directory
if [ ! -f "manage.py" ]; then
    echo -e "${RED}Error: Must run from Django project root (abis_modern/)${NC}"
    exit 1
fi

# Check if virtual environment is activated
if [ -z "$VIRTUAL_ENV" ]; then
    echo -e "${YELLOW}Warning: Virtual environment not detected${NC}"
    echo "Recommend: source venv/bin/activate"
    echo ""
fi

# Step 1: Install cx_Oracle
echo "Step 1: Installing cx_Oracle..."
pip install cx_Oracle

# Step 2: Check Oracle Instant Client (optional)
echo ""
echo "Step 2: Checking Oracle Instant Client..."
if [ -n "$LD_LIBRARY_PATH" ]; then
    echo -e "${GREEN}✓ LD_LIBRARY_PATH is set: $LD_LIBRARY_PATH${NC}"
else
    echo -e "${YELLOW}⚠ LD_LIBRARY_PATH not set${NC}"
    echo "If connection fails, you may need Oracle Instant Client:"
    echo "  1. Download from: https://www.oracle.com/database/technologies/instant-client/downloads.html"
    echo "  2. Extract to /opt/instantclient"
    echo "  3. Run: export LD_LIBRARY_PATH=/opt/instantclient:\$LD_LIBRARY_PATH"
fi

# Step 3: Check environment variables
echo ""
echo "Step 3: Checking environment configuration..."
if [ ! -f ".env" ]; then
    echo -e "${RED}✗ .env file not found${NC}"
    echo "Creating .env template..."
    cat > .env << EOF
# Oracle 11g Connection (Solaris 10)
ORACLE_USER=dbo
ORACLE_PASSWORD=obd#157

# Option 1: Use TNS name (recommended)
ORACLE_TNS_NAME=your_tns_name_here

# Option 2: Direct connection (uncomment if not using TNS)
# ORACLE_HOST=solaris-server-hostname
# ORACLE_PORT=1521
# ORACLE_SERVICE=ABIS

# TNS_ADMIN path (if tnsnames.ora not in default location)
# TNS_ADMIN=/path/to/tnsnames/directory

# PostgreSQL Connection
DATABASE_URL=postgresql://user:password@localhost/abis_modern
EOF
    echo -e "${YELLOW}⚠ Please edit .env with your Oracle credentials${NC}"
else
    echo -e "${GREEN}✓ .env file exists${NC}"
    
    # Check for Oracle variables
    if grep -q "ORACLE_USER" .env && grep -q "ORACLE_PASSWORD" .env; then
        echo -e "${GREEN}✓ Oracle credentials configured${NC}"
    else
        echo -e "${YELLOW}⚠ Add Oracle credentials to .env:${NC}"
        echo "  ORACLE_USER=abis"
        echo "  ORACLE_PASSWORD=..."
        echo "  ORACLE_HOST=..."
        echo "  ORACLE_PORT=1521"
        echo "  ORACLE_SERVICE=ABIS"
    fi
fi

# Step 4: Test connection
echo ""
echo "Step 4: Testing Oracle connection..."
echo "Run: python manage.py migrate_legacy_data --check-only"
echo ""
read -p "Test connection now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    python manage.py migrate_legacy_data --check-only
fi

# Step 5: Ready to migrate
echo ""
echo "======================================"
echo "Setup Complete!"
echo "======================================"
echo ""
echo "Next steps:"
echo ""
echo "1. Test connection (if not done):"
echo "   ${GREEN}python manage.py migrate_legacy_data --check-only${NC}"
echo ""
echo "2. Run dry run:"
echo "   ${GREEN}python manage.py migrate_legacy_data --dry-run${NC}"
echo ""
echo "3. Migrate single entity (test):"
echo "   ${GREEN}python manage.py migrate_legacy_data --entity carrier${NC}"
echo ""
echo "4. Full migration with validation:"
echo "   ${GREEN}python manage.py migrate_legacy_data --validate${NC}"
echo ""
echo "For more options: python manage.py migrate_legacy_data --help"
echo ""
