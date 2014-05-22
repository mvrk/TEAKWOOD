import os
from django.db import models
from utils.system import mkdir_p, symlink_all
from settings.settings import MEDIA_ROOT, STATIC_ROOT

from apps.simulocean.models import CommonInfo
from apps.workflow.models import Project

class Report(CommonInfo):

    project = models.OneToOneField(Project)

    def mkdir(self):
        mkdir_p(os.path.abspath("%s/%s/REPORT" % (MEDIA_ROOT, self.project.cwd)))

    def symlink_(self):
        try:
            src_dir = os.path.normpath("%s/%s" % (STATIC_ROOT, "simreport/lib"))
            dst_dir = os.path.normpath("%s/%s/REPORT" % (MEDIA_ROOT, self.project.cwd))

            if not os.path.exists(dst_dir):
                self.mkdir()
            symlink_all(src_dir, dst_dir)
        except OSError:
            self.delete()
            raise

    def render_rst(self):
        """
        the script will be created under the REPORT dir under the project dir.
        """
        script = "%s/%s" % (os.path.normpath("%s/%s/REPORT/" % (MEDIA_ROOT, self.project.cwd)))
        log.debug(script)
        try:
            render_to_file(script, 'simfactory/pbs_jobscript_template.html', {"job": self})
        except Exception:
            raise

    def __unicode__(self):
        return self.name.strip()
