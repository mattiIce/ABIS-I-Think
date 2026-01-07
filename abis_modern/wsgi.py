"""
WSGI config for ABIS Modern project.
"""

import os

from django.core.wsgi import get_wsgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'abis_modern.settings')

application = get_wsgi_application()
