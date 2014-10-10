from django.conf.urls import patterns, include, url
import settings
# Uncomment the next two lines to enable the admin:
from django.contrib import admin

admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'settings.views.home', name='home'),
    # url(r'^settings/', include('settings.foo.urls')),
    # django admin urls
    url(r'^grappelli/', include('grappelli.urls')), # grappelli URLS
    url(r'^admin/doc/', include('django.contrib.admindocs.urls')),
    url(r'^admin/', include(admin.site.urls)),

    # profiles
    url(r'^profiles/', include('profiles.urls')),

    # google openid urls
    # url(r'^google/login/$', 'django_openid_auth.views.login_begin', name='google-login'),
    # url(r'^google/login-complete/$', 'django_openid_auth.views.login_complete', name='openid-complete'),
    # url(r'^logout/$', 'django.contrib.auth.views.logout', {'next_page': '/', }, name='google-logout'),

    # TEAKWOODurls
    url(r'^', include('apps.teakwood.urls')),

    # workflow urls
    url(r'^', include('apps.workflow.urls')),

    # simfactory urls
    url(r'^', include('apps.simfactory.urls')),

    # simlab urls
    url(r'^', include('apps.simlab.urls')),

    # simviz urls
    url(r'^', include('apps.simviz.urls')),

    # coastalmodels urls
    url(r'^', include('apps.coastalmodels.urls')),

    # datafactory urls
    url(r'^', include('apps.datafactory.urls')),

    # simesh urls
    url(r'^', include('apps.simesh.urls')),

    # fileupload urls
    url(r'^', include('apps.fileupload.urls')),

    # registration urls
    url(r'^', include('registration.backends.default.urls')),
)

urlpatterns += patterns('',
    (r'^static/(?P<path>.*)$', 'django.views.static.serve', {'document_root': settings.STATIC_ROOT}),
    (r'^media/(?P<path>.*)$', 'django.views.static.serve', {'document_root': settings.MEDIA_ROOT}),
)
