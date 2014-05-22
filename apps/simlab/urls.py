from django.conf.urls import patterns, url

urlpatterns = patterns('apps.simlab.views',
                       # URL for job control
                       url(r'^simlab/job/compare/$', 'job_compare', '', name='simlab_jobcompare'),
)