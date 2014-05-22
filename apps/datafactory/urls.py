from django.conf.urls import patterns, url
from apps.datafactory.models import StationList, DataRequestList, BuoyDataList, TideDataList, CurrentDataList
from django.contrib.auth.decorators import login_required

urlpatterns = patterns('apps.datafactory.views',
                       # we may want to move opendap to simfactory
                       url(r'^datafactory/opendap/$', 'datafactory_opendap', '', name='datafactory_opendap'),
                       url(r'^datafactory/opendap/(?P<job_id>\d+)/$', 'datafactory_opendap', '',
                           name='datafactory_opendap'),
                       url(r'^datafactory/mapview/$', 'datarequest_mapview', '', name='datafactory_datarequestmapview'),

                       # enable me only when Station List is updated
                       url(r'^datafactory/station/export/marker$', 'station_exportmarker', '',
                           name='datafactory_stationexportmarker'),

                       # URL for add/edit/delete SWAN input
                       url(r'^datarequest/add/$', 'datarequest_add', '', name='datafactory_datarequestadd'),
                       # url(r'^datarequest/edit/(?P<datarequest_id>\d+)/$', 'datarequest_edit', name='datafactory_datarequestedit'),
                       url(r'^datarequest/view/(?P<datarequest_id>\d+)/$', 'datarequest_view',
                           name='datafactory_datarequestview'),
                       url(r'^datarequest/delete/(?P<datarequest_id>\d+)/$', 'datarequest_delete',
                           name='datafactory_datarequestdelete'),
                       url(r'^datarequest/export/buoy/csv/(?P<datarequest_id>\d+)/$', 'datarequest_buoyexportcsv',
                           name='datafactory_datarequestbuoyexportcsv'),
                       url(r'^datarequest/export/current/csv/(?P<datarequest_id>\d+)/$', 'datarequest_currentexportcsv',
                           name='datafactory_datarequestcurrentexportcsv'),
                       url(r'^datarequest/export/tide/csv/(?P<datarequest_id>\d+)/$', 'datarequest_tideexportcsv',
                           name='datafactory_datarequesttideexportcsv'),

                       url(r'^datarequest/export/json/(?P<datarequest_id>\d+)/(?P<field_name>\w+)/$',
                           'datarequest_exportjson', name='datafactory_datarequestexportjson'),
                       # url(r'^datarequest/gen_report/(?P<datarequest_id>\d+)/$', 'report', name='datafactory_report'),
)

urlpatterns += patterns('',
                        url(r'^datafactory/co-ops/tidedatalist/(?P<datarequest_id>\d+)/$',
                            login_required(TideDataList.as_view()), '', name='datafactory_tidedatalist'),
                        url(r'^datafactory/co-ops/currentdatalist/(?P<datarequest_id>\d+)/$',
                            login_required(CurrentDataList.as_view()), '',
                            name='datafactory_currentdatalist'),
                        url(r'^datafactory/ndbc/buoydatalist/(?P<datarequest_id>\d+)/$',
                            login_required(BuoyDataList.as_view()), '', name='datafactory_buoydatalist'),
                        url(r'^datafactory/stationlist/$', login_required(StationList.as_view()), '',
                            name='datafactory_stationlist'),
                        url(r'^datarequest/list/$', login_required(DataRequestList.as_view()), '',
                            name='datafactory_datarequestlist'),
)

