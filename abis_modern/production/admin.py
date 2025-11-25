from django.contrib import admin
from .models import Job, JobCoil, DailyProduction, Downtime

admin.site.register(Job)
admin.site.register(JobCoil)
admin.site.register(DailyProduction)
admin.site.register(Downtime)
