from django.shortcuts import render_to_response, get_object_or_404
from django.template import RequestContext
from django.contrib.auth.decorators import login_required
from apps.simviz.forms import PlotObsDataForm, PlotSimDataForm
from apps.simviz.models import PlotSim, PlotObs
#from simfactory.models import Job
from django.db.models import Q
from apps.datafactory.models import Station, DataRequest

@login_required
def plot_obsdata(request):
    object_list = DataRequest.objects.filter(
        Q(user=request.user) |
        Q(group__in=request.user.groups.all())).order_by('-start_time')
    if object_list:
        job = object_list[0]
    else:
        job = None

    form = PlotObsDataForm(request.POST or None)
    datafield = PlotObs(job,field_name="wspd")

    if form.is_valid():
        pmodel = form.save(commit=True)
        datafield = get_object_or_404(PlotObs, pk=pmodel.id)
    return render_to_response('simviz/plot_obsdata.html',
        {'form': form, 'object': datafield},
        context_instance=RequestContext(request))

# this statoin list will be automatically generated later with the mesh selection
STATION_LIST = ['42001', '42002', '42003', '42007', '42019', '42020', '42035', '42036', '42039', '42040', '42055',
                '42056']

@login_required
def plot_simdata(request):
    #    object = PlotSim(job=job_list[0], sid=get_object_or_404(Station, name="42001"), field_name="rtp")

    form = PlotSimDataForm(request.POST or None)

#    form.fields["job"].queryset = Job.objects.filter(
#        Q(user=request.user) |
#        Q(group__in=request.user.groups.all())).order_by('-start_time')
    form.fields["sid"].queryset = Station.objects.filter(name__in=STATION_LIST)
    object = PlotSim(1,sid=get_object_or_404(Station, name__exact="42001"),field_name="rtp")
    if form.is_valid():
        pmodel = form.save(commit=True)
        object = get_object_or_404(PlotSim, pk=pmodel.id)

    return render_to_response('simviz/plot_simdata.html',
        {'plotsimdata_form': form, 'object': object},
        context_instance=RequestContext(request))

#@login_required
#def plot_simdata(request):
#    object_list = Job.objects.filter(
#        Q(user=request.user) |
#        Q(group__in=request.user.groups.all())).order_by('-start_time')
#    #    print object_list
#    if object_list:
#        object = object_list[0]
#    else:
#        object = None
#
#    form = PlotObsDataForm(request.POST or None)
#
#    if form.is_valid():
#        pmodel = form.save(commit=True)
#        object = get_object_or_404(PlotObs, pk=pmodel.id)
#    return render_to_response('simfactory/plot_obsdata.html',
#        {'plotobsdata_form': form, 'object': object},
#        context_instance=RequestContext(request))
