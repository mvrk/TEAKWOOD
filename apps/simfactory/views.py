from datetime import datetime
import os
from django.core import serializers
from django.http import HttpResponseNotFound, HttpResponse
from django.shortcuts import render_to_response, redirect, get_object_or_404
from django.template import RequestContext
from django.contrib.auth.decorators import login_required, permission_required

from apps.coastalmodels.models import ModelInput
from apps.simfactory.forms import JobForm
from apps.simfactory.models import Job, ScriptTemplate
from django.core.urlresolvers import reverse
#from subprocess import Popen
#import subprocess
#from settings.settings import MEDIA_ROOT
#from dateutil import parser
#import os
from django.db.models import Q
from apps.simfactory.tasks import t_job_submit, t_job_checkstatus, t_job_stop
#from apps.workflow.models import Project
#from settings.settings import MEDIA_ROOT
#from utils.system import mkdir_p
import logging
from settings.settings import MEDIA_ROOT
from utils.system import exportfile

log = logging.getLogger(__name__)


# add the permission control later.
# @permission_required('job.can_add', raise_exception=True)
@login_required
def job_add(request, project_id=None):

    if project_id:
        model_inputs = ModelInput.objects.filter(Q(project__exact=project_id),
                                                 Q(user__exact=request.user) | Q(group__in=request.user.groups.all()))
        if model_inputs:
            form = JobForm(request.user, project_id, request.POST or None, initial={'model_input': model_inputs[0],
                                                                                    'slots': 1, 'wallclocktime': 1})
        else:
        # for illegal request we simple ignore. this shall never be called.
            return redirect(reverse("workflow_projectlist"))

            # initialize the select field with the available machine with the biggest socket number
            #    machines = Machine.objects.filter(available__exact=True).order_by('-sockets')
    else:
        form = JobForm(request.user, project_id, request.POST or None, initial={'slots': 1, 'wallclocktime': 1})

    if form.is_valid():
        pmodel = form.save(commit=False)
        pmodel.project = pmodel.model_input.project
        # hyperthreading is considered here by letting each hyper thread take care one MPI process.
        ppn = pmodel.machine.corespersocket * pmodel.machine.sockets * pmodel.machine.threadpercore
        pmodel.nodes = (pmodel.slots - 1 ) / ppn + 1
        #add extra attributes that users shall not add
        pmodel.user = request.user
        pmodel.group = pmodel.project.group
        pmodel.time_created = datetime.now()
        pmodel.last_modified = datetime.now()
        pmodel.wallclocktimestring = "%d:00:00" % pmodel.wallclocktime
        pmodel.email = request.user.email
        pmodel.queuename = pmodel.machine.queuename
        pmodel.accountingid = pmodel.machine.accountingid
        pmodel.save()
        pmodel.name = "%s_J%d" % (pmodel.model_input.name, pmodel.id)
        pmodel.name = pmodel.name.upper()
        pmodel.script_name = "simulocean.pbs"
        pmodel.local_dir = "%s/%s" % (os.path.dirname(pmodel.model_input.input_dir), pmodel.name)
        pmodel.remote_dir = "%s/%s" % (pmodel.machine.workingdirectory, pmodel.name)
        pmodel.script_template = ScriptTemplate.objects.get(model=pmodel.model_input.model, machine=pmodel.machine)
        pmodel.save()

        if pmodel.submit_now:
            job_submit(request, pmodel.id)
        if project_id:
            return redirect(reverse("workflow_projectlist"))
        else:
            return redirect(reverse("simfactory_joblist"))

    return render_to_response('simfactory/job_add.html', {'form': form},
                              context_instance=RequestContext(request))


@login_required
def job_list(request):
    # before we show the job_list we update the job.status and job.progress
    object_list = Job.objects.filter(
        Q(user=request.user) |
        Q(group__in=request.user.groups.all())).order_by("-id")

    #    if object_list:
    #        for object in object_list:
    #            object.get_qstat()

    return render_to_response('simfactory/job_list.html',
                              {'object_list': object_list or None},
                              context_instance=RequestContext(request))


@login_required
def job_view(request, job_id):
#    job_progress(job_id)
    job = get_object_or_404(Job, pk=job_id)

    if request.user == job.user or request.user.groups.filter(name=job.group):
        return render_to_response('simfactory/job_detail.html',
                                  {'object': job},
                                  context_instance=RequestContext(request))
    else:
        return redirect(reverse("simfactory_joblist"))

