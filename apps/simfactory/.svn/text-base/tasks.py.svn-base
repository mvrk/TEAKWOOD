from celery import task
from celery.task import periodic_task
import subprocess
from datetime import timedelta
from django.shortcuts import get_object_or_404
from settings.settings import MEDIA_ROOT
import logging
from apps.simfactory.models import Job
log = logging.getLogger(__name__)


# args are a list of command plus options
# e.g., ['ls','-l']
# I will use "_t" to indicate a task that will be sent to celery.

@task()
def t_run_script(args):
    process = subprocess.Popen(args,stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    output = process.communicate()[0]
    return output

@task()
def t_job_submit(job_id):
    job = get_object_or_404(Job, pk=job_id)
    job.submit()

@task()
def t_job_checkstatus(job_id):
    job = get_object_or_404(Job, pk=job_id)
    job.get_qstat()

@task()
def t_job_stop(job_id):
    job = get_object_or_404(Job, pk=job_id)
    job.stop()

@periodic_task(run_every=timedelta(minutes=5))
def t_job_checkstatus_periodic():
    jobs = Job.objects.all()
    if jobs:
        for job in jobs:
            job.get_qstat()