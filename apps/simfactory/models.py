from glob import glob
import urllib
import urllib2

from django import dispatch
from django.core.signals import request_finished
from django.dispatch import receiver, dispatcher
from decimal import Decimal
import os
import shutil
import subprocess
from django.db import models
from django.views.generic import ListView
#from telepathy import DoesNotExist
from django.core.exceptions import ObjectDoesNotExist
from apps.simesh.models import SimeshPOI
from apps.workflow.models import Project
from apps.teakwood.models import CommonInfo
from apps.coastalmodels.models import ModelInput, CoastalModel
from settings.settings import MEDIA_ROOT
from utils.system import render_to_file, rsync, symlink_all, scp
from django.core.mail import send_mail

import xml.etree.ElementTree as ET
import logging

log = logging.getLogger(__name__)

JOBCONTROLACTION = [
    ('suspend', 'suspend'),
    ('resume', 'resume'),
    ('hold', 'hold'),
    ('release', 'release'),
    ('terminate', 'terminate')
]


def get_in_seconds(time):
    """
    Takes a string in format HH:MM:SS
    returns the time in seconds
    """

    if time is None:
        return 0

    hours, minutes, seconds = time.split(':')

    # for a month time (about 720 hours) we consider it an error
    if int(hours) > 720:
        raise ValueError

    total = (Decimal(hours) * 60 * 60) + (Decimal(minutes) * 60) + Decimal(seconds)

    return total

#C -  Job is completed after having run/
#E -  Job is exiting after having run.
#H -  Job is held.
#Q -  job is queued, eligible to run or routed.
#R -  job is running.
#T -  job is being moved to new location.
#W -  job is waiting for its execution time
#     (-a option) to be reached.
#S -  (Unicos only) job is suspend.

JOBSTATE = [
    ('A', 'accepted'),
    ('C', 'completed after having run'),
    ('D', 'done, with all files rsynced'),
    ('E', 'exiting after having run'),
    ('H', 'held'),
    ('Q', 'queued, eligible to run or routed'),
    ('R', 'running'),
    ('S', 'suspended'),
    ('T', 'moved to new location'),
    ('U', 'undetermined'),
    ('W', 'waiting for its execution time'),
]

MACHINEOS = [
    ('other_os', 'unknown operating system'),
    ('aix', 'unknown operating system'),
    ('bsd', 'BSD'),
    ('linux', 'Linux'),
    ('hpux', 'HP Unix'),
    ('irix', 'Irix'),
    ('macos', 'Mac OS'),
    ('sunos', 'Oracle/Sun Solaris Unix'),
    ('tru64', 'HP/Compaq True64 Unix'),
    ('unixware', 'SCO UnixWare'),
    ('win', 'Microsoft Windows'),
    ('winnt', 'Microsoft Windows NT')
]

CPU = [
    ('other_cpu', 'unknown CPU'),
    ('alpha', 'Alpha'),
    ('arm', 'ARM'),
    ('arm64', 'ARM 64'),
    ('cell', 'CELL'),
    ('parisc', 'Parisc'),
    ('parisc64', 'Parisc 64'),
    ('x86', 'X86'),
    ('x64', 'X86_64'),
    ('ia64', 'IA64'),
    ('mips', 'MIPS'),
    ('mips64', 'MIPS64'),
    ('ppc', 'PowerPC'),
    ('ppc64', 'PowerPC 64'),
    ('sparc', 'SPAC'),
    ('sparc64', 'SPAC 64'),
]


