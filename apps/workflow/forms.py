from django.core.exceptions import ValidationError
from django.forms import ModelForm
from apps.workflow.models import Project

class ProjectForm(ModelForm):
    class Meta:
        model = Project
        # exclude = ('user', 'time_created', 'last_modified', 'cwd')
        fields = ('name', 'group', 'description')
    def __init__(self, user, *args, **kwargs):
        super(ProjectForm, self).__init__(*args, **kwargs)
        self.user = user

    def clean(self):
        cleaned_data = super(ProjectForm, self).clean()
        project_name = cleaned_data.get('name')
        project_name = '-'.join(project_name.strip().split())
        if project_name == '':
            raise ValidationError('Project name can not be empty.')
        # no two projects created by the same user shall have the same name.
        elif Project.objects.filter(name=project_name, user=self.user).exclude(pk=self.instance.pk):
            raise ValidationError('A project with the same name already exists.')

        return cleaned_data