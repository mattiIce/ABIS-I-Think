#!/usr/bin/env python
"""Create a superuser for Django admin access."""
import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'abis_modern.settings')
django.setup()

from django.contrib.auth import get_user_model

User = get_user_model()

username = 'admin'
email = 'admin@abis.com'
password = 'admin123'

if User.objects.filter(username=username).exists():
    print(f"✅ Superuser '{username}' already exists")
    user = User.objects.get(username=username)
    # Update password in case it was different
    user.set_password(password)
    user.save()
    print(f"✅ Password updated for '{username}'")
else:
    User.objects.create_superuser(username=username, email=email, password=password)
    print(f"✅ Superuser '{username}' created successfully")

print(f"\n🔐 Admin Login Credentials:")
print(f"   URL: http://localhost:8000/admin/")
print(f"   Username: {username}")
print(f"   Password: {password}")
