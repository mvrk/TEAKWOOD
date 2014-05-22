from django.forms import ModelForm
from apps.simviz.models import PlotObs, PlotSim

class PlotObsDataForm(ModelForm):
    class Meta:
        model=PlotObs


class PlotSimDataForm(ModelForm):
    class Meta:
        model=PlotSim
