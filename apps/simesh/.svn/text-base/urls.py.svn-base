from django.conf.urls import patterns, url
from django.contrib.auth.decorators import login_required
from apps.simesh.models import DomainList

urlpatterns = patterns('apps.simesh.views',
                       url(r'^simesh/domain/add/$', 'domain_add', '', name='simesh_domainadd'),
                       url(r'^simesh/domain/add/(?P<project_id>\d+)/$', 'domain_add', name='simesh_domainadd'),
                       url(r'^simesh/domain/view/(?P<domain_id>\d+)/$', 'domain_view',
                           name='simesh_domainview'),
                       url(r'^simesh/domain/delete/(?P<domain_id>\d+)/$', 'domain_delete', name='simesh_domaindelete'),
                       url(r'^simesh/domain/poi/export/html/(?P<domain_id>\d+)/$', 'domain_exportpoi_html',
                           name='simesh_domainexportpoihtml'),
                       url(r'^simesh/domain/depth/export/netcdf/(?P<domain_id>\d+)/$', 'domain_export_depth',
                           name='simesh_domainexportdepth'),
)
urlpatterns += patterns('',
                        url(r'^simesh/domain/list/$', login_required(DomainList.as_view()), '',
                            name='simesh_domainlist'),
)