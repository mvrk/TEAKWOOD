from django.contrib.auth.models import User, Group
from django.db import models
# this helps to separate Scgate framework from specific application
# other applications will provide different application apps.
#from apps.coastalmodels.models import CoastalModel

class CommonInfo(models.Model):
    name = models.CharField(max_length=60, null=True, blank=True)
    user = models.ForeignKey(User, null=True, blank=True)
#TODO the group should be changed to one to many to share the object to multiple groups
    group = models.ForeignKey(Group, null=True, blank=True, help_text="(Select a group to share with)", default=1)
    # associated project (important to link this to other parts of simulocean)
    time_created = models.DateTimeField(auto_now_add=True)
    last_modified = models.DateTimeField(auto_now=True)
    description = models.TextField(null=True, blank=True)
    class Meta:
        abstract = True