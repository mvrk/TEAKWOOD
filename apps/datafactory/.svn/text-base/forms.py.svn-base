from django import forms
from django.core.exceptions import ValidationError
from django.forms import ModelForm
from apps.datafactory.models import DataRequest


class DataRequestForm(ModelForm):
    class Meta:
        widgets = {
            'start_time': forms.DateTimeInput(
                attrs={'id': 'starttimepicker'}),
            'end_time': forms.DateTimeInput(
                attrs={'id': 'endtimepicker'}),
        }
        model = DataRequest
        fields = ('group', 'start_time', 'end_time', 'description')

    def clean(self):
        cleaned_data = super(DataRequestForm, self).clean()
        start_time = cleaned_data.get('start_time', None)
        end_time = cleaned_data.get('end_time', None)
        # station_list = cleaned_data.get('station_list', None)
        # if station_list == None:
        #     raise ValidationError('You need to select at least one station.')
        if start_time >= end_time:
            raise ValidationError('The end time is not later than the start time.')

        return cleaned_data
