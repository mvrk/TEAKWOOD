from datetime import datetime
from django.core.exceptions import ObjectDoesNotExist
from django.http import HttpResponse
from django.utils.datastructures import SortedDict
from django.shortcuts import render_to_response, redirect, get_object_or_404
from django.template import RequestContext
from django.contrib.auth.decorators import login_required
from django.core.urlresolvers import reverse
import simplejson
from apps.coastalmodels.forms import SWANConfigForm, Delft3DConfigForm, ModelInputForm, SWANParametersForm, Delft3DParametersForm, FVCOMConfigForm, ADCIRCConfigForm, CaFunwaveConfigForm
from apps.coastalmodels.models import SWANConfig, ModelInput, CoastalModel, Delft3DConfig, Delft3DParameters, SWANParameters, FVCOMConfig,ADCIRCConfig, CaFunwaveConfig

from settings.settings import MEDIA_ROOT
# from utils.recycled.views import swanconfig_exporttxt
from utils.system import mkdir_p
import os


@login_required
def modelinput_add(request, project_id=None):
    if project_id:
        form = ModelInputForm(request.user, request.POST or None, initial={"project": project_id})
    else:
        form = ModelInputForm(request.user, request.POST or None)

    if form.is_valid():
        cmodel = form.save(commit=False)
        cmodel.user = request.user
        cmodel.group = cmodel.project.group

        #        cmodel.project = project
        cmodel.save()

        modelinput = get_object_or_404(ModelInput, pk=cmodel.id)
        cmodel.input_dir = os.path.normpath("%s/M%d/MODELINPUT" % (cmodel.project.cwd, modelinput.id))
        mkdir_p(os.path.abspath("%s/%s" % (MEDIA_ROOT, cmodel.input_dir)))

        cmodel.name = "%s_%s_M%d" % (cmodel.user, cmodel.model.name, cmodel.id)
        cmodel.name = cmodel.name.upper()
        cmodel.save()

        # if cmodel.upload_now:
        #     return redirect(reverse("models_modelinputdataadd", args=[cmodel.id]))
        # else:
        if cmodel.model.config_editor:
            return redirect(os.path.normpath("%s/%s" % (cmodel.model.config_editor, cmodel.id)))
        else:
            return redirect(reverse("coastalmodels_modelinputlist"))
    return render_to_response('coastalmodels/modelinput_add.html',
                              {'form': form},
                              context_instance=RequestContext(request))

