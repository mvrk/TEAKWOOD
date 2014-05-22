from django.contrib.auth.decorators import login_required
from django.views.generic import DetailView, TemplateView
from django.conf.urls import patterns, url
# from apps.coastalmodels.models import ModelInputList, CoastalModel, CoastalModelList, SWANConfigList, Delft3DConfigList, SWANParametersList, Delft3DParametersList
from apps.coastalmodels.models import *

urlpatterns = patterns('apps.coastalmodels.views',
                       # URL for coastalmodels parameter edit
                       #    url(r'^mesh/$', 'mesh', '', name='coastalmodels_mesh'),
                       #    url(r'^model/$', 'model', '', name='coastalmodels_model'),

                       # URL for add/edit/delete SWAN config
                       url(r'^model/input/add/$', 'modelinput_add', name='coastalmodels_modelinputadd'),
                       url(r'^model/input/add/(?P<project_id>\d+)/$', 'modelinput_add',
                           name='coastalmodels_modelinputadd'),
                       url(r'^model/input/view/(?P<modelinput_id>\d+)/$', 'modelinput_view',
                           name='coastalmodels_modelinputview'),
                       # url(r'^model/input/edit/(?P<modelinput_id>\d+)/$', 'modelinput_edit',
                       #     name='coastalmodels_modelinputedit'),
                       url(r'^model/input/delete/(?P<modelinput_id>\d+)/$', 'modelinput_delete',
                           name='coastalmodels_modelinputdelete'),
                       # url(r'^model/input/export/(?P<modelinput_id>\d+)/$', 'modelinput_export', name='models_modelinputexport'),
                       #    url(r'^model/input/data/add/(?P<modelinput_id>\d+)/$', 'modelinputdata_add', name='models_modelinputdataadd'),
                       #    url(r'^model/input/data/delete/(?P<pk>\d+)/$', 'modelinputdata_delete',
                       #        name='models_modelinputdatadelete'),


                       url(r'^model/config/swan/add/$', 'swanconfig_add', '', name='coastalmodels_swanconfigadd'),
                       url(r'^model/config/swan/add/(?P<modelinput_id>\d+)/$', 'swanconfig_add', '',
                           name='coastalmodels_swanconfigadd'),
                       url(r'^model/config/swan/edit/(?P<swanconfig_id>\d+)/$', 'swanconfig_edit',
                           name='coastalmodels_swanconfigedit'),
                       url(r'^model/config/swan/view/(?P<swanconfig_id>\d+)/$', 'swanconfig_view',
                           name='coastalmodels_swanconfigview'),
                       url(r'^model/config/swan/delete/(?P<swanconfig_id>\d+)/$', 'swanconfig_delete',
                           name='coastalmodels_swanconfigdelete'),
                       # url(r'^model/config/swanconfig/export/(?P<swanconfig_id>\d+)/$', 'swanconfig_export',
                       #     name='coastalmodels_swanconfigexport'),

                       url(r'^model/config/swan/parameters/add/$', 'swanparameters_add', '',
                           name='coastalmodels_swanparametersadd'),
                       url(r'^model/config/swan/parameters/add/(?P<swanconfig_id>\d+)/$', 'swanparameters_add', '',
                           name='coastalmodels_swanparametersadd'),
                       url(r'^model/config/swan/parameters/view/(?P<swanparameters_id>\d+)/$', 'swanparameters_view',
                           '',
                           name='coastalmodels_swanparametersview'),
                       url(r'^model/config/swan/parameters/delete/(?P<swanparameters_id>\d+)/$',
                           'swanparameters_delete', '',
                           name='coastalmodels_swanparametersdelete'),

                       url(r'^model/config/delft3d/test/add/$',
                           TemplateView.as_view(template_name='coastalmodels/delft3d/delft3d_add.html'),
                           name='coastalmodels_delft3dconfigadd'),

                       url(r'^model/config/delft3d/add/$', 'delft3dconfig_add', '',
                           name='coastalmodels_delft3dconfigadd'),
                       url(r'^model/config/delft3d/add/(?P<modelinput_id>\d+)/$', 'delft3dconfig_add', '',
                           name='coastalmodels_delft3dconfigadd'),
                       url(r'^model/config/delft3d/view/(?P<delft3dconfig_id>\d+)/$', 'delft3dconfig_view',
                           name='coastalmodels_delft3dconfigview'),
                       url(r'^model/config/delft3d/edit/(?P<delft3dconfig_id>\d+)/$', 'delft3dconfig_edit',
                           name='coastalmodels_delft3dconfigedit'),
                       url(r'^model/config/delft3d/delete/(?P<delft3dconfig_id>\d+)/$', 'delft3dconfig_delete',
                           name='coastalmodels_delft3dconfigdelete'),
                       # url(r'^model/config/delft3dconfig/export/(?P<delft3dconfig_id>\d+)/$', 'delft3dconfig_export',
                       #     name='coastalmodels_delft3dconfigexport'),
                       url(r'^model/config/delft3d/parameters/add/$', 'delft3dparameters_add', '',
                           name='coastalmodels_delft3dparametersadd'),
                       url(r'^model/config/delft3d/parameters/add/(?P<delft3dconfig_id>\d+)/$', 'delft3dparameters_add',
                           '', name='coastalmodels_delft3dparametersadd'),
                       url(r'^model/config/delft3d/parameters/view/(?P<delft3dparameters_id>\d+)/$',
                           'delft3dparameters_view', '',
                           name='coastalmodels_delft3dparametersview'),
                       url(r'^model/config/delft3d/parameters/delete/(?P<delft3dparameters_id>\d+)/$',
                           'delft3dparameters_delete', '',
                           name='coastalmodels_delft3dparametersdelete'),

                       url(r'^model/config/fvcom/add/$', 'fvcomconfig_add', '', name='coastalmodels_fvcomconfigadd'),
                       url(r'^model/config/fvcom/add/(?P<modelinput_id>\d+)/$', 'fvcomconfig_add', '',
                           name='coastalmodels_fvcomconfigadd'),
                       url(r'^model/config/fvcom/edit/(?P<fvcomconfig_id>\d+)/$', 'fvcomconfig_edit',
                           name='coastalmodels_fvcomconfigedit'),
                       url(r'^model/config/fvcom/view/(?P<fvcomconfig_id>\d+)/$', 'fvcomconfig_view',
                           name='coastalmodels_fvcomconfigview'),
                       url(r'^model/config/fvcom/delete/(?P<fvcomconfig_id>\d+)/$', 'fvcomconfig_delete',
                           name='coastalmodels_fvcomconfigdelete'),

                       url(r'^model/config/adcirc/add/$', 'adcircconfig_add', '', name='coastalmodels_adcircconfigadd'),
                       url(r'^model/config/adcirc/add/(?P<modelinput_id>\d+)/$', 'adcircconfig_add', '',
                           name='coastalmodels_adcircconfigadd'),
                       url(r'^model/config/adcirc/edit/(?P<adcircconfig_id>\d+)/$', 'adcircconfig_edit',
                           name='coastalmodels_adcircconfigedit'),
                       url(r'^model/config/adcirc/view/(?P<adcircconfig_id>\d+)/$', 'adcircconfig_view',
                           name='coastalmodels_adcircconfigview'),
                       url(r'^model/config/adcirc/delete/(?P<adcircconfig_id>\d+)/$', 'adcircconfig_delete',
                           name='coastalmodels_adcircconfigdelete'),

                       url(r'^model/config/cafunwave/add/$', 'cafunwaveconfig_add', '', name='coastalmodels_cafunwaveconfigadd'),
                       url(r'^model/config/cafunwave/add/(?P<modelinput_id>\d+)/$', 'cafunwaveconfig_add', '',
                           name='coastalmodels_cafunwaveconfigadd'),
                       url(r'^model/config/cafunwave/edit/(?P<cafunwaveconfig_id>\d+)/$', 'cafunwaveconfig_edit',
                           name='coastalmodels_cafunwaveconfigedit'),
                       url(r'^model/config/cafunwave/view/(?P<cafunwaveconfig_id>\d+)/$', 'cafunwaveconfig_view',
                           name='coastalmodels_cafunwaveconfigview'),
                       url(r'^model/config/cafunwave/delete/(?P<cafunwaveconfig_id>\d+)/$', 'cafunwaveconfig_delete',
                           name='coastalmodels_cafunwaveconfigdelete'),

                       #    url(r'^model/config/fvcomconfig/edit/(?P<fvcomconfig_id>\d+)/$', 'swanconfig_edit', name='coastalmodels_swanconfigedit'),
                       #    url(r'^model/config/swanconfig/view/(?P<swanconfig_id>\d+)/$', 'swanconfig_view', name='coastalmodels_swanconfigview'),
                       #    url(r'^model/config/swanconfig/delete/(?P<swanconfig_id>\d+)/$', 'swanconfig_delete',
                       #        name='coastalmodels_swanconfigdelete'),
                       #    url(r'^model/config/swanconfig/export/(?P<swanconfig_id>\d+)/$', 'swanconfig_export',
                       #        name='coastalmodels_swanconfigexport'),
)