class Machine(CommonInfo):
    # name = models.CharField(max_length=25, null=False, blank=False, unique=True)
    hostname = models.CharField(max_length=60)
    account = models.CharField(max_length=60)
    #    private_key = models.FileField(upload_to=)
    available = models.BooleanField(default=False)
    sockets = models.PositiveIntegerField("Number of sockets")
    # ppn = corespersocket * sockets
    corespersocket = models.PositiveIntegerField("Cores per socket")
    threadpercore = models.PositiveIntegerField("Threads per core")
    ppn = models.PositiveIntegerField("Processors per core")
    #   set the max number of nodes of the selected queue
    maxnodes = models.PositiveIntegerField("Max number of nodes")
    maxslots = models.PositiveIntegerField("Max number of slots")
    maxwallclocktime = models.PositiveIntegerField("Max wallclock time in hours")
    #    load = models.FloatField(default=0.0)
    physmemory = models.PositiveIntegerField("Physical memory")
    virtmemory = models.PositiveIntegerField("Virtual memory")
    machineos = models.CharField("Machine OS", max_length=10,
                                 default="other_os",
                                 choices=MACHINEOS, )
    machineosversion = models.CharField("Machine OS version", max_length=60)
    machinearch = models.CharField("Machine architecture", max_length=10,
                                   default="other_cpu",
                                   choices=CPU, )
    # teakwood extension (not defined in DRMAA)
    location = models.CharField(max_length=60, null=False, blank=False)
    # description = models.CharField(max_length=60, null=False, blank=False)
    webpage = models.CharField("Web page", max_length=60, null=False, blank=False)
    contact = models.EmailField("Contact Email", max_length=256, null=True, blank=True)

    # job related
    workingdirectory = models.CharField("Working directory", max_length=256)
    #    errorpath = models.CharField("error file path", max_length=256, null=True, blank=True)
    queuename = models.CharField("Queue name", max_length=60, null=True, blank=True)
    accountingid = models.CharField("Accounting ID", max_length=64, null=True, blank=True)

    # now we need to deal with storage
    storageuser = models.CharField("Storage user", max_length=60, null=True, blank=True)
    storagehost = models.CharField("Storage host", max_length=60, null=True, blank=True)
    storagedirectory = models.CharField("Storage directory", max_length=256)
    rsynccmd = models.CharField("Rsync command", max_length=60, null=False, blank=False, default="rsync")
    rsyncoptions = models.CharField("Rsync options", max_length=256, null=False, blank=False,
                                    default="-rLptgoD --delete")
    rsynctostorage = models.BooleanField(default=True)

    # now we need to deal with visualization
    vizuser = models.CharField("Visualization user", max_length=60, null=False, blank=False)
    vizhost = models.CharField("Visualization host", max_length=60, null=False, blank=False)
    vizdirectory = models.CharField("Visualization directory", max_length=256)
    vizscript = models.CharField("Visualization script", max_length=60, null=False, blank=False)
    rsynctoviz = models.BooleanField(default=False)


    def get_fields(self):
        return [(field.verbose_name, field._get_val_from_obj(self))
                for field in self.__class__._meta.fields]

    def __unicode__(self):
        return self.name

        # class Agent(CommonInfo):
        # machine = models.ForeignKey(Machine)
        # slots = models.PositiveIntegerField("Number of CPUs")
        # queuename = models.CharField("queue name", max_length=64)
        # wallclocktime = models.PositiveIntegerField("Wall Clock Time (Hours)")
        # wallclocktimestring = models.CharField(max_length=12, null=True, blank=True)
        # email = models.EmailField(max_length=256, null=True, blank=True)
        # emailonstarted = models.BooleanField("send email on started", default=True)
        # emailonterminated = models.BooleanField("send email on terminated", default=True)
        #
        # #    submissiontime = models.DateTimeField("submission time", null=True, blank=True)
        # dispatchtime = models.DateTimeField("dispatch time", null=True, blank=True)
        # finishtime = models.DateTimeField("finish time", null=True, blank=True)
        #
        # accountingid = models.CharField("account ID", max_length=64, null=True, blank=True)
        # # teakwood extension (not defined in DRMAA)
        # local_dir = models.CharField("local job directory", max_length=256, null=True, blank=True)
        # remote_dir = models.CharField("remote job directory", max_length=256, null=True, blank=True)
        # script_template = models.ForeignKey(ScriptTemplate, null=True, blank=True)
        # script_name = models.CharField("name of the job submission script", max_length=64, null=True, blank=True)
        # qstat_xml = models.TextField(null=True, blank=True)
        # progress = models.PositiveSmallIntegerField(default=0)
        # submit_now = models.BooleanField("submit now", default=True)
        # stdout = models.TextField(null=True, blank=True)
        # stderr = models.TextField(null=True, blank=True)
        #
        # #    data_ready = models.BooleanField("data ready", default=False)
        #
        # # def send_data(self):
        # #     data_ready = dispatch.Signal()
        # #     data_ready.send(sender=self)
        #
        # def my_callback(sender, **kwargs):
        #     print("data is ready to send !")

        # def mkdir(self):
        #     """
        #     mkdir must be called right before job is submitted to ensure all the files from the modelinput are copied over.
        #     """
        #     try:
        #         # the input will be copied from the modelinput dir
        #         local_dir = os.path.normpath("%s/%s" % (MEDIA_ROOT, self.local_dir))
        #
        #         # old local_dir will always be removed if there is an existing one.
        #         if os.path.exists(local_dir): shutil.rmtree(local_dir)
        #
        #         # we will copy the modelinput dir to be the new local job dir.
        #         # shutil.copytree(os.path.normpath("%s/%s" % (MEDIA_ROOT, self.model_input.input_dir)), local_dir)
        #
        #     except OSError:
        #         self.delete()
        #         raise
        #
        #     return unicode(self.jobstate)


