#!/bin/bash
# ABIS Modern - Testing Safety Verification Script
# This script verifies that all safety settings are properly configured

echo "╔════════════════════════════════════════════════════╗"
echo "║   ABIS Modern - Testing Safety Verification       ║"
echo "╚════════════════════════════════════════════════════╝"
echo

cd "$(dirname "$0")/abis_modern"

SAFE=true

echo "Checking safety configuration..."
echo

# Check DEBUG mode
echo "1. DEBUG Mode:"
DEBUG=$(grep "^DEBUG=" .env | cut -d'=' -f2)
if [ "$DEBUG" = "True" ]; then
    echo "   ✅ DEBUG=True (Safe for testing)"
else
    echo "   ⚠️  DEBUG=$DEBUG (Should be True for testing)"
    SAFE=false
fi
echo

# Check Email Backend
echo "2. Email Configuration:"
EMAIL_BACKEND=$(grep "^EMAIL_BACKEND=" .env | cut -d'=' -f2)
EMAIL_USER=$(grep "^EMAIL_HOST_USER=" .env | cut -d'=' -f2)

if [[ "$EMAIL_BACKEND" == *"console"* ]]; then
    echo "   ✅ EMAIL_BACKEND=console (Emails logged, not sent)"
else
    echo "   ⚠️  EMAIL_BACKEND=$EMAIL_BACKEND (May send real emails!)"
    SAFE=false
fi

if [[ "$EMAIL_USER" == *"test"* ]] || [[ "$EMAIL_USER" == *"example"* ]]; then
    echo "   ✅ EMAIL_HOST_USER=$EMAIL_USER (Test credentials)"
else
    echo "   ⚠️  EMAIL_HOST_USER=$EMAIL_USER (Real credentials detected!)"
    SAFE=false
fi
echo

# Check EDI Configuration
echo "3. EDI Configuration:"
EDI_ENABLED=$(grep "^EDI_ENABLED=" .env | cut -d'=' -f2)
EDI_TEST_MODE=$(grep "^EDI_TEST_MODE=" .env | cut -d'=' -f2)
EDI_PATH=$(grep "^EDI_OUTBOUND_PATH=" .env | cut -d'=' -f2)

if [ "$EDI_ENABLED" = "False" ]; then
    echo "   ✅ EDI_ENABLED=False (EDI transmission disabled)"
else
    echo "   ⚠️  EDI_ENABLED=$EDI_ENABLED (EDI may be transmitted!)"
    SAFE=false
fi

if [ "$EDI_TEST_MODE" = "True" ]; then
    echo "   ✅ EDI_TEST_MODE=True (Extra safety layer)"
else
    echo "   ⚠️  EDI_TEST_MODE=$EDI_TEST_MODE (Should be True for testing)"
    SAFE=false
fi

if [[ "$EDI_PATH" == *"/tmp/"* ]]; then
    echo "   ✅ EDI_OUTBOUND_PATH=$EDI_PATH (Temporary directory)"
else
    echo "   ⚠️  EDI_OUTBOUND_PATH=$EDI_PATH (Production path detected!)"
    SAFE=false
fi
echo

# Check if servers are running
echo "4. Server Status:"
if curl -s http://localhost:8000/ > /dev/null 2>&1; then
    echo "   ✅ Backend server running (http://localhost:8000)"
else
    echo "   ⚠️  Backend server not responding"
fi

if curl -s http://localhost:3000/ > /dev/null 2>&1; then
    echo "   ✅ Frontend server running (http://localhost:3000)"
else
    echo "   ⚠️  Frontend server not responding"
fi
echo

# Final verdict
echo "════════════════════════════════════════════════════"
if [ "$SAFE" = true ]; then
    echo "✅ ALL SAFETY CHECKS PASSED"
    echo
    echo "Your environment is SAFE for testing:"
    echo "  • No emails will be sent to external addresses"
    echo "  • No EDI will be transmitted to trading partners"
    echo "  • All external communications are disabled"
    echo
    echo "You can safely test all features without risk."
else
    echo "⚠️  SAFETY WARNINGS DETECTED"
    echo
    echo "Please review the warnings above and adjust your"
    echo ".env file settings before testing."
    echo
    echo "See TESTING_SAFETY.md for detailed instructions."
fi
echo "════════════════════════════════════════════════════"
echo

exit 0
