from django.core.exceptions import ValidationError
from django.db.models import Q
from django.forms import ModelForm
from apps.simfactory.forms import JobForm
from apps.simfactory.models import ScriptTemplate
from apps.simlab.models import Comparison
from apps.coastalmodels.models import ModelInput

# class ComparisonForm(ModelForm):
#     def __init__(self, user, project_id, *args, **kwargs):
#         super(ComparisonForm, self).__init__(*args, **kwargs)
#         self.user = user
#
#     def clean(self):
#         cleaned_data = super(JobForm, self).clean()
#         slots = cleaned_data.get('slots', None)
#         wallclocktime = cleaned_data.get('wallclocktime', None)
#         machine = cleaned_data.get('machine', None)
#         model_input = cleaned_data.get('model_input', None)
#         script_template = ScriptTemplate.objects.filter(Q(machine=machine), Q(model=model_input.model))
#
#         if machine:
#             if slots < 1 or slots > machine.maxslots:
#                 raise ValidationError('You can only request 1-%s CPUs in the queue %s on %s.' % (
#                     machine.maxslots, machine.queuename, machine.name))
#             if wallclocktime < 1 or wallclocktime > machine.maxwallclocktime:
#                 raise ValidationError('You can only request 1-%s hours on %s.' % (
#                     machine.maxwallclocktime, machine.name))
#         if model_input:
#             if not model_input.inputdatasets.all():
#                 raise ValidationError('There are no input files for the selected model.')
#
#         if not script_template:
#             raise ValidationError('The selected model is not supported on the machine.')
#
#         return cleaned_data
#
#
#     class Meta:
#         model = Job
#         exclude = ('jobid', 'name', 'project', 'exitstatus', 'annotation', 'jobstate',
#                    'jobsubstate', 'nodes', 'user', 'group', 'wallclocktimestring', 'email', 'emailonstarted',
#                    'emailonterminated', 'queuename', 'time_created', 'last_modified',
#                    'dispatchtime', 'finishtime', 'accountingid', 'jobgroup', 'local_dir',
#                    'remote_dir', 'script_name', 'script_template', 'qstat_xml', 'progress', 'data_ready')
#
