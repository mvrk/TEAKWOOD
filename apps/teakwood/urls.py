from django.conf.urls import patterns, url
from django.views.generic.base import TemplateView
from django.contrib.auth.decorators import login_required
from apps.workflow.models import ProjectList

urlpatterns = patterns('',
                       # the main pages of the Teakwood site
                       # index and about pages are now using generic view
                       # other pages should be protected by the password
                       url(r'^$', TemplateView.as_view(template_name='teakwood/index.html'), name='teakwood_home'),
                       url(r'^about/$', TemplateView.as_view(template_name='teakwood/about.html'),
                           name='teakwood_about'),
                       url(r'^about/services/$', TemplateView.as_view(template_name='teakwood/services.html'),
                           name='teakwood_services'),
                       # url(r'^about/partners/$', TemplateView.as_view(template_name='teakwood/partners.html'),
                       #     name='teakwood_partners'),
                       url(r'^about/software/$', TemplateView.as_view(template_name='teakwood/software.html'),
                           name='teakwood_software'),
                       url(r'^about/contact/$', TemplateView.as_view(template_name='teakwood/contact.html'),
                           name='teakwood_contact'),
                       url(r'^about/credit/$', TemplateView.as_view(template_name='teakwood/credit.html'),
                           name='teakwood_credit'),
                       # url(r'^about/license/$', TemplateView.as_view(template_name='teakwood/license.html'),
                       #     name='teakwood_license'),
                       url(r'^about/tutorials/$', TemplateView.as_view(template_name='teakwood/tutorials.html'),
                           name='teakwood_tutorials'),
                       url(r'^doc/$', TemplateView.as_view(template_name='teakwood/doc.html'),
                           name='teakwood_doc'),
                       url(r'^doc/detached/$', TemplateView.as_view(template_name='teakwood/doc_detached.html'),
                           name='teakwood_doc_detached'),
                       url(r'^myadmin/$', TemplateView.as_view(template_name='teakwood/myadmin.html'),
                           name='teakwood_myadmin'),
)