# class SoftEnv(models.Model):


class ScriptTemplate(models.Model):
    """
    connect model to machines. model specific settings shall go here
    """
    model = models.ForeignKey(CoastalModel, null=True, blank=True)
    machine = models.ForeignKey(Machine, null=True, blank=True)
    preprocessor = models.TextField(null=True, blank=True)
    postprocessor = models.TextField(null=True, blank=True)
    cmd_line = models.TextField(null=True, blank=True)
    native_script = models.TextField(null=True, blank=True)
    viz_script = models.TextField(null=True, blank=True)

    # TODO this is a quick hack. This should be reorganized.
    viz_scriptname = models.CharField("viz script name", max_length=64, null=True, blank=True)
    data_file = models.CharField("file to be processed", max_length=64, null=True, blank=True)

    class Meta:
        unique_together = ('model', 'machine',)

    def __unicode__(self):
        return "%s_%s_Scripts" % (self.model.name, self.machine.name)

# merged Job and Job Template from DRMAA with slight modifications

class Job(CommonInfo):
    jobid = models.CharField("job ID", max_length=64, null=True, blank=True)
    project = models.ForeignKey(Project, related_name='jobs')
    #    group = models.ForeignKey(Group, null=True, blank=True, help_text="(Select a group to share this job)")
    #    name = models.CharField("job name", max_length=64, null=False, blank=False)
    model_input = models.ForeignKey(ModelInput, related_name='jobs')
    exitstatus = models.PositiveIntegerField("job exit status", null=True, blank=True)
    annotation = models.CharField("job annotation", max_length=64, null=True, blank=True)
    jobstate = models.CharField("job state", max_length=1,
                                default='U',
                                choices=JOBSTATE, null=True, blank=True)
    jobsubstate = models.CharField("job submission state", max_length=64, null=True, blank=True)

    # given a machine we know:

    machine = models.ForeignKey(Machine)

    # calculate from slots and machine.ppn (nodes = (slots-1)/ppn + 1)
    nodes = models.PositiveIntegerField()
    #    user = models.ForeignKey(User)
    slots = models.PositiveIntegerField("Number of CPUs")
    queuename = models.CharField("queue name", max_length=64)
    wallclocktime = models.PositiveIntegerField("Wall Clock Time (Hours)")
    wallclocktimestring = models.CharField(max_length=12, null=True, blank=True)
    email = models.EmailField(max_length=256, null=True, blank=True)
    emailonstarted = models.BooleanField("send email on started", default=True)
    emailonterminated = models.BooleanField("send email on terminated", default=True)

    #    submissiontime = models.DateTimeField("submission time", null=True, blank=True)
    dispatchtime = models.DateTimeField("dispatch time", null=True, blank=True)
    finishtime = models.DateTimeField("finish time", null=True, blank=True)

    accountingid = models.CharField("account ID", max_length=64, null=True, blank=True)
    # teakwood extension (not defined in DRMAA)
    local_dir = models.CharField("local job directory", max_length=256, null=True, blank=True)
    remote_dir = models.CharField("remote job directory", max_length=256, null=True, blank=True)
    script_template = models.ForeignKey(ScriptTemplate, null=True, blank=True)
    script_name = models.CharField("name of the job submission script", max_length=64, null=True, blank=True)
    qstat_xml = models.TextField(null=True, blank=True)
    progress = models.PositiveSmallIntegerField(default=0)
    submit_now = models.BooleanField("submit now", default=True)
    stdout = models.TextField(null=True, blank=True)
    stderr = models.TextField(null=True, blank=True)

    def __unicode__(self):
        return unicode(self.name)

    def get_fields(self):
        return [(field.verbose_name, field._get_val_from_obj(self))
                for field in self.__class__._meta.fields]

    #    data_ready = models.BooleanField("data ready", default=False)

    # def send_data(self):
    #     data_ready = dispatch.Signal()
    #     data_ready.send(sender=self)


    def send_metadata(self):
        url = 'http://ngchc.org/metadata/ingest.php'
        params = urllib.urlencode({
            'name': self.name,
            'description': self.description or self.name,
            'contact': self.user.email,
            'url': 'http://localhost:8000:8080/%s/' % self.name,
            'date': self.time_created.date(),
            'keyword': 'teakwood %s %s %s' % (self.model_input.model, self.model_input.name, self.name)
        })
        response = urllib2.urlopen(url, params).read()
        log.info(response)

    def my_callback(sender, **kwargs):
        print("data is ready to send !")

    # def mkdir(self):
    #     """
    #     mkdir must be called right before job is submitted to ensure all the files from the modelinput are copied over.
    #     """
    #     try:
    #         # the input will be copied from the modelinput dir
    #         local_dir = os.path.normpath("%s/%s" % (MEDIA_ROOT, self.local_dir))
    #
    #         # old local_dir will always be removed if there is an existing one.
    #         if os.path.exists(local_dir): shutil.rmtree(local_dir)
    #
    #         # we will copy the modelinput dir to be the new local job dir.
    #         # shutil.copytree(os.path.normpath("%s/%s" % (MEDIA_ROOT, self.model_input.input_dir)), local_dir)
    #
    #     except OSError:
    #         self.delete()
    #         raise
    #
    #     return unicode(self.jobstate)

