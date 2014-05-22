import datetime
from django import forms
from django.core.exceptions import ValidationError
from django.forms import ModelForm
from apps.simesh.models import Domain

class DomainForm(ModelForm):
    class Meta:
        widgets = {
            'start_time': forms.DateTimeInput(
                attrs={'id': 'starttimepicker'}),
            'end_time': forms.DateTimeInput(
                attrs={'id': 'endtimepicker'}),
            }

        model = Domain
        exclude = ('user', 'group', 'name', 'time_created', 'last_modified')

    def clean(self):
        cleaned_data = super(DomainForm, self).clean()
        start_time = cleaned_data.get('start_time', None)
        end_time = cleaned_data.get('end_time', None)
        lat_min = cleaned_data.get('latitude_min', None)
        lon_min = cleaned_data.get('longitude_min', None)
        lat_max = cleaned_data.get('latitude_max', None)
        lon_max = cleaned_data.get('longitude_max', None)

        if start_time >= end_time:
            raise ValidationError('The end time is not later than the start time')
        if lat_min >= lat_max:
            raise ValidationError('The minimum latitude is larger than the maximum latitude')
        if lon_min >= lon_max:
            raise ValidationError('The minimum longitude is larger than the maximum longitude')

        return cleaned_data
