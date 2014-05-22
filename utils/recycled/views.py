from datetime import datetime
from django.http import HttpResponse
from django.utils.datastructures import SortedDict
from django.shortcuts import render_to_response, redirect, get_object_or_404
from django.template import RequestContext
from django.contrib.auth.decorators import login_required
from django.core.urlresolvers import reverse
import simplejson
from apps.coastalmodels.forms import SWANInputForm, ModelInputForm, ModelInputDataForm
from apps.coastalmodels.models import SWANInput, ModelInput, ModelInputData, CoastalModel
from settings import settings

from settings.settings import MEDIA_ROOT
from utils.system import mkdir_p
import os

@login_required
def modelinput_add(request):
    # sticks in a POST or renders empty form
    form = ModelInputForm(request.user, request.POST or None)
    if form.is_valid():
        cmodel = form.save(commit=False)
        cmodel.time_created = datetime.now()
        cmodel.last_modified = datetime.now()
        cmodel.user = request.user
        cmodel.save()

        modelinput = get_object_or_404(ModelInput, pk=cmodel.id)
        cmodel.input_dir = os.path.abspath("/users/U%02d/modelinput/M%02d" % (cmodel.user.id, modelinput.id))
        mkdir_p(os.path.abspath("%s%s" % (MEDIA_ROOT, cmodel.input_dir)))
        cmodel.name = "%s-%s-M%02d" % (cmodel.project.name, cmodel.model.name, cmodel.id)
        cmodel.save()

        #TODO refactoring out the hardcoded model reference here.
        if not cmodel.upload_parfile:
            if cmodel.model.name == "SWAN":
                return redirect(reverse("coastalmodels_swaninputadd"))
        else:
        #TODO implement the file uploader...
            return redirect(reverse("coastalmodels_modelinputlist"))

    return render_to_response('coastalmodels/modelinput_add.html',
        {'modelinput_form': form},
        context_instance=RequestContext(request))

# rewrite the modelinput interface to follow "DRY".
@login_required
def modelinput_view(request, modelinput_id):
    object = get_object_or_404(ModelInput, pk=modelinput_id)
    if request.user == object.user or request.user.groups.filter(name=object.group):
        return render_to_response('coastalmodels/modelinput_detail.html',
            {'object': object},
            context_instance=RequestContext(request))
    else:
        return redirect(reverse("coastalmodels_modelinputlist"))


@login_required
def modelinput_edit(request, modelinput_id):
    modelinput = get_object_or_404(ModelInput, pk=modelinput_id)

    if request.user != modelinput.user:
        return redirect(reverse("coastalmodels_modelinputlist"))

    form = ModelInputForm(request.user, request.POST or None, instance=modelinput)

    if form.is_valid():
        mimodel = form.save(commit=False)
        #add extra attributes that users shall not add
        mimodel.last_modified = datetime.now()

        #mimodel.name = 'test1'
        mimodel.save()

        # for illegal request we simple ignore.
        return redirect(reverse("coastalmodels_modelinputlist"))

    else:
        return render_to_response('coastalmodels/modelinput_edit.html',
            {'modelinput_form': form, 'modelinput_id': modelinput_id},
            context_instance=RequestContext(request))


@login_required
def modelinput_delete(request, modelinput_id):
    modelinput = get_object_or_404(ModelInput, pk=modelinput_id)
    if request.user == modelinput.user:
        modelinput.delete()

    return redirect(reverse("coastalmodels_modelinputlist"))


@login_required
def modelinputdata_add(request, modelinput_id):
    modelinput = get_object_or_404(ModelInput, pk=modelinput_id)

    if request.user == modelinput.user or request.user.groups.filter(name=modelinput.group):
        # sticks in a POST or renders empty form
        form = ModelInputDataForm(request.user, request.POST or None)

        if form.is_valid():
            imodel = form.save(commit=False)
            imodel.model_input = modelinput
            imodel.user = request.user

            imodel.project = modelinput.project
            imodel.group = modelinput.group
            imodel.model = modelinput.model
            imodel.time_created = datetime.now()
            imodel.last_modified = datetime.now()
            imodel.input_dir = modelinput.input_dir
            imodel.save()
            imodel.name = "%s-ID%02d" % (modelinput.name, imodel.id)
            imodel.save()

            datafile = request.FILES.get('file')
            dataurl = settings.MEDIA_URL + imodel.input_dir + datafile.name.replace(" ", "_")

            data = [{'name': datafile.name, 'url': dataurl, 'thumbnail_url': dataurl,
                     'delete_url': reverse('coastalmodels_modelinputdatadelete', args=[imodel.id]),
                     'delete_type': "DELETE"}]

            response = JSONResponse(data, {}, response_mimetype(request))
            response['Content-Disposition'] = 'inline; filename=files.json'
            return response

        return render_to_response('coastalmodels/modelinputdata_add.html',
            {'modelinputdata_form': form, 'modelinput_id': modelinput_id},
            context_instance=RequestContext(request))

    return redirect(reverse("coastalmodels_modelinputlist"))

@login_required
def response_mimetype(request):
    if "application/json" in request.META['HTTP_ACCEPT']:
        return "application/json"
    else:
        return "text/plain"

@login_required
def modelinputdata_delete(request, modelinputdata_id):
    modelinputdata = get_object_or_404(ModelInputData, pk=modelinputdata_id)

    if request.user == modelinputdata.user:
        modelinputdata.delete()
        if request.is_ajax():
            response = JSONResponse(True, {}, response_mimetype(request))
            response['Content-Disposition'] = 'inline; filename=files.json'
            return response

    return redirect(reverse("coastalmodels_modelinputlist"))


