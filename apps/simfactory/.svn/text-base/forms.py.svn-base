import os

from django.core.exceptions import ValidationError
from django.db.models import Q
from django.forms import ModelForm
from apps.simfactory.models import Job, Machine, ScriptTemplate
from apps.workflow.models import Project
from apps.coastalmodels.models import ModelInput

import logging

log = logging.getLogger(__name__)


class JobForm(ModelForm):
    class Meta:
        model = Job
        # exclude = ('jobid', 'name', 'project', 'exitstatus', 'annotation', 'jobstate',
        #            'jobsubstate', 'nodes', 'user', 'group', 'wallclocktimestring', 'email', 'emailonstarted',
        #            'emailonterminated', 'queuename', 'time_created', 'last_modified',
        #            'dispatchtime', 'finishtime', 'accountingid', 'jobgroup', 'local_dir',
        #            'remote_dir', 'script_name', 'script_template', 'qstat_xml', 'progress', 'data_ready', 'stdout',
        #            'stderr')

        fields = ('model_input', 'machine', 'slots', 'wallclocktime', 'description', 'submit_now')


    def __init__(self, user, project_id, *args, **kwargs):
        super(JobForm, self).__init__(*args, **kwargs)
        self.user = user
        if project_id:
            model_inputs = ModelInput.objects.filter(Q(project__exact=project_id),
                                                     Q(user__exact=self.user) | Q(group__in=self.user.groups.all()))
            self.fields['model_input'].queryset = model_inputs
        machines = Machine.objects.filter(available__exact=True).order_by('-sockets')
        self.fields['machine'].queryset = machines


    def clean(self):
        cleaned_data = super(JobForm, self).clean()
        slots = cleaned_data.get('slots', None)
        wallclocktime = cleaned_data.get('wallclocktime', None)
        machine = cleaned_data.get('machine', None)
        model_input = cleaned_data.get('model_input', None)
        script_template = ScriptTemplate.objects.filter(Q(machine=machine), Q(model=model_input.model))

        if machine:
            if slots < 1 or slots > machine.maxslots:
                raise ValidationError('You can only request 1-%s CPUs in the queue %s on %s.' % (
                    machine.maxslots, machine.queuename, machine.name))

            ppn = machine.corespersocket * machine.sockets
            nodes = (slots - 1 ) / ppn + 1

            if nodes > machine.maxnodes:
                raise ValidationError('You can only request 1-%s nodes in the queue %s on %s.' % (
                    machine.maxnodes, machine.queuename, machine.name))

            if wallclocktime < 1 or wallclocktime > machine.maxwallclocktime:
                raise ValidationError('You can only request 1-%s hours on %s.' % (
                    machine.maxwallclocktime, machine.name))
        if model_input:
            has_parfile = False
            files = list(dataset.file for dataset in model_input.inputdatasets.all())

            if not model_input.inputdatasets.all():
                raise ValidationError('There are no input files for the selected model.')

            if model_input.model.parfile_name:
                for f in files:
                    if model_input.model.parfile_name == os.path.basename(f.name):
                        has_parfile = True
                if not has_parfile:
                    raise ValidationError('The main parameter file %s for model %s is missing.' % (
                        model_input.model.parfile_name, model_input.model.name))

            elif model_input.model.parfile_extension:
                for f in files:
                    if f.name.endswith(model_input.model.parfile_extension):
                        has_parfile = True
                if not has_parfile:
                    raise ValidationError('The main parameter file ending with \'%s\' for model %s is missing.' % (
                        model_input.model.parfile_extension, model_input.model.name))

        if not script_template:
            raise ValidationError('The selected model is not supported on the machine.')

        return cleaned_data


    #            # keep the old validation unchanged.
    #            if not par_file and not model_input:
    #                raise ValidationError('A par file shall be uploaded or a SWAN input be picked.')
    #
    #    def clean(self):
    #        # no two projects created by the same user shall have the same name.
    #        return self.cleaned_data


    def get_my_choices(self):
        queryset = Project.objects.filter(Q(user=self.user) | Q(group__in=self.user.groups.all()))
        choices = ( (p.id, p.name) for p in queryset)
        return choices
