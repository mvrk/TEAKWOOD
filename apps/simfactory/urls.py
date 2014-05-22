from django.conf.urls import patterns, url
from django.views.generic import DetailView
from apps.simfactory.models import Machine, MachineList
from django.contrib.auth.decorators import login_required

urlpatterns = patterns('apps.simfactory.views',
    # URL for job control
    url(r'^simfactory/job/add/$', 'job_add', '', name='simfactory_jobadd'),
    url(r'^simfactory/job/add/(?P<project_id>\d+)/$', 'job_add', '', name='simfactory_jobadd'),
   # url(r'^simfactory/job/edit/(?P<job_id>\d+)/$', 'job_edit', name='simfactory_jobedit'),
    url(r'^simfactory/job/delete/(?P<job_id>\d+)/$', 'job_delete', name='simfactory_jobdelete'),
    url(r'^simfactory/job/deleteall/$', 'job_deleteall', name='simfactory_jobdeleteall'),

    url(r'^simfactory/job/export/xml/$', 'job_exportxml', '', name='simfactory_jobexportxml'),
    url(r'^simfactory/job/export/json/$', 'job_exportjson', '', name='simfactory_jobexportjson'),
    url(r'^simfactory/job/export/stdout/(?P<job_id>\d+)/$', 'job_exportstdout', '', name='simfactory_jobexportstdout'),
    url(r'^simfactory/job/export/stderr/(?P<job_id>\d+)/$', 'job_exportstderr', '', name='simfactory_jobexportstderr'),
    url(r'^simfactory/job/submit/(?P<job_id>\d+)/$', 'job_submit', name='simfactory_jobsubmit'),
    url(r'^simfactory/job/submitall/$', 'job_submitall', name='simfactory_jobsubmitall'),
    url(r'^simfactory/job/checkstatus/(?P<job_id>\d+)/$', 'job_checkstatus', name='simfactory_jobcheckstatus'),
    url(r'^simfactory/job/checkstatus/all/$', 'job_checkstatusall', name='simfactory_jobcheckstatusall'),
    url(r'^simfactory/job/hold/(?P<job_id>\d+)/$', 'job_hold', name='simfactory_jobhold'),
    url(r'^simfactory/job/holdall/$', 'job_holdall', name='simfactory_jobholdall'),
    url(r'^simfactory/job/stop/(?P<job_id>\d+)/$', 'job_stop', name='simfactory_jobstop'),
    url(r'^simfactory/job/stopall/$', 'job_stopall', name='simfactory_jobstopall'),
#    url(r'^simfactory/job/terminate/(?P<job_id>\d+)/$', 'job_terminate', name='simfactory_jobterminate'),
#    url(r'^job/export/(?P<job_id>\d+)/$', 'job_export', name='simfactory_jobexport'),
#    url(r'^job/exportjson/(?P<job_id>\d+)/(?P<field_name>\w+)/(?P<sid>\d+)/$', 'job_exportjson', name='simfactory_jobexportjson'),

    # We will not use ListView since we want to deal with more complicated logics to handle job progress.
    # it will be really ugly if we use listview and insert member functions that should stay away from
    # the definition of models.
    url(r'^simfactory/job/list/$', 'job_list', '', name='simfactory_joblist'),
    url(r'^simfactory/job/view/(?P<job_id>\d+)/$', 'job_view', '', name='simfactory_jobview'),
    url(r'^simfactory/job/export/script/(?P<job_id>\d+)/$', 'job_exportpbs', '', name='simfactory_jobscriptexport'),
)

urlpatterns += patterns('',
#    url(r'^simfactory/machine/view/(?P<pk>\d+)/$', login_required(DetailView.as_view(model=Machine)), '',
#        name='simfactory_machineview'),
    url(r'^simfactory/machine/list/$', login_required(MachineList.as_view()), '', name='simfactory_machinelist'),
)