# rewrite the modelinput interface to follow "DRY".
@login_required
def modelinput_view(request, modelinput_id):
    modelinput = get_object_or_404(ModelInput, pk=modelinput_id)
    if request.user == modelinput.user or request.user.groups.filter(name=modelinput.group):
        return render_to_response('coastalmodels/modelinput_detail.html',
                                  {'object': modelinput},
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
        cmodel = form.save()
        if cmodel.upload_parfile:
            return redirect(reverse("models_modelinputdataadd", args=[cmodel.id]))
        else:
            return redirect(cmodel.model.input_editor)
            # for illegal request we simple ignore.

    else:
        return render_to_response('coastalmodels/modelinput_edit.html',
                                  {'modelinput_form': form, 'modelinput_id': modelinput_id},
                                  context_instance=RequestContext(request))


@login_required
def modelinput_delete(request, modelinput_id):
    modelinput = get_object_or_404(ModelInput, pk=modelinput_id)
    if request.user == modelinput.user:
        for data in modelinput.inputdatasets.all():
            data.delete()
        modelinput.delete()

    return redirect(reverse("coastalmodels_modelinputlist"))


#@login_required
#def modelinputdata_add(request, modelinput_id):
#    modelinput = get_object_or_404(ModelInput, pk=modelinput_id)
#
#    if request.user == modelinput.user or request.user.groups.filter(name=modelinput.group):
#        # sticks in a POST or renders empty form
#        form = ModelInputDataForm(request.user, request.POST or None, request.FILES)
#        if form.is_valid():
#            if request.FILES == None:
#                raise Http404("No files selected !")
#
#            imodel = form.save(commit=False)
#            imodel.model_input = modelinput
#            imodel.user = request.user
#
#            imodel.project = modelinput.project
#            imodel.group = modelinput.group
#            imodel.model = modelinput.model
#            imodel.time_created = datetime.now()
#            imodel.last_modified = datetime.now()
#            imodel.input_dir = modelinput.input_dir
#            data_dir = "%s/%s_ID" % (imodel.model_input.input_dir, imodel.model_input.name)
#            mkdir_p(os.path.abspath("%s%s" % (MEDIA_ROOT, data_dir)))
#            imodel.save()
##
##            imodel.save()
##            fd = open('%s%s/%s' % (MEDIA_ROOT, data_dir, file['filename']), 'w')
##            fd.write(file['content'])
##            fd.close()
#            return redirect(reverse("coastalmodels_modelinputlist"))
#        return render_to_response('coastalmodels/modelinputdata_add.html',
#            {'modelinputdata_form': form, 'modelinput_id': modelinput_id}, context_instance=RequestContext(request))
#
#    return redirect(reverse("coastalmodels_modelinputlist"))


#@login_required
#def modelinputdata_delete(request, modelinputdata_id):
#    modelinputdata = get_object_or_404(ModelInputData, pk=modelinputdata_id)
#
#    if request.user == modelinputdata.user:
#        modelinputdata.delete()
#    return redirect(reverse("coastalmodels_modelinputlist"))


# @login_required
# def modelinput_export(request, modelinput_id):
#     modelinput = get_object_or_404(ModelInput, pk=modelinput_id)
#     try:
#     #    if modelinput.model.name == "SWAN" and modelinput.swaninput:
#         return swaninput_export(request, modelinput.swaninput.id)
#     #    if modelinput.model.name == "Delft3D":
#     #        return delft3d_export(request, modelinput.delft3d_input.id)
#     except:
#         return redirect(reverse("coastalmodels_modelinputlist"))

@login_required
def swanparameters_add(request, swanconfig_id=None):
    form = SWANParametersForm(request.POST or None)
    if form.is_valid():
        swmodel = form.save(commit=False)
        swmodel.user = request.user

        if swanconfig_id:
            swanconfig = get_object_or_404(SWANConfig, pk=swanconfig_id)
            swmodel.group = swanconfig.group
            swmodel.save()
            swanconfig.parameters = swmodel
            swanconfig.save()
            return redirect(reverse("coastalmodels_swanconfiglist"))
        else:
            swmodel.save()
            return redirect(reverse("coastalmodels_swanparameterslist"))
    return render_to_response('coastalmodels/swan/swanparameters_add.html',
                              {'form': form},
                              context_instance=RequestContext(request))


@login_required
def swanparameters_view(request, swanparameters_id):
    object = get_object_or_404(SWANParameters, pk=swanparameters_id)
    if request.user == object.user or request.user.groups.filter(name=object.group):
        return render_to_response('coastalmodels/swan/swanparameters_detail.html',
                                  {'object': object},
                                  context_instance=RequestContext(request))
    else:
        return redirect(reverse("coastalmodels_swanparameterslist"))


@login_required
def swanparameters_delete(request, swanparameters_id):
    swanparameters = get_object_or_404(SWANParameters, pk=swanparameters_id)
    if request.user == swanparameters.user:
        swanparameters.delete()
    return redirect(reverse("coastalmodels_swanparameterslist"))


@login_required
def swanconfig_add(request, modelinput_id=None):
    if modelinput_id:
        form = SWANConfigForm(request.user, request.POST or None, initial={"model_input": modelinput_id})
    else:
        form = SWANConfigForm(request.user, request.POST or None)

    # sticks in a POST or renders empty form
    # form = SWANConfigForm(request.user, request.POST or None)
    if form.is_valid():
        swmodel = form.save(commit=False)
        swmodel.user = request.user
        # swmodel.project = swmodel.model_input.project
        swmodel.group = swmodel.model_input.group
        # swmodel.model = get_object_or_404(CoastalModel, name='SWAN')
        swmodel.save()
        swmodel.input_dir = swmodel.model_input.input_dir
        swmodel.name = "%s_C%d" % (swmodel.model_input.name, swmodel.id)
        swmodel.save()
        modelinput = get_object_or_404(ModelInput, pk=swmodel.model_input.id)
        modelinput.parfile_ready = True
        modelinput.upload_parfile = False
        modelinput.save()
        # export to txt file for job submission
        # swaninput_exporttxt(swmodel.id)

        return redirect(reverse("coastalmodels_modelinputlist"))

    return render_to_response('coastalmodels/swan/swanconfig_add.html',
                              {'form': form},
                              context_instance=RequestContext(request))

#
#
@login_required
def swanconfig_view(request, swanconfig_id):
    swanconfig = get_object_or_404(SWANConfig, pk=swanconfig_id)
    if request.user == swanconfig.user or request.user.groups.filter(name=swanconfig.group):
        return render_to_response('coastalmodels/swan/swanconfig_detail.html',
                                  {'object': swanconfig},
                                  context_instance=RequestContext(request))
    else:
        return redirect(reverse("coastalmodels_swanconfiglist"))


@login_required
def swanconfig_edit(request, swanconfig_id):
    # sticks in a POST or renders empty form
    swanconfig = get_object_or_404(SWANConfig, pk=swanconfig_id)

    if request.user != swanconfig.user:
        return redirect(reverse("coastalmodels_swanconfiglist"))

    form = SWANConfigForm(request.user, request.POST or None, instance=swanconfig)

    if form.is_valid():
        swmodel = form.save(commit=False)
        swmodel.name = "%s_C%d" % (swmodel.model_input.name, swmodel.id)
        # swanconfig_exporttxt(swanconfig_id)
        swmodel.save()

        # for illegal request we simply ignore.
        return redirect(reverse("coastalmodels_swanconfiglist"))

    else:
        return render_to_response('coastalmodels/swan/swanconfig_edit.html',
                                  {'swanconfig_form': form, 'swanconfig_id': swanconfig_id},
                                  context_instance=RequestContext(request))


@login_required
def swanconfig_delete(request, swanconfig_id):
    swanconfig = get_object_or_404(SWANConfig, pk=swanconfig_id)

    if request.user == swanconfig.user:
        swanconfig.delete()

    # for illegal request we simple ignore.
    return redirect(reverse("coastalmodels_swanconfiglist"))


@login_required
def delft3dparameters_add(request, delft3dconfig_id=None):
    form = Delft3DParametersForm(request.POST or None)
    if form.is_valid():
        d3dmodel = form.save(commit=False)
        d3dmodel.user = request.user
        # d3dmodel.project = d3dmodel.model_input.project
        # d3dmodel.name = "delft3d_parameters_%d" % d3dmodel.id

        if delft3dconfig_id:
            delft3dconfig = get_object_or_404(Delft3DConfig, pk=delft3dconfig_id)
            d3dmodel.group = delft3dconfig.group
            d3dmodel.save()
            delft3dconfig.parameters = d3dmodel
            delft3dconfig.save()
            return redirect(reverse("coastalmodels_delft3dconfiglist"))
        else:
            d3dmodel.save()
            return redirect(reverse("coastalmodels_delft3dparameterslist"))

    return render_to_response('coastalmodels/delft3d/delft3dparameters_add.html',
                              {'form': form},
                              context_instance=RequestContext(request))


@login_required
def delft3dparameters_view(request, delft3dparameters_id):
    d3dpar = get_object_or_404(Delft3DParameters, pk=delft3dparameters_id)
    if request.user == d3dpar.user or request.user.groups.filter(name=d3dpar.group):
        return render_to_response('coastalmodels/delft3d/delft3dparameters_detail.html',
                                  {'object': d3dpar},
                                  context_instance=RequestContext(request))
    else:
        return redirect(reverse("coastalmodels_delft3dparameterslist"))


@login_required
def delft3dparameters_delete(request, delft3dparameters_id):
    delft3dparameters = get_object_or_404(Delft3DParameters, pk=delft3dparameters_id)
    if request.user == delft3dparameters.user:
        delft3dparameters.delete()
    return redirect(reverse("coastalmodels_delft3dparameterslist"))


@login_required
def delft3dconfig_add(request, modelinput_id=None):
    if modelinput_id:
        form = Delft3DConfigForm(request.user, request.POST or None, initial={"model_input": modelinput_id})
    else:
        form = Delft3DConfigForm(request.user, request.POST or None)

    # sticks in a POST or renders empty form
    # form = Delft3DConfigForm(request.user, request.POST or None)
    if form.is_valid():
        d3dmodel = form.save(commit=False)
        d3dmodel.user = request.user
        d3dmodel.project = d3dmodel.model_input.project
        d3dmodel.group = d3dmodel.model_input.group
        d3dmodel.model = get_object_or_404(CoastalModel, name='Delft3D')
        d3dmodel.save()
        d3dmodel.input_dir = d3dmodel.model_input.input_dir
        d3dmodel.name = "%s_C%d" % (d3dmodel.model_input.name, d3dmodel.id)
        d3dmodel.save()
        modelinput = get_object_or_404(ModelInput, pk=d3dmodel.model_input.id)
        modelinput.parfile_ready = True
        modelinput.upload_parfile = False
        modelinput.save()
        # export to txt file for job submission
        # delft3dconfig_exporttxt(d3dmodel.id)

        return redirect(reverse("coastalmodels_modelinputlist"))

    return render_to_response('coastalmodels/delft3d/delft3dconfig_add.html',
                              {'form': form},
                              context_instance=RequestContext(request))


@login_required
def delft3dconfig_view(request, delft3dconfig_id):
    delft3dconfig = get_object_or_404(Delft3DConfig, pk=delft3dconfig_id)
    if request.user == delft3dconfig.user or request.user.groups.filter(name=delft3dconfig.group):
        return render_to_response('coastalmodels/delft3d/delft3dconfig_detail.html',
                                  {'object': delft3dconfig},
                                  context_instance=RequestContext(request))
    else:
        return redirect(reverse("coastalmodels_delft3dconfiglist"))


@login_required
def delft3dconfig_edit(request, delft3dconfig_id):
    delft3dconfig = get_object_or_404(Delft3DConfig, pk=delft3dconfig_id)

    if request.user != delft3dconfig.user:
        return redirect(reverse("coastalmodels_delft3dconfiglist"))

    form = Delft3DConfigForm(request.user, request.POST or None, instance=delft3dconfig)

    if form.is_valid():
        d3dmodel = form.save(commit=False)
        d3dmodel.name = "%s_C%d" % (d3dmodel.model_input.name, d3dmodel.id)
        # if not d3dmodel.nested_model:
        #     d3dmodel.prior_model = None
            #TODO need to export the parameter file
        # delft3dconfig_exporttxt(delft3dconfig_id)
        d3dmodel.save()

        # for illegal request we simply ignore.
        return redirect(reverse("coastalmodels_delft3dconfiglist"))

    else:
        return render_to_response('coastalmodels/delft3d/delft3dconfig_edit.html',
                                  {'form': form, 'delft3dconfig_id': delft3dconfig_id},
                                  context_instance=RequestContext(request))


@login_required
def delft3dconfig_delete(request, delft3dconfig_id):
    delft3dconfig = get_object_or_404(Delft3DConfig, pk=delft3dconfig_id)

    if request.user == delft3dconfig.user:
        delft3dconfig.delete()

    # for illegal request we simple ignore.
    return redirect(reverse("coastalmodels_delft3dconfiglist"))

#
# # TODO: move swaninput_modeltodict and swaninput_exporttxt in the model definition
# def swaninput_modeltodict(swaninput_id):
#     swaninput = get_object_or_404(SWANInput, pk=swaninput_id)
#     swaninputdict = SortedDict(swaninput.get_fields())
#     #    swaninputdict = SortedDict(model_to_dict(SWANInput.objects.get(pk=swaninput_id),
#     #        exclude=['id','user', 'group', 'model_type', 'time_created', 'last_modified']))
#     del swaninputdict['ID']
#     del swaninputdict['name']
#     del swaninputdict['project']
#     del swaninputdict['model input']
#     del swaninputdict['user']
#     del swaninputdict['group']
#     del swaninputdict['input dir']
#     del swaninputdict['model']
#     del swaninputdict['time created']
#     del swaninputdict['last modified']
#     # reconstruct COMPUTE line before deleting
#     swaninputdict['compute'] = "nonst %s %s hr %s" % (
#         swaninputdict['time start'], swaninputdict['time interval'], swaninputdict['time end'])
#     del swaninputdict['time start']
#     del swaninputdict['time end']
#     del swaninputdict['time interval']
#
#     return swaninputdict
#
#
# def swaninput_exporttxt(swaninput_id):
#     swaninput = SWANInput.objects.get(pk=swaninput_id)
#     swaninputdict = swaninput_modeltodict(swaninput_id)
#     swaninput_dir = "%s/%s" %(MEDIA_ROOT, swaninput.input_dir)
#     swaninput_file = os.path.abspath('%s/%s' % (swaninput_dir, swaninput.name))
#
#     if os.path.exists(swaninput_file):
#         os.remove(swaninput_file)
#
#     f = open(swaninput_file, 'w')
#
#     for name, value in swaninputdict.items():
#         f.write("%s %s\n" % (name, value))
#     f.write('stop')
#     f.close()
#
#
# def swanparameters_export(request, swanparameters_id):
#     swaninputdict = swaninput_modeltodict(swanparameters_id)
#     # we save this
#     if swaninputdict:
#         response = render_to_response("coastalmodels/swan/swaninput_export.html",
#             {'data': swaninputdict}, context_instance=RequestContext(request), mimetype='text/txt')
#         response["Content-Disposition"] = "attachment; filename=SWAN_INPUT.txt"
#         return response
#     return redirect(reverse("coastalmodels_modelinputlist"))
#
#
# class JSONResponse(HttpResponse):
#     """JSON response class."""
#
#     def __init__(self, obj='', json_opts=None, mimetype="application/json", *args, **kwargs):
#         content = simplejson.dumps(obj, **json_opts)
#         super(JSONResponse, self).__init__(content, mimetype, *args, **kwargs)

# provide support for FVCOM
@login_required
def fvcomconfig_add(request, modelinput_id=None):
    if modelinput_id:
        form = FVCOMConfigForm(request.user, request.POST or None, initial={"model_input": modelinput_id})
    else:
        form = FVCOMConfigForm(request.user, request.POST or None)

    # sticks in a POST or renders empty form
    # form = FVCOMConfigForm(request.user, request.POST or None)
    if form.is_valid():
        fvcommodel = form.save(commit=False)
        fvcommodel.user = request.user
        # fvcommodel.project = fvcommodel.model_input.project
        fvcommodel.group = fvcommodel.model_input.group
        # fvcommodel.model = get_object_or_404(CoastalModel, name='FVCOM')
        fvcommodel.save()
        fvcommodel.input_dir = fvcommodel.model_input.input_dir
        fvcommodel.name = "%s_C%d" % (fvcommodel.model_input.name, fvcommodel.id)
        fvcommodel.save()
        modelinput = get_object_or_404(ModelInput, pk=fvcommodel.model_input.id)
        modelinput.parfile_ready = True
        modelinput.upload_parfile = False
        modelinput.save()
        # export to txt file for job submission
        # fvcominput_exporttxt(fvcommodel.id)

        return redirect(reverse("coastalmodels_modelinputlist"))

    return render_to_response('coastalmodels/fvcom/fvcomconfig_add.html',
                              {'form': form},
                              context_instance=RequestContext(request))

#
#
@login_required
def fvcomconfig_view(request, fvcomconfig_id):
    fvcomconfig = get_object_or_404(FVCOMConfig, pk=fvcomconfig_id)
    if request.user == fvcomconfig.user or request.user.groups.filter(name=fvcomconfig.group):
        return render_to_response('coastalmodels/fvcom/fvcomconfig_detail.html',
                                  {'object': fvcomconfig},
                                  context_instance=RequestContext(request))
    else:
        return redirect(reverse("coastalmodels_fvcomconfiglist"))


@login_required
def fvcomconfig_edit(request, fvcomconfig_id):
    # sticks in a POST or renders empty form
    fvcomconfig = get_object_or_404(FVCOMConfig, pk=fvcomconfig_id)

    if request.user != fvcomconfig.user:
        return redirect(reverse("coastalmodels_fvcomconfiglist"))

    form = FVCOMConfigForm(request.user, request.POST or None, instance=fvcomconfig)

    if form.is_valid():
        fvcommodel = form.save(commit=False)
        fvcommodel.name = "%s_C%d" % (fvcommodel.model_input.name, fvcommodel.id)
        # fvcomconfig_exporttxt(fvcomconfig_id)
        fvcommodel.save()

        # for illegal request we simply ignore.
        return redirect(reverse("coastalmodels_fvcomconfiglist"))

    else:
        return render_to_response('coastalmodels/fvcom/fvcomconfig_edit.html',
                                  {'fvcomconfig_form': form, 'fvcomconfig_id': fvcomconfig_id},
                                  context_instance=RequestContext(request))


@login_required
def fvcomconfig_delete(request, fvcomconfig_id):
    fvcomconfig = get_object_or_404(FVCOMConfig, pk=fvcomconfig_id)

    if request.user == fvcomconfig.user:
        fvcomconfig.delete()

    # for illegal request we simple ignore.
    return redirect(reverse("coastalmodels_fvcomconfiglist"))


# provide support for CaFunwave
@login_required
def cafunwaveconfig_add(request, modelinput_id=None):
    if modelinput_id:
        form = CaFunwaveConfigForm(request.user, request.POST or None, initial={"model_input": modelinput_id})
    else:
        form = CaFunwaveConfigForm(request.user, request.POST or None)

    # sticks in a POST or renders empty form
    # form = CaFunwaveConfigForm(request.user, request.POST or None)
    if form.is_valid():
        cafunwavemodel = form.save(commit=False)
        cafunwavemodel.user = request.user
        # cafunwavemodel.project = cafunwavemodel.model_input.project
        cafunwavemodel.group = cafunwavemodel.model_input.group
        # cafunwavemodel.model = get_object_or_404(CoastalModel, name='CaFunwave')
        cafunwavemodel.save()
        cafunwavemodel.input_dir = cafunwavemodel.model_input.input_dir
        cafunwavemodel.name = "%s_C%d" % (cafunwavemodel.model_input.name, cafunwavemodel.id)
        cafunwavemodel.save()
        modelinput = get_object_or_404(ModelInput, pk=cafunwavemodel.model_input.id)
        modelinput.parfile_ready = True
        modelinput.upload_parfile = False
        modelinput.save()
        # export to txt file for job submission
        # cafunwaveinput_exporttxt(cafunwavemodel.id)

        return redirect(reverse("coastalmodels_modelinputlist"))

    return render_to_response('coastalmodels/cafunwave/cafunwaveconfig_add.html',
                              {'form': form},
                              context_instance=RequestContext(request))

#
#
@login_required
def cafunwaveconfig_view(request, cafunwaveconfig_id):
    cafunwaveconfig = get_object_or_404(CaFunwaveConfig, pk=cafunwaveconfig_id)
    if request.user == cafunwaveconfig.user or request.user.groups.filter(name=cafunwaveconfig.group):
        return render_to_response('coastalmodels/cafunwave/cafunwaveconfig_detail.html',
                                  {'object': cafunwaveconfig},
                                  context_instance=RequestContext(request))
    else:
        return redirect(reverse("coastalmodels_cafunwaveconfiglist"))


@login_required
def cafunwaveconfig_edit(request, cafunwaveconfig_id):
    # sticks in a POST or renders empty form
    cafunwaveconfig = get_object_or_404(CaFunwaveConfig, pk=cafunwaveconfig_id)

    if request.user != cafunwaveconfig.user:
        return redirect(reverse("coastalmodels_cafunwaveconfiglist"))

    form = CaFunwaveConfigForm(request.user, request.POST or None, instance=cafunwaveconfig)

    if form.is_valid():
        cafunwavemodel = form.save(commit=False)
        cafunwavemodel.name = "%s_C%d" % (cafunwavemodel.model_input.name, cafunwavemodel.id)
        # cafunwaveconfig_exporttxt(cafunwaveconfig_id)
        cafunwavemodel.save()

        # for illegal request we simply ignore.
        return redirect(reverse("coastalmodels_cafunwaveconfiglist"))

    else:
        return render_to_response('coastalmodels/cafunwave/cafunwaveconfig_edit.html',
                                  {'cafunwaveconfig_form': form, 'cafunwaveconfig_id': cafunwaveconfig_id},
                                  context_instance=RequestContext(request))


@login_required
def cafunwaveconfig_delete(request, cafunwaveconfig_id):
    cafunwaveconfig = get_object_or_404(CaFunwaveConfig, pk=cafunwaveconfig_id)

    if request.user == cafunwaveconfig.user:
        cafunwaveconfig.delete()

    # for illegal request we simple ignore.
    return redirect(reverse("coastalmodels_cafunwaveconfiglist"))


# provide support for ADCIRC
@login_required
def adcircconfig_add(request, modelinput_id=None):
    if modelinput_id:
        form = ADCIRCConfigForm(request.user, request.POST or None, initial={"model_input": modelinput_id})
    else:
        form = ADCIRCConfigForm(request.user, request.POST or None)

    # sticks in a POST or renders empty form
    # form = ADCIRCConfigForm(request.user, request.POST or None)
    if form.is_valid():
        adcircmodel = form.save(commit=False)
        adcircmodel.user = request.user
        # adcircmodel.project = adcircmodel.model_input.project
        adcircmodel.group = adcircmodel.model_input.group
        # adcircmodel.model = get_object_or_404(CoastalModel, name='ADCIRC')
        adcircmodel.save()
        adcircmodel.input_dir = adcircmodel.model_input.input_dir
        adcircmodel.name = "%s_C%d" % (adcircmodel.model_input.name, adcircmodel.id)
        adcircmodel.save()
        modelinput = get_object_or_404(ModelInput, pk=adcircmodel.model_input.id)
        modelinput.parfile_ready = True
        modelinput.upload_parfile = False
        modelinput.save()
        # export to txt file for job submission
        # adcircinput_exporttxt(adcircmodel.id)
        # create an instance for ADCIRC_CERA

        return redirect(reverse("coastalmodels_modelinputlist"))

    return render_to_response('coastalmodels/adcirc/adcircconfig_add.html',
                              {'form': form},
                              context_instance=RequestContext(request))

#
#
@login_required
def adcircconfig_view(request, adcircconfig_id):
    adcircconfig = get_object_or_404(ADCIRCConfig, pk=adcircconfig_id)
    if request.user == adcircconfig.user or request.user.groups.filter(name=adcircconfig.group):
        return render_to_response('coastalmodels/adcirc/adcircconfig_detail.html',
                                  {'object': adcircconfig},
                                  context_instance=RequestContext(request))
    else:
        return redirect(reverse("coastalmodels_adcircconfiglist"))


@login_required
def adcircconfig_edit(request, adcircconfig_id):
    # sticks in a POST or renders empty form
    adcircconfig = get_object_or_404(ADCIRCConfig, pk=adcircconfig_id)

    if request.user != adcircconfig.user:
        return redirect(reverse("coastalmodels_adcircconfiglist"))

    form = ADCIRCConfigForm(request.user, request.POST or None, instance=adcircconfig)

    if form.is_valid():
        adcircmodel = form.save(commit=False)
        adcircmodel.name = "%s_C%d" % (adcircmodel.model_input.name, adcircmodel.id)
        # adcircconfig_exporttxt(adcircconfig_id)
        adcircmodel.save()

        # for illegal request we simply ignore.
        return redirect(reverse("coastalmodels_adcircconfiglist"))

    else:
        return render_to_response('coastalmodels/adcirc/adcircconfig_edit.html',
                                  {'adcircconfig_form': form, 'adcircconfig_id': adcircconfig_id},
                                  context_instance=RequestContext(request))


@login_required
def adcircconfig_delete(request, adcircconfig_id):
    adcircconfig = get_object_or_404(ADCIRCConfig, pk=adcircconfig_id)

    if request.user == adcircconfig.user:
        adcircconfig.delete()

    # for illegal request we simple ignore.
    return redirect(reverse("coastalmodels_adcircconfiglist"))