@login_required
def job_exportxml(request):
    return job_export(request,'xml')

@login_required
def job_exportjson(request):
    return job_export(request,'json')

def job_export(request, output_format):
    if output_format not in ["xml", "json"]:
        return HttpResponseNotFound

    jl = Job.objects.filter(Q(user=request.user) | Q(group__in=request.user.groups.all()))
    output = serializers.serialize(output_format, jl, indent=4, use_natural_keys=True)

    # sticks in a POST or renders empty form
    response = HttpResponse(output, mimetype='text/txt')
    response["Content-Disposition"] = "attachment; filename= simulocean_job.%s" % output_format
    return response

@login_required
def job_exportstdout(request, job_id):
    job = get_object_or_404(Job, pk=job_id)
    stdout_file = os.path.normpath("%s/%s/simulocean.out" % (MEDIA_ROOT, job.local_dir))
    return exportfile(fin_name=stdout_file, fout_name="simulocean.out", content_type='text/plain')

@login_required
def job_exportstderr(request, job_id):
    job = get_object_or_404(Job, pk=job_id)
    stderr_file = os.path.normpath("%s/%s/simulocean.err" % (MEDIA_ROOT, job.local_dir))
    return exportfile(fin_name=stderr_file, fout_name="simulocean.err", content_type='text/plain')

#@login_required
#def job_edit(request, job_id):
#    # sticks in a POST or renders empty form
#    job = get_object_or_404(Job, pk=job_id)
#
#    if request.user != job.user:
#        return redirect(reverse("simfactory_joblist"))
#
#    form = JobForm(request.user, request.POST or None, instance=job)
#
#    if form.is_valid():
#        pmodel = form.save(commit=False)
#        #        ppn = pmodel.machine.corespersocket * pmodel.machine.sockets
#        pmodel.nodes = (pmodel.slots - 1 ) / pmodel.machine.ppn + 1
#        pmodel.jobstate = "undetermined"
#        #add extra attributes that users shall not add
#        pmodel.last_modified = datetime.now()
#        pmodel.wallclocktimestring = "%d:00:00" % pmodel.wallclocktime
#        pmodel.queuename = pmodel.machine.queuename
#        pmodel.accountingid = pmodel.machine.accountingid
#        pmodel.name = "%s_job_%05d" % (pmodel.project.name, pmodel.id)
#        pmodel.save()
#
#        # for illegal request we simple ignore.
#        return redirect(reverse("simfactory_joblist"))
#
#    else:
#        return render_to_response('simfactory/job_edit.html',
#            {'job_form': form, 'job_id': job_id},
#            context_instance=RequestContext(request))


@login_required
def job_delete(request, job_id, render=True):
    job = get_object_or_404(Job, pk=job_id)

    if request.user == job.user:
        job_stop(request, job_id, render=False)
        job.delete()

    if render:
        return redirect(reverse("simfactory_joblist"))


@login_required
def job_deleteall(request):
    jobs = Job.objects.filter(user=request.user)
    for job in jobs:
        job_delete(request, job.id, render=False)
    return redirect(reverse("simfactory_joblist"))


@login_required
def job_checkstatus(request, job_id, render=True):
    job = get_object_or_404(Job, pk=job_id)
    if job.user == request.user:
        t_job_checkstatus.delay(job.id)
        # force the refresh of the last modified field
        job.save()

    if render:
        return redirect(reverse("simfactory_jobview", args=[job.id]))


@login_required
def job_checkstatusall(request):
    jobs = Job.objects.filter(
        Q(user=request.user) |
        Q(group__in=request.user.groups.all())).order_by("-id")

    if jobs:
        for job in jobs:
            job_checkstatus(request, job.id, render=False)

    return redirect(reverse("simfactory_joblist"))


@login_required
def job_submit(request, job_id, render=True):
    job = get_object_or_404(Job, pk=job_id)
    if request.user == job.user and job.jobstate not in 'ARQ':
        t_job_submit.delay(job.id)
        job.jobstate = 'A'
        job.save()
    if render:
        return redirect(reverse("simfactory_joblist"))

@login_required
def job_submitall(request):
    jobs = Job.objects.filter(user=request.user)
    if jobs:
        for job in jobs:
            if job.jobstate not in 'ARQ':
                job_submit(request, job.id, render=False)
    return redirect(reverse("simfactory_joblist"))

