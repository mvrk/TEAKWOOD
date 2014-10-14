"""
WSGI config for settings project.

This module contains the WSGI application used by Django's development server
and any production WSGI deployments. It should expose a module-level variable
named ``application``. Django's ``runserver`` and ``runfcgi`` commands discover
this application via the ``WSGI_APPLICATION`` setting.

Usually you will have the standard Django WSGI application here, but it also
might make sense to replace the whole Django WSGI application with a custom one
that later delegates to the Django one. For example, you could introduce WSGI
middleware here, or combine a Django application with an application of another
framework.

"""
import os, sys
import djcelery

djcelery.setup_loader()

sys.path.append(os.path.normpath(os.path.join(os.path.dirname(__file__), os.path.pardir)))

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "settings.settings")

# This application object is used by any WSGI server configured to use this
# file. This includes Django's development server, if the WSGI_APPLICATION
# setting points here.
from django.core.wsgi import get_wsgi_application

application = get_wsgi_application()

# Apply WSGI middleware here.
# from helloworld.wsgi import HelloWorldApplication
# application = HelloWorldApplication(application)
# and ad hoc hack to enable a consistent connection to Queenbee.

import subprocess
from apps.simfactory.models import Machine

machine_list = Machine.objects.all()
for machine in machine_list:
    if machine.available:
        ssh_cmd = "nohup ssh -TMNf %s@%s > /dev/null 2>&1 </dev/null &" % (machine.account, machine.hostname)
        p=subprocess.Popen(ssh_cmd, cwd="/var/www", shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
