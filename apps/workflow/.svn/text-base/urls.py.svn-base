from django.conf.urls import patterns, url
from django.views.generic.base import TemplateView
from django.contrib.auth.decorators import login_required
from apps.workflow.models import ProjectList

urlpatterns = patterns('apps.workflow.views',
    # URL for project add/edit/delete
    url(r'^project/add/$', 'project_add', '', name='workflow_projectadd'),
#    url(r'^project/edit/(?P<project_id>\d+)/$', 'project_edit', name='workflow_projectedit'),
    url(r'^project/view/(?P<project_id>\d+)/$', 'project_view', name='workflow_projectview'),
    url(r'^project/export/xml/$', 'project_exportxml', '', name='workflow_projectexportxml'),
    url(r'^project/export/json/$', 'project_exportjson', '', name='workflow_projectexportjson'),
    url(r'^project/delete/(?P<project_id>\d+)/$', 'project_delete', name='workflow_projectdelete'),
#    url(r'^report/$', 'report', '', name='workflow_report'),
)

urlpatterns += patterns('',
    url(r'^project/list/$', login_required(ProjectList.as_view()), '', name='workflow_projectlist'),
)
