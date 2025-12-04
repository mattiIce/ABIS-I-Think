from django.contrib import admin
from .models import Shipment, EDITransaction

admin.site.register(Shipment)
admin.site.register(EDITransaction)
