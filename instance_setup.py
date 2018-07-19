# import stdlibs
import os
import sys
# import 3rd-party libs
from django.core.management.base import BaseCommand, CommandError
from django.contrib.auth.models import User
# import local libs


class Command(BaseCommand):

    help = 'Setup Django instance via environment vars inside container'

    def handle(self, *args, **options):
        username = os.environ.get('DJANGO_ADMIN_USER')
        password = os.environ.get('DJANGO_ADMIN_PASS')
        email = os.environ.get('DJANGO_ADMIN_EMAIL')
        admin_user = User.objects.create_superuser(username, email, password)
        admin_user.save()