# accepted job (jobstate=A) will start the data transferring procedure
# we don't want to stop them until the data transfer finishes.
@login_required
def job_stop(request, job_id, render=True):
    job = get_object_or_404(Job, pk=job_id)
    if request.user == job.user and job.jobstate in 'RQ':
    #        job_stop(request, job_id)
        t_job_stop.delay(job.id)
    if render:
        return redirect(reverse("simfactory_joblist"))


@login_required
def job_stopall(request):
    jobs = Job.objects.filter(user=request.user)
    for job in jobs:
        if job.jobstate in 'RQ':
            job_stop(request, job.id, render=False)
    return redirect(reverse("simfactory_joblist"))


@login_required
def job_hold(request, job_id):
    return redirect(reverse("simfactory_joblist"))


@login_required
def job_holdall(request):
    return redirect(reverse("simfactory_joblist"))

@login_required
def job_exportpbs(request, job_id):
    job = get_object_or_404(Job, pk=job_id)
    response = render_to_response("simfactory/pbs_jobscript_template.html",
                                  {'job': job}, context_instance=RequestContext(request), mimetype='text/txt')
    response["Content-Disposition"] = "attachment; filename= %s.pbs" % job.name
    return response

#def job_exportpbs(job_id):
#    pbsscript_dict = pbsscript_modeltodict(job_id)
#    swaninput = SWANInput.objects.get(pk=swaninput_id)
#    # we save this
#    swaninputdir = os.path.abspath("%s/users/%s/model_input/%s" % (MEDIA_ROOT, swaninput.user.id, swaninput.id))
#    mkdir_p(swaninputdir)
#
#    swaninput_file = os.path.abspath('%s/INPUT' % swaninputdir)
#    print swaninput_file
#
#    if os.path.exists(swaninput_file):
#        os.remove(swaninput_file)
#
#    f = open(swaninput_file, 'w')
#
#    for name, value in swaninputdict.items():
#        f.write("%s %s\n" % (name, value))
#    f.write('stop')
#    f.close()

