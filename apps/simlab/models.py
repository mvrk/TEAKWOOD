from django.db import models
from django.db.models import Q
from apps.teakwood.models import CommonInfo
from apps.simfactory.models import Job
import logging
log = logging.getLogger(__name__)


class Comparison(CommonInfo):
    job_ids = models.CharField(max_length=128, null=True, blank=True)

    def __unicode__(self):
        return self.name.strip()

    def get_joblist(self):
        idlist = self.job_ids.split(',')
        log.debug(idlist)
        return Job.objects.filter(Q(pk__in=idlist), Q(user=self.user) | Q(group__in=self.user.groups.all()))
