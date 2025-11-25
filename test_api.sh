#!/bin/bash
# Test script to verify Django API is working

API_URL="http://localhost:8000/api"

echo "Testing ABIS Modern API..."
echo "=========================="
echo ""

# Test 1: Health check
echo "1. Testing health check endpoint..."
curl -s "$API_URL/health/" | python3 -m json.tool
echo ""

# Test 2: Try to login
echo "2. Testing login (you'll need to enter credentials)..."
read -p "Enter username: " USERNAME
read -sp "Enter password: " PASSWORD
echo ""

RESPONSE=$(curl -s -X POST "$API_URL/auth/token/" \
  -H "Content-Type: application/json" \
  -d "{\"username\":\"$USERNAME\",\"password\":\"$PASSWORD\"}")

echo "Login response:"
echo "$RESPONSE" | python3 -m json.tool
echo ""

# Extract token if login successful
ACCESS_TOKEN=$(echo "$RESPONSE" | python3 -c "import sys, json; print(json.load(sys.stdin).get('access', ''))" 2>/dev/null)

if [ -n "$ACCESS_TOKEN" ]; then
    echo "✓ Login successful!"
    echo ""
    
    # Test 3: Get user info
    echo "3. Testing user endpoint..."
    curl -s "$API_URL/auth/user/" \
      -H "Authorization: Bearer $ACCESS_TOKEN" | python3 -m json.tool
    echo ""
    
    echo "✓ All tests passed!"
else
    echo "✗ Login failed. Check your credentials and make sure:"
    echo "  - Django server is running on http://localhost:8000"
    echo "  - You have created a superuser with: python manage.py createsuperuser"
fi
