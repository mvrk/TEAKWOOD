import os
from django.core.urlresolvers import reverse
from django.db import models
from django.shortcuts import redirect
from apps.teakwood.models import CommonInfo
from apps.coastalmodels.models import ModelInput
from settings.settings import MEDIA_ROOT

class ModelInputData(CommonInfo):
    def get_upload_to(instance, filename):
        fn = os.path.abspath("%s/%s/%s" % (MEDIA_ROOT, instance.model_input.input_dir, filename))
        # if os.path.exists(fn):
        #     os.remove(fn)
        return fn

    model_input = models.ForeignKey(ModelInput, related_name="inputdatasets", blank=True, null=True)
    #file = models.FileField(upload_to="pictures")
    file = models.FileField(upload_to=get_upload_to)
#    slug = models.SlugField(max_length=50, blank=True)

    def save(self, *args, **kwargs):
        self.name = self.file.name
        super(ModelInputData, self).save(*args, **kwargs)

    def __unicode__(self):
        return self.name

    def get_absolute_url(self):
        return redirect(reverse("models_modelinputdataadd", args=[self.model_input.id]))

    def delete(self, *args, **kwargs):
        self.file.delete(False)
        super(ModelInputData, self).delete(*args, **kwargs)

    def get_fields(self):
        return [(field.verbose_name, field._get_val_from_obj(self))
                for field in self.__class__._meta.fields]
