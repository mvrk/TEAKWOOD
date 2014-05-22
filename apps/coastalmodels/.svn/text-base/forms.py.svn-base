from django.core.exceptions import ValidationError
from django.db.models import Q
from django.forms import ModelForm
from django import forms
from django.utils.safestring import mark_safe

from apps.coastalmodels.models import SWANConfig, ModelInput, Delft3DConfig, SWANParameters, Delft3DParameters, FVCOMConfig, ADCIRCConfig, CaFunwaveConfig
from apps.workflow.models import Project


class SWANParametersForm(ModelForm):
    class Meta:
        widgets = {
            'read_bottom': forms.TextInput(
                attrs={'readonly': 'true'}),
            'read_wind': forms.TextInput(
                attrs={'readonly': 'true'}),
            'table': forms.TextInput(
                attrs={'readonly': 'true'}),
            'points': forms.TextInput(
                attrs={'readonly': 'true'}),
        }

        model = SWANParameters
        exclude = ('user', 'group', 'name', 'time_created', 'last_modified', 'description')


class Delft3DParametersForm(ModelForm):
    class Meta:
        model = Delft3DParameters
        exclude = ('user', 'group', 'name', 'time_created', 'last_modified', 'description')


class SWANConfigForm(ModelForm):
    def __init__(self, user, *args, **kwargs):
        super(SWANConfigForm, self).__init__(*args, **kwargs)
        self.user = user
        modelinputs = ModelInput.objects.filter(Q(model__name__exact='SWAN'),
                                                Q(user__exact=self.user) | Q(group__in=self.user.groups.all()))
        self.fields['model_input'].queryset = modelinputs

    class Meta:
        model = SWANConfig
        exclude = ('user', 'group', 'name', 'time_created', 'last_modified', 'description')


class Delft3DConfigForm(ModelForm):
    def __init__(self, user, *args, **kwargs):
        super(Delft3DConfigForm, self).__init__(*args, **kwargs)
        self.user = user
        modelinputs = ModelInput.objects.filter(Q(model__name__exact='Delft3D'),
                                                Q(user__exact=self.user) | Q(group__in=self.user.groups.all()))
        self.fields['model_input'].queryset = modelinputs
        #
        # prior_models = ModelInput.objects.filter(Q(model__name__exact='Delft3D'),
        #                                          Q(user__exact=self.user) | Q(group__in=self.user.groups.all()))
        # self.fields['prior_model'].queryset = prior_models

    def clean(self):
        cleaned_data = super(Delft3DConfigForm, self).clean()
        # if cleaned_data.get('nested_model'):
        #     if not cleaned_data.get('prior_model'):
        #         raise ValidationError('You must pick an overall model for a nested run.')
        return cleaned_data

    class Meta:
        model = Delft3DConfig

        exclude = ('user', 'group', 'name', 'time_created', 'last_modified', 'description')


class FVCOMConfigForm(ModelForm):
    def __init__(self, user, *args, **kwargs):
        super(FVCOMConfigForm, self).__init__(*args, **kwargs)
        self.user = user
        modelinputs = ModelInput.objects.filter(Q(model__name__exact='FVCOM'),
                                                Q(user__exact=self.user) | Q(group__in=self.user.groups.all()))
        self.fields['model_input'].queryset = modelinputs

    class Meta:
        model = FVCOMConfig
        exclude = ('user', 'group', 'name', 'time_created', 'last_modified', 'description')


class ADCIRCConfigForm(ModelForm):
    def __init__(self, user, *args, **kwargs):
        super(ADCIRCConfigForm, self).__init__(*args, **kwargs)
        self.user = user
        modelinputs = ModelInput.objects.filter(Q(model__name__exact='ADCIRC'),
                                                Q(user__exact=self.user) | Q(group__in=self.user.groups.all()))
        self.fields['model_input'].queryset = modelinputs

    class Meta:
        model = ADCIRCConfig
        # exclude = ('user', 'group', 'name', 'time_created', 'last_modified', 'cera_script')
        exclude = ('user', 'group', 'name', 'time_created', 'last_modified', 'description')


class CaFunwaveConfigForm(ModelForm):
    def __init__(self, user, *args, **kwargs):
        super(CaFunwaveConfigForm, self).__init__(*args, **kwargs)
        self.user = user
        modelinputs = ModelInput.objects.filter(Q(model__name__exact='CaFunwave'),
                                                Q(user__exact=self.user) | Q(group__in=self.user.groups.all()))
        self.fields['model_input'].queryset = modelinputs

    class Meta:
        model = CaFunwaveConfig
        exclude = ('user', 'group', 'name', 'time_created', 'last_modified', 'description')


class ModelInputForm(ModelForm):
    def __init__(self, user, *args, **kwargs):
        super(ModelInputForm, self).__init__(*args, **kwargs)
        #        self.project = get_object_or_404(ModelInput, pk=project_id)
        self.user = user
        projects = Project.objects.filter(
            Q(user__exact=self.user) | Q(group__in=self.user.groups.all()))
        self.fields['project'].queryset = projects

        prior_models = ModelInput.objects.filter(Q(user__exact=self.user) | Q(group__in=self.user.groups.all()))
        self.fields['prior_model'].queryset = prior_models


    def clean(self):
        cleaned_data = super(ModelInputForm, self).clean()
        project = cleaned_data.get('project')

        if not project:
            raise ValidationError('You must pick a project to work on.')
        if cleaned_data.get('poi_type') == 'domain':
            try:
                domain = project.domain
            except:
                raise ValidationError(mark_safe('You must create a project domain before you can use it.'))

        if not cleaned_data.get('model'):
            raise ValidationError('You must pick a model to start with.')

        return cleaned_data

    class Meta:
        model = ModelInput
        fields = ('project', 'model', 'prior_model', 'poi_type', 'description')