@login_required
def modelinput_export(request, modelinput_id):
    modelinput = get_object_or_404(ModelInput, pk=modelinput_id)
    try:
    #    if modelinput.model.name == "SWAN" and modelinput.swaninput:
        return swaninput_export(request, modelinput.swaninput.id)
    #    if modelinput.model.name == "Delft3D":
    #        return delft3d_export(request, modelinput.delft3d_input.id)
    except:
        return redirect(reverse("coastalmodels_modelinputlist"))


@login_required
def swaninput_add(request):
    # sticks in a POST or renders empty form
    form = SWANInputForm(request.user, request.POST or None)
    if form.is_valid():
        swmodel = form.save(commit=False)
        swmodel.user = request.user
        swmodel.time_created = datetime.now()
        swmodel.last_modified = datetime.now()
        swmodel.project = swmodel.model_input.project
        swmodel.model = get_object_or_404(CoastalModel, name='SWAN')
        swmodel.save()
        swmodel.input_dir = swmodel.model_input.input_dir
        swmodel.name = "%s-I%02d" % (swmodel.model_input.name, swmodel.id)
        swmodel.save()
        modelinput = get_object_or_404(ModelInput, pk=swmodel.model_input.id)
        modelinput.parfile_ready = True
        modelinput.upload_parfile = False
        modelinput.save()
        # export to txt file for job submission
        swaninput_exporttxt(swmodel.id)

        return redirect(reverse("coastalmodels_swaninputlist"))

    return render_to_response('coastalmodels/swan/swaninput_add.html',
        {'swaninput_form': form},
        context_instance=RequestContext(request))


@login_required
def swaninput_view(request, swaninput_id):
    # sticks in a POST or renders empty form
    object = get_object_or_404(SWANInput, pk=swaninput_id)
    if request.user == object.user or request.user.groups.filter(name=object.group):
        return render_to_response('coastalmodels/swan/swaninput_detail.html',
            {'object': object},
            context_instance=RequestContext(request))
    else:
        return redirect(reverse("coastalmodels_swaninputlist"))


@login_required
def swaninput_edit(request, swaninput_id):
    # sticks in a POST or renders empty form
    swaninput = get_object_or_404(SWANInput, pk=swaninput_id)

    if request.user != swaninput.user:
        return redirect(reverse("coastalmodels_modelinputlist"))

    form = SWANInputForm(request.user, request.POST or None, instance=swaninput)

    if form.is_valid():
        swmodel = form.save(commit=False)
        #add extra attributes that users shall not add
        swmodel.last_modified = datetime.now()
        swmodel.name = "%s-I%02d" % (swmodel.model_input.name, swmodel.id)
        swaninput_exporttxt(swaninput_id)
        swmodel.save()

        # for illegal request we simply ignore.
        return redirect(reverse("coastalmodels_swaninputlist"))

    else:
        return render_to_response('coastalmodels/swan/swaninput_edit.html',
            {'swaninput_form': form, 'swaninput_id': swaninput_id},
            context_instance=RequestContext(request))


@login_required
def swaninput_delete(request, swaninput_id):
    swaninput = get_object_or_404(SWANInput, pk=swaninput_id)

    if request.user == swaninput.user:
        swaninput.delete()

    # for illegal request we simple ignore.
    return redirect(reverse("coastalmodels_swaninputlist"))

# TODO: move swaninput_modeltodict and swaninput_exporttxt in the model definition
def swaninput_modeltodict(swaninput_id):
    swaninput = get_object_or_404(SWANInput, pk=swaninput_id)
    swaninputdict = SortedDict(swaninput.get_fields())
    #    swaninputdict = SortedDict(model_to_dict(SWANInput.objects.get(pk=swaninput_id),
    #        exclude=['id','user', 'group', 'model_type', 'time_created', 'last_modified']))
    del swaninputdict['ID']
    del swaninputdict['name']
    del swaninputdict['project']
    del swaninputdict['model input']
    del swaninputdict['user']
    del swaninputdict['group']
    del swaninputdict['input dir']
    del swaninputdict['model']
    del swaninputdict['time created']
    del swaninputdict['last modified']
    # reconstruct COMPUTE line before deleting
    swaninputdict['compute'] = "nonst %s %s hr %s" % (
        swaninputdict['time start'], swaninputdict['time interval'], swaninputdict['time end'])
    del swaninputdict['time start']
    del swaninputdict['time end']
    del swaninputdict['time interval']

    return swaninputdict


def swaninput_exporttxt(swaninput_id):
    swaninput = SWANInput.objects.get(pk=swaninput_id)
    swaninputdict = swaninput_modeltodict(swaninput_id)
    swaninput_dir = MEDIA_ROOT + swaninput.input_dir
    mkdir_p(swaninput_dir)
    swaninput_file = os.path.abspath('%s/%s' % (swaninput_dir, swaninput.name))

    if os.path.exists(swaninput_file):
        os.remove(swaninput_file)

    f = open(swaninput_file, 'w')

    for name, value in swaninputdict.items():
        f.write("%s %s\n" % (name, value))
    f.write('stop')
    f.close()


def swaninput_export(request, swaninput_id):
    swaninputdict = swaninput_modeltodict(swaninput_id)
    # we save this
    if swaninputdict:
        response = render_to_response("coastalmodels/swan/swaninput_export.html",
            {'data': swaninputdict}, context_instance=RequestContext(request), mimetype='text/txt')
        response["Content-Disposition"] = "attachment; filename=SWAN_INPUT.txt"
        return response
    return redirect(reverse("coastalmodels_modelinputlist"))


class JSONResponse(HttpResponse):
    """JSON response class."""
    def __init__(self,obj='',json_opts={},mimetype="application/json",*args,**kwargs):
        content = simplejson.dumps(obj,**json_opts)
        super(JSONResponse,self).__init__(content,mimetype,*args,**kwargs)
