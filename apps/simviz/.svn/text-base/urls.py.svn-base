from django.conf.urls import patterns, url

urlpatterns = patterns('apps.simviz.views',
    url(r'^simviz/obsdata/$', 'plot_obsdata', '', name='simviz_plotobsdata'),
    url(r'^simviz/simdata/$', 'plot_simdata', '', name='simviz_plotsimdata'),
    #    url(r'^plot/simdata/$', 'plot_simdata', '', name='simfactory_plotsimdata'),

    #    url(r'^plot/(?P<datarequest_id>\d+)/(?P<field_name>\w+)$', 'plot_obsdata', name='coastalmodels_plotobsdata'),
    #    url(r'^plot/obsdata/$', 'plot_obsdata', name='coastalmodels_plotobsdata'),
)