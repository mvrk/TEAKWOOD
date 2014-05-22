from django.conf.urls import patterns, url
from apps.fileupload.views import ModelInputDataCreateView

urlpatterns = patterns('',
    url(r'^model/input/data/add/(?P<modelinput_id>\d+)/$', ModelInputDataCreateView.as_view(), {},
        'models_modelinputdataadd'),
    )

urlpatterns += patterns('apps.fileupload.views',
    url(r'^model/input/data/delete/(?P<modelinput_id>\d+)/(?P<pk>\d+)/$', 'modelinputdata_delete',
        name='models_modelinputdatadelete'),
    url(r'^model/input/data/delete/(?P<modelinput_id>\d+)/$', 'modelinputdata_delete',
        name='models_modelinputdatadelete'),
)

