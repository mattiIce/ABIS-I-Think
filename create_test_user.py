#!/usr/bin/env python
"""
Quick script to create a test user for ABIS Modern
"""
import os
import sys
import django

# Setup Django
sys.path.insert(0, '/workspaces/ABIS-I-Think/abis_modern')
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'abis_modern.settings')
django.setup()

from django.contrib.auth.models import User

# Create test user
username = 'admin'
password = 'admin123'
email = 'admin@abis.local'

if User.objects.filter(username=username).exists():
    print(f"✓ User '{username}' already exists")
    user = User.objects.get(username=username)
    user.set_password(password)
    user.save()
    print(f"✓ Password updated for '{username}'")
else:
    user = User.objects.create_superuser(
        username=username,
        email=email,
        password=password,
        first_name='Admin',
        last_name='User'
    )
    print(f"✓ Created superuser: {username}")

print(f"""
Login Credentials:
------------------
Username: {username}
Password: {password}
Email: {email}

You can now login at: http://localhost:3000/login
""")