urlpatterns += patterns('',
                        url(r'^model/view/(?P<pk>\d+)/$', login_required(DetailView.as_view(model=CoastalModel)),
                            name='coastalmodels_coastalmodelview'),

                        url(r'^model/config/swan/list/$',
                            login_required(
                                SWANConfigList.as_view(template_name='coastalmodels/swan/swanconfig_list.html')),
                            name='coastalmodels_swanconfiglist', ),

                        url(r'^model/config/swan/parameters/list/$',
                            login_required(
                                SWANParametersList.as_view(
                                    template_name='coastalmodels/swan/swanparameters_list.html')),
                            name='coastalmodels_swanparameterslist', ),

                        url(r'^model/config/delft3d/list/$',
                            login_required(
                                Delft3DConfigList.as_view(
                                    template_name='coastalmodels/delft3d/delft3dconfig_list.html')),
                            name='coastalmodels_delft3dconfiglist', ),

                        url(r'^model/config/delft3d/parameters/list/$',
                            login_required(
                                Delft3DParametersList.as_view(
                                    template_name='coastalmodels/delft3d/delft3dparameters_list.html')),
                            name='coastalmodels_delft3dparameterslist', ),

                        url(r'^model/config/fvcom/list/$',
                            login_required(
                                FVCOMConfigList.as_view(template_name='coastalmodels/fvcom/fvcomconfig_list.html')),
                            name='coastalmodels_fvcomconfiglist', ),

                        url(r'^model/config/cafunwave/list/$',
                            login_required(
                                CaFunwaveConfigList.as_view(template_name='coastalmodels/cafunwave/cafunwaveconfig_list.html')),
                            name='coastalmodels_cafunwaveconfiglist', ),

                        url(r'^model/config/adcric/list/$',
                            login_required(
                                ADCIRCConfigList.as_view(template_name='coastalmodels/adcirc/adcircconfig_list.html')),
                            name='coastalmodels_adcircconfiglist', ),

                        url(r'^model/input/list/$', login_required(ModelInputList.as_view()),
                            name='coastalmodels_modelinputlist'),

                        url(r'^model/list/$', login_required(CoastalModelList.as_view()),
                            name='coastalmodels_coastalmodellist'),
)