# symlink all model data recursively.

    def symlink_modeldata(self):
        try:
            src_dir = os.path.normpath("%s/%s" % (MEDIA_ROOT, self.model_input.input_dir))
            dst_dir = os.path.normpath("%s/%s" % (MEDIA_ROOT, self.local_dir))
            symlink_all(src_dir, dst_dir)

            prior_model = self.model_input.prior_model

            while prior_model:
                src_dir = os.path.normpath(
                    "%s/%s" % (MEDIA_ROOT, prior_model.input_dir))
                symlink_all(src_dir, dst_dir)
                prior_model = prior_model.prior_model

        except OSError:
            self.delete()
            raise


            #TODO this is Delft3D specific. need to generalize
    def prepare_inputdata(self):
        teakwood_poi = os.path.normpath("%s/%s/teakwood.poi" % (MEDIA_ROOT, self.local_dir))
        teakwood_obs = os.path.normpath("%s/%s/teakwood.obs" % (MEDIA_ROOT, self.local_dir))

        grd_file = glob(os.path.normpath("%s/%s/*.grd" % (MEDIA_ROOT, self.local_dir)))
        if len(grd_file) == 0:
            log.warn("there are no grid files available")
        elif len(grd_file) > 1:
            log.warn("there are more than one grid files")
        else:
            if self.model_input.poi_type == 'file':
                if os.path.exists(teakwood_poi):
                    poi = SimeshPOI(grd_file=grd_file[0], poi_file=teakwood_poi, obs_file=teakwood_obs)
                    poi.delft3d_obs_file()
                else:
                    log.warning("User %s set POI type to file by didn't upload teakwood.poi." % self.user.username)

                    # def poi_from_domain_id(self, domain_id=None):
                    #     try:
                    #         domain = Domain.objects.get(pk=domain_id)
                    #
                    #     except:
                    #         print "failed to initialized POI with the given domain id"
                    #         raise


                    # we only rsync teakwood.out and teakwood.err back to the web server.

    def scp_to_server(self):
        try:
            # src_dir = "%s@%s:%s" % (self.machine.account, self.machine.hostname,
            #                         os.path.normpath(
            #                             "%s/%s/teakwood.out" % (self.machine.workingdirectory, self.name)))
            server = os.path.normpath("%s/%s" % (MEDIA_ROOT, self.local_dir))
            # rsync(src_dir, rsync_to_dest, block=True)

            # scp to the web server
            src_dir = "%s@%s:%s" % (self.machine.account, self.machine.hostname,
                                    os.path.normpath(
                                        "%s/%s/teakwood.*" % (self.machine.workingdirectory, self.name)))
            scp(src_dir, server, block=True)

            # rsync to the storage to serve the file

            # if self.machine.rsynctostorage:
            #     if self.machine.storageuser and self.machine.storagehost and self.machine.storagedirectory:
            #     # this is only for the sake of development.
            #         ssh_cmd = None
            #
            #         src = os.path.normpath("%s/teakwood.*" % server)
            #
            #         rsync_to_dest = "%s@%s:%s/%s" % (
            #             self.machine.storageuser, self.machine.storagehost, self.machine.storagedirectory, self.name)
            #
            #         rsync(src, rsync_to_dest, ssh_cmd=ssh_cmd, rsync_cmd='rsync',
            #               rsync_options=self.machine.rsyncoptions, block=True)
            #
            #         if self.group.name == 'teakwood':
            #             self.send_metadata()
            #     else:
            #         log.error("rsync to storage failed ! storage system settings are not complete.")
            # else:
            #     log.warn("teakwood won't be able to serve files without a storage system running")
            # if we have a vizscript we will try to rsync data back and visualize
            if self.script_template.viz_scriptname and self.script_template.data_file:
                src_dir = "%s@%s:%s" % (self.machine.account, self.machine.hostname,
                                        os.path.normpath("%s/%s/%s*" % (
                                            self.machine.workingdirectory, self.name, self.script_template.data_file)))
                scp(src_dir, server, block=True)
        except:
            pass

    def rsync_to_compute(self):
        input_dir = os.path.normpath("%s/%s" % (MEDIA_ROOT, self.local_dir))
        rsync_to_dest = "%s@%s:%s" % (self.machine.account, self.machine.hostname, self.machine.workingdirectory)
        rsync(input_dir, rsync_to_dest, block=True)

    # If this is on localhost, I will rsync to localhost first then rsync to data server to avoid
    # doing remote to remote synchronization. Otherwise, I will rsync directly to the data server
    # If you are a developer, I hope you are not dealing with big files when testing with localhost.

    def rsync_to_storage(self):
        if self.machine.rsynctostorage:
            if self.machine.storageuser and self.machine.storagehost and self.machine.storagedirectory:
            # this is only for the sake of development.
                if self.machine.hostname == "localhost.localdomain":
                    ssh_cmd = None
                else:
                    ssh_cmd = "ssh %s@%s" % (self.machine.account, self.machine.hostname)

                src = os.path.normpath("%s/%s" % (self.machine.workingdirectory, self.name))

                rsync_to_dest = "%s@%s:%s" % (
                    self.machine.storageuser, self.machine.storagehost, self.machine.storagedirectory)

                rsync(src, rsync_to_dest, ssh_cmd=ssh_cmd, rsync_cmd=self.machine.rsynccmd,
                      rsync_options=self.machine.rsyncoptions, block=False)
                if self.group.name == 'teakwood':
                    self.send_metadata()
            else:
                log.error("rsync to storage failed ! storage system settings are not complete.")
        else:
            log.warn("teakwood won't be able to serve files without a storage system running")

    def visualize_output(self):
        try:
        # assume if someone put it there then he/she knows what he/she is doing
        # the viz_script shall be able to take the job output dir as the only input
        # argument and dump data to
            cwd = os.path.normpath("%s/%s" % (MEDIA_ROOT, self.local_dir))

            if self.script_template.viz_scriptname and self.script_template.data_file:
                for f in glob(
                        os.path.normpath("%s/%s/%s" % (MEDIA_ROOT, self.local_dir, self.script_template.data_file))):
                    viz_cmd = "%s %s %s" % ('sh', self.script_template.viz_scriptname, f)
                    log.info(viz_cmd)

                    p = subprocess.Popen(viz_cmd,
                                         cwd=cwd,
                                         shell=True,
                                         stdout=subprocess.PIPE,
                                         stderr=subprocess.PIPE)

                    output = p.communicate()
                    if output[1]:
                        log.error(output[1])
        except:
            raise

    # If this is on localhost, I will rsync to localhost first then rsync to data server to avoid
    # doing remote to remote synchronization. Otherwise, I will rsync directly to the data server
    # If you are a developer, I hope you are not dealing with big files when testing with localhost.

    def create_pbsscript(self):
        """
        the script will be created under the local job dir.
        """
        script = "%s/%s" % (os.path.normpath("%s/%s" % (MEDIA_ROOT, self.local_dir)), self.script_name)
        log.debug(script)
        try:
            render_to_file(script, 'simfactory/pbs_jobscript_template.html', {"job": self})
        except Exception:
            raise

    def create_vizscript(self):
        """
        the script will be created under the local job dir.
        """
        script = "%s/%s" % (os.path.normpath("%s/%s" % (MEDIA_ROOT, self.local_dir)),
                            self.script_template.viz_scriptname)
        log.debug(script)
        try:
            render_to_file(script, 'simfactory/vizscript_template.html', {"job": self})
        except Exception:
            raise

    def get_qstat(self):
        # try:
        #     self.visualize_output()
        #
        # except:
        #     pass

        if self.jobstate == 'C':
            self.jobstate = 'D'
            # this makes the comparison easier
            self.qstat_xml = None
            self.save()
            self.rsync_to_storage()
            # send_mail('Subject here', 'Here is the message.', 'teakwood@localhost:8000', ['guojiarui@gmail.com'], fail_silently=False)
            if (self.machine.hostname != 'localhost.localdomain'):
                send_mail(self.name,
                          "Job %s has finished and the data can be viewed at http://localhost:8000:8080/%s" % (
                              self.name, self.name),
                          'teakwood@localhost:8000', [self.user.email, ], fail_silently=False)

            if self.machine.vizhost and self.machine.vizscript:
                pass
            return

            # We check the job status only when job is not done.
        if self.jobstate != 'D':
            if self.jobid:
                local_dir = os.path.normpath("%s/%s" % (MEDIA_ROOT, self.local_dir))
                qstat_cmd = "ssh %s@%s qstat -x %s" % (self.machine.account, self.machine.hostname, self.jobid)
                log.info(qstat_cmd)

                try:
                    p = subprocess.Popen(qstat_cmd, cwd=local_dir, shell=True, stdout=subprocess.PIPE,
                                         stderr=subprocess.PIPE)
                    output = p.communicate()
                    if output[1]:
                        log.error(output[1])
                        # we don't want to remove the last updated record in case the server doesn't have the updated record.
                    self.qstat_xml = output[0]

                except Exception:
                    raise

                if self.qstat_xml:
                    try:
                        tree = ET.fromstring(self.qstat_xml)
                        for job in tree.findall('Job'):
                            if (job.find("Job_Name").text == self.name):
                                self.jobstate = job.find("job_state").text
                                resources = job.find("resources_used")
                                if resources is not None:
                                    time_used = resources.find("walltime").text
                                    self.progress = int(get_in_seconds(time_used) / get_in_seconds(
                                        self.wallclocktimestring) * 100)

                    except Exception:
                        raise
                else:
                    if self.jobstate != 'C':
                        self.jobstate = 'C'
                        self.jobid = None

        else:
            self.jobid = None

        # if a job doesn't have a jobid from qsub and it doesn't have qstat_xml entry.
        # we will mark it unknown..
        # copy back the teakwood.out|err from the compute machine and display.
        if self.jobstate in 'RC':
            self.scp_to_server()
        try:
            stdout = open(os.path.normpath("%s/%s/teakwood.out" % (MEDIA_ROOT, self.local_dir)), 'r')
            if stdout:
                stdout = (stdout.readlines())[-300:]
                self.stdout = ''.join(stdout)

            stderr = open(os.path.normpath("%s/%s/teakwood.err" % (MEDIA_ROOT, self.local_dir)), 'r')
            if stderr:
                stderr = (stderr.readlines())[-300:]
                self.stderr = ''.join(stderr)

        except IOError:
            log.warn("teakwood.out and teakwood.err are not ready yet.")

        self.save()

        return unicode(self.jobstate)

    def submit(self):

        self.symlink_modeldata()

        #TODO coastal model specific
        self.prepare_inputdata()

        self.create_pbsscript()

        self.rsync_to_compute()
        local_dir = os.path.normpath("%s/%s" % (MEDIA_ROOT, self.local_dir))
        qsub_cmd = "ssh %s@%s qsub %s/%s" % (
            self.machine.account, self.machine.hostname, self.remote_dir, self.script_name)
        log.info(qsub_cmd)

        try:
            p = subprocess.Popen(qsub_cmd, cwd=local_dir, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            output = p.communicate()
            if output[1]:
                log.error(output[1])
            if output[0]:
                self.jobid = output[0].split('.')[0]

        except Exception:
            raise
        self.progress = 0
        self.save()
        self.get_qstat()

        return unicode(self.jobsubstate)

    # def hold(self):
    #     """ hold a job
    #     """
    #     return unicode(self.jobsubstate)
    #
    # def resume(self):
    #     """ restart a held job
    #     """
    #     return unicode(self.jobsubstate)

    def stop(self):
        local_dir = os.path.normpath("%s/%s" % (MEDIA_ROOT, self.local_dir))
        qdel_cmd = "ssh %s@%s qdel %s" % (self.machine.account, self.machine.hostname, self.jobid)
        log.info(qdel_cmd)
        p = subprocess.Popen(qdel_cmd, cwd=local_dir, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        output = p.communicate()
        if output[1]:
            log.error(output[1])

        self.get_qstat()
        return unicode(self.jobsubstate)

# model for ListViewing project
class MachineList(ListView):
    model = Machine

    def get_queryset(self):
        return Machine.objects.all()