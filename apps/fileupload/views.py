from datetime import datetime
import os
from django.contrib.auth.decorators import login_required
from django.shortcuts import redirect, get_object_or_404
from apps.coastalmodels.models import ModelInput
from apps.fileupload.models import ModelInputData
from django.views.generic import CreateView, DeleteView

from django.http import HttpResponse
from django.utils import simplejson
from django.core.urlresolvers import reverse

from django.conf import settings
from apps.coastalmodels.models import Delft3DParameters
from pyparsing import Word, Literal, alphas, SkipTo, Regex, Optional, OneOrMore, Suppress, QuotedString
from settings.settings import MEDIA_ROOT


def response_mimetype(request):
    if "application/json" in request.META['HTTP_ACCEPT']:
        return "application/json"
    else:
        return "text/plain"


def d3dmdf2dict(mdf_file):
    d = {}
    parameter = Word(alphas)
    # floatNumber = Regex(r'\d+(\.\d*)?([eE]\+\d+)?')
    floatNumber = Regex(r'-?\d+(\.\d*)?([eE][\+-]\d+)?').setParseAction(lambda s,l,t: [ float(t[0]) ] )
    d3dline = parameter + Suppress('=') + Optional(
        OneOrMore(QuotedString("#", unquoteResults=False)) | OneOrMore(floatNumber))
    for param in d3dline.searchString(file(mdf_file).read()):
        d[param[0].lower()] = ''.join(param[1:])
        # remove comments
    del d['commnt']
    print d
    return d


class ModelInputDataCreateView(CreateView):
    model = ModelInputData
    template_name = "fileupload/modelinputdata_form.html"

    def dispatch(self, *args, **kwargs):
        self.model_input = get_object_or_404(ModelInput, pk=kwargs['modelinput_id'])
        return super(ModelInputDataCreateView, self).dispatch(*args, **kwargs)

    def form_valid(self, form):
        if self.request.user == self.model_input.user:
            f = self.request.FILES.get('file')
            self.object = form.save(commit=False)
            self.object.model_input = self.model_input
            self.object.user = self.request.user
            self.object.group = self.model_input.group

            has_parfile = False
            # if self.object.model_input.model.parfile_name:
            #     if self.object.model_input.model.parfile_name == os.path.basename(f.name):
            #         # has_parfile = True
            #         pass
            # elif self.object.model_input.model.parfile_extension:
            #     if f.name.endswith(self.object.model_input.model.parfile_extension):
            #         has_parfile = True
            #         if self.object.model_input.model.name == u"Delft3D":
            #             d = d3dmdf2dict("%s/%s/%s" %(MEDIA_ROOT, self.object.model_input.input_dir, f.name))
            #             Delft3DParameters.objects.create(**d)

            # fullname = os.path.abspath("%s/%s/%s" % (MEDIA_ROOT, self.object.model_input.input_dir, f.name))
            # if os.path.exists(fullname):
            #     self.object.delete(fullname)
            self.object.save()
            delete_url = reverse("models_modelinputdatadelete",
                                     args=[self.model_input.id, self.object.id])
            data_url = "%s%s/%s" % (settings.MEDIA_URL, self.object.model_input.input_dir, f.name)

            data = [{'name': f.name,
                     'url': data_url,
                     'size': f.size,
                     'thumbnail_url': data_url,
                     'delete_url': delete_url,
                     'delete_type': "POST"
                    }]
            response = JSONResponse(data, response_mimetype(self.request))
            response['Content-Disposition'] = 'inline; filename=files.json'
            return response
        return redirect(reverse("models_modelinputdataadd", args=[self.model_input.id]))

    # additional context
    def get_context_data(self, **kwargs):
        context = super(ModelInputDataCreateView, self).get_context_data(**kwargs)
        object_list = ModelInputData.objects.filter(model_input=self.model_input)
        context['object'] = self.model_input
        context['object_list'] = object_list
        return context


@login_required
def modelinputdata_delete(request, modelinput_id=None, pk=None):
    if modelinput_id == None:
        return redirect(reverse("coastalmodels_modelinputlist"))
    else:
        if pk == None:
            modelinput = get_object_or_404(ModelInput, pk=modelinput_id)
            if request.user == modelinput.user:
                modelinput = get_object_or_404(ModelInput, pk=modelinput_id)
                for modelinputdata in modelinput.inputdatasets.all():
                    modelinputdata.delete()
        else:
            modelinputdata = get_object_or_404(ModelInputData, pk=pk)
            if request.user == modelinputdata.user:
                modelinputdata.delete()
        return redirect(reverse("models_modelinputdataadd", args=[modelinput_id]))

#
#class ModelInputDataDeleteView(DeleteView):
#    model = ModelInputData
#
#    def delete(self, request, *args, **kwargs):
#        self.object = self.get_object()
#        self.object.delete()
#        if request.is_ajax():
#            response = JSONResponse(True, {}, response_mimetype(self.request))
#            response['Content-Disposition'] = 'inline; filename=files.json'
#            return response
#        return redirect(reverse("coastalmodels_modelinputlist"))


class JSONResponse(HttpResponse):
    def __init__(self, obj='', mimetype="application/json", *args, **kwargs):
        content = simplejson.dumps(obj)
        super(JSONResponse, self).__init__(content, mimetype, *args, **kwargs)
