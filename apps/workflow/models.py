import os
from django.views.generic import ListView
#from django.contrib.auth.models import User, Group
from django.db import models
from apps.simulocean.models import CommonInfo
from django.db.models import Q
# this helps to separate Scgate framework from specific application
#from apps.coastalmodels.models import CoastalModel
#from apps.datafactory.models import DataRequest

# when you create a new modle you will only config the parameters based
# on the default parameter file. Namely the model page will be ended up
# to be a parameter file editor.
#from apps.meshtools.models import Mesh
#from apps.reports.models import Report
from settings.settings import MEDIA_ROOT
from utils.system import mkdir_p


class Project(CommonInfo):
        #    data_request = models.ManyToManyField(DataRequest, null=True, blank=True)

        # workflow related
        # we limit one job to one project. the filed will be defined in Simfactory
        #    job = models.OneToOneField(Job, null=True, blank=True)
        #    model = models.ForeignKey(CoastalModel, help_text = '(Select a coastal model)')

    #    mesh = models.ForeignKey(Mesh, null=True, blank=True)
    #    obs_data = models.ForeignKey(ObsData, null=True, blank=True)
    #    sim_data = models.ForeignKey(SimData, null=True, blank=True)

    # defines a many-to-one relationship in the JOB model
    #    report = models.ForeignKey(Report, null=True, blank=True)
    #    directory = models.CharField(max_length=120, null=True, blank=True)
    # user is not in the form so this has to be validated in the code
    #    class META:
    #        unique_together = ("name", "user")
    cwd = models.CharField(max_length=120)

    # from_descriptor = models.BooleanField(default="false", help_text="create a Scgate project from a descriptor file")
    # descriptor = models.FileField(upload_to="documents", help_text="upload the project descriptor")

    def get_fields(self):
        return [(field.verbose_name, field._get_val_from_obj(self))
                for field in self.__class__._meta.fields]

    def get_upload_to(instance, filename):
        fn = os.path.abspath("%s/%s" % (MEDIA_ROOT, filename))
        return fn

    def mkdir(self):
        mkdir_p(os.path.abspath("%s/%s" % (MEDIA_ROOT, self.cwd)))

    def __unicode__(self):
        return self.name.strip()
        #
        # class META:
        #     unique_together = ('name', 'user')

# model for ListViewing project
class ProjectList(ListView):
    model = Project

    def get_queryset(self):
        return Project.objects.filter(
            Q(user=self.request.user) |
            Q(group__in=self.request.user.groups.all())).order_by('-id')


#STATUS_TABLE = [('successful', 'finished successfully'),
#                ('running', 'in progress',),
#                ('cancelled', 'cancelled by user'),
#                ('hanged', 'hanged'),
#                ('failed', 'failed'),
#                ]