#
#@login_required
#def job_run(request, job_id):
#    trash = file(os.devnull, 'a')
#
#    job = get_object_or_404(Job, pk=job_id)
#    #    cmd_line = 'cd /home/alex/Development/Simulocean/media/models/swan/exe; ./swan_ser'
#    #    cwd = os.path.dirname(job.exe_file)
#
#
#    # this is the system dependent path that we will use for internal purpose.
#    cwd = os.path.abspath("%s/%s" % (MEDIA_ROOT, job.cwd))
#    job_exe_file = os.path.abspath('%s/%s' % (MEDIA_ROOT, job.exe_file))
#
#    #    subprocess.call('ln -s %s %s' % (model_exe_file, job_exe_file), shell=True)
#
#    # we will always call the default input files, demo files.
#    # currently we will only run the demo input. We will enable user upload later.
#
#    # the following two lines are for testing only. Will remove when the workflow is up.
#    model_input_dir = os.path.abspath(
#        MEDIA_ROOT + os.path.dirname(os.path.dirname(job.project.model.exe_file)) + '/demo')
#
#    # remove output,errfile and norm_end so that we could correctly check the job status later
#    output = os.path.abspath("%s/%s/OUTPUT" % (MEDIA_ROOT, job.cwd))
#    printfile = os.path.abspath("%s/%s/PRINT" % (MEDIA_ROOT, job.cwd))
#    errfile = os.path.abspath("%s/%s/Errfile" % (MEDIA_ROOT, job.cwd))
#    normend = os.path.abspath("%s/%s/norm_end" % (MEDIA_ROOT, job.cwd))
#
#    subprocess.call('rm -f %s* %s* %s* %s' % (output, errfile, printfile, normend), shell=True)
#    subprocess.call('cp -f %s/* %s' % (model_input_dir, cwd), shell=True)
#
#    cmd_line = "mpirun -np %d %s > %s/OUTPUT" % (job.num_proc, job_exe_file, cwd)
#    p = Popen(cmd_line, shell=True, stdout=trash, stderr=trash, cwd=cwd)
#    #    p = Popen(cmd_line, stderr=trash, stdout=trash,
#    #        shell=False, cwd=cwd)
#    #    output = p.communicate()
#    #    print output
#    job.pid = p.pid
#
#    #running
#    job.status = 1
#    job.start_time = datetime.now()
#    job.end_time = None
#    job.save()
#    # we shall create a file indicating the status similar to
#    # /proc/pid/status a job manager will check /proc/pid/status
#
#    # we need to run a job manager as well
#    return redirect(reverse("simfactory_joblist"))
#
#
#@login_required
#def job_stop(request, job_id):
#    job = get_object_or_404(Job, pk=job_id)
#
#    if request.user == job.user and job.pid is not None:
#        trash = file(os.devnull, 'a')
#        Popen('pkill -TERM -P %d 2>/dev/null' % job.pid,
#            stderr=trash, stdout=trash, shell=True)
#    job.pid = None
#    # stopped
#    job.status = 2
#    job.end_time = datetime.now()
#    job.save()
#    return redirect(reverse("simfactory_joblist"))
#
#    # success  : 0
#    # running  : 1
#    # stopped  : 2
#    # hang     : 3
#    # fail     : 4
#    # export   : 5
#
##@login_required
#def job_progress(job_id):
#    job = get_object_or_404(Job, pk=job_id)
#    output = os.path.abspath("%s/%s/OUTPUT" % (MEDIA_ROOT, job.cwd))
#    errfile = os.path.abspath("%s/%s/Errfile*" % (MEDIA_ROOT, job.cwd))
#    normend = os.path.abspath("%s/%s/norm_end" % (MEDIA_ROOT, job.cwd))
#    #    tgzfile = os.path.abspath("%s/%s/simfactory_job_archive_%s.tar.gz" % (MEDIA_ROOT, job.cwd, job.id))
#    if job.status != 2 and (glob.glob(errfile) or not glob.glob(output)):
#        job.status = 4
#        job.log = "Error to launch the run"
#        job.end_time = datetime.now()
#    else:
#        if os.path.exists(normend):
#            job.status = 0
#            job.end_time = datetime.now()
#        try:
#            cmd_line = "awk '/^\+time/  {if (NF>2) print $0}' %s" % output
#
#            p = subprocess.Popen(cmd_line, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
#            job.log = p.communicate()[0]
#
#        except Exception as e:
#            print e
#
#            # now the fun part starts
#            #    output_st =
#
#    mi_st = job.model_input.swan_input.time_start.replace('.', '-')
#    mi_et = job.model_input.swan_input.time_end.replace('.', '-')
#    mi_st = parser.parse(mi_st)
#    mi_et = parser.parse(mi_et)
#    mi_delta = mi_et - mi_st
#    # now let's get the simulation time
#    if job.log:
#        lines = job.log.split('\n')
#        if len(lines) > 2:
#            print lines[len(lines) - 2]
#            output_time = parser.parse(lines[len(lines) - 2].split()[1].replace('.', '-'))
#            output_delta = output_time - mi_st
#            print  output_delta.total_seconds(), mi_delta.total_seconds()
#            job.progress = int(100 * ( output_delta.total_seconds() / mi_delta.total_seconds()))
#
#    if job.status == 0 and job.progress == 100:
#        job_createtarball(job.id)
#        #        job_data2db(job.id)
#        job.status = 5
#
#    job.save()
#
#
#def job_export(request, job_id):
#    # we save this
#    job = get_object_or_404(Job, pk=job_id)
#    cwd = os.path.abspath("%s/%s" % (MEDIA_ROOT, job.cwd))
#    if job.status == 5:
#        tgzfile = "%s/simfactory_job_archive_%s.tar.gz" % (cwd, job.id)
#        while not os.path.exists(tgzfile):
#            sleep(1)
#        response = HttpResponse(FileWrapper(file(tgzfile)), content_type='application/x-tgz')
#        response['Content-Disposition'] = 'attachment; filename=simfactory_job_archive_%s.tar.gz' % job.id
#        return response
#    else:
#        return redirect(reverse("simfactory_joblist"))
#
#
#def job_createtarball(job_id):
#    job = get_object_or_404(Job, pk=job_id)
#    cwd = os.path.abspath("%s/%s" % (MEDIA_ROOT, job.cwd))
#
#    trash = file(os.devnull, 'a')
#
#    # goes to the project dir and create a file called simfactory_jobarchive_1.tar.gz
#    # to archive the job with job_id = 1.
#    cmd_line = 'rm -f %s/simfactory_job_archive_%s.tar.gz; cd %s/..; tar -hzcf simfactory_job_archive_%s.tar.gz %s; mv simfactory_job_archive_%s.tar.gz %s' % (
#        cwd, job_id, cwd, job.id, job.id, job_id, cwd)
#    print cmd_line
#    subprocess.Popen(cmd_line, shell=True, stdout=trash, stderr=trash, cwd=cwd)
