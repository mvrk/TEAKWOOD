from django.conf.urls import patterns, url
from django.views.generic.base import TemplateView
from django.contrib.auth.decorators import login_required
from apps.workflow.models import ProjectList

urlpatterns = patterns('',
                       # the main pages of the Scgate site
                       # index and about pages are now using generic view
                       # other pages should be protected by the password
                       url(r'^$', TemplateView.as_view(template_name='simulocean/index.html'), name='simulocean_home'),
                       url(r'^about/$', TemplateView.as_view(template_name='simulocean/about.html'),
                           name='simulocean_about'),
                       url(r'^about/services/$', TemplateView.as_view(template_name='simulocean/services.html'),
                           name='simulocean_services'),
                       # url(r'^about/partners/$', TemplateView.as_view(template_name='simulocean/partners.html'),
                       #     name='simulocean_partners'),
                       url(r'^about/software/$', TemplateView.as_view(template_name='simulocean/software.html'),
                           name='simulocean_software'),
                       url(r'^about/contact/$', TemplateView.as_view(template_name='simulocean/contact.html'),
                           name='simulocean_contact'),
                       url(r'^about/credit/$', TemplateView.as_view(template_name='simulocean/credit.html'),
                           name='simulocean_credit'),
                       # url(r'^about/license/$', TemplateView.as_view(template_name='simulocean/license.html'),
                       #     name='simulocean_license'),
                       url(r'^about/tutorials/$', TemplateView.as_view(template_name='simulocean/tutorials.html'),
                           name='simulocean_tutorials'),
                       url(r'^doc/$', TemplateView.as_view(template_name='simulocean/doc.html'),
                           name='simulocean_doc'),
                       url(r'^doc/detached/$', TemplateView.as_view(template_name='simulocean/doc_detached.html'),
                           name='simulocean_doc_detached'),
                       url(r'^myadmin/$', TemplateView.as_view(template_name='simulocean/myadmin.html'),
                           name='simulocean_myadmin'),
)