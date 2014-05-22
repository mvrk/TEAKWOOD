from django.db.models import Q
from django.shortcuts import render_to_response, redirect, get_object_or_404
from django.template import RequestContext
from django.contrib.auth.decorators import login_required
from apps.workflow.forms import ProjectForm
from apps.workflow.models import Project
from django.core.urlresolvers import reverse
from django.core import serializers
import os

from django.http import HttpResponse, HttpResponseNotFound

# We should change login_required to permission_required r all the functions here.
# we create dir for the project when a user create a new one.
# MEDIA_ROOT/user_id/project_id

@login_required
def project_add(request):
    # sticks in a POST or renders empty form
    form = ProjectForm(request.user, request.POST or None)
    if form.is_valid():
        pmodel = form.save(commit=False)
        pmodel.user = request.user
        # pmodel.time_created = datetime.now()
        # pmodel.last_modified = datetime.now()
        pmodel = form.save(commit=True)
        pmodel.name = '-'.join(pmodel.name.split())
        # this will be stored in the database and show to user.
        cwd = os.path.normpath("users/U%d/P%d" % (pmodel.user.pk, pmodel.pk))
        pmodel.cwd = cwd

# create a dir for report
        pmodel.mkdir()
        # pmodel.descriptor = request.FILES['descriptor']
        pmodel.save()

        return redirect(reverse("workflow_projectlist"))

    return render_to_response('workflow/project_add.html',
                              {'form': form},
                              context_instance=RequestContext(request))


@login_required
def project_exportxml(request):
    return project_export(request,'xml')

@login_required
def project_exportjson(request):
    return project_export(request,'json')

def project_export(request, output_format):
    if output_format not in ["xml", "json"]:
        return HttpResponseNotFound

    pl = Project.objects.filter(Q(user=request.user) | Q(group__in=request.user.groups.all()))

    output = serializers.serialize(output_format, pl)
    # sticks in a POST or renders empty form
    response = HttpResponse(output, mimetype='text/txt')
    response["Content-Disposition"] = "attachment; filename= simulocean_project.%s" % output_format
    return response


#@login_required
#def project_edit(request, project_id):
#    # sticks in a POST or renders empty form
#    project = get_object_or_404(Project, pk=project_id)
#
#    if request.user != project.user:
#        return redirect(reverse("workflow_projectlist"))
#
#    form = ProjectForm(request.user, request.POST or None, instance=project)
#
#    if form.is_valid():
#        pmodel = form.save(commit=False)
#        pmodel.last_modified = datetime.now()
#        #add extra attributes that users shall not add
#        #pmodel.name = 'test1'
#        pmodel.save()
#
#        # for illegal request we simple ignore.
#        return redirect(reverse("workflow_projectlist"))
#
#    else:
#        return render_to_response('workflow/project_edit.html',
#            {'project_form': form, 'project_id': project_id},
#            context_instance=RequestContext(request))


@login_required
def project_view(request, project_id):
    # sticks in a POST or renders empty form
    p = get_object_or_404(Project, pk=project_id)

    if request.user == p.user or request.user.groups.filter(name=p.group):
        return render_to_response('workflow/project_detail.html',
                                  {'object': p},
                                  context_instance=RequestContext(request))
    else:
        return redirect(reverse("workflow_projectlist"))


@login_required
def project_delete(request, project_id):
    p = get_object_or_404(Project, pk=project_id)

    if request.user == p.user:
        p.delete()

    # for illegal request we simple ignore.
    return redirect(reverse("workflow_projectlist"))

#
#@login_required
#def report(request):
#    resp = HttpResponse(mimetype='application/pdf')
#
#    project = Project.objects.all()
#    report = ReportProject(queryset=project)
#    report.generate_by(PDFGenerator, filename=resp)
#    return resp

#    return render_to_response('coastalmodels/report.html', context_instance=RequestContext(request))

