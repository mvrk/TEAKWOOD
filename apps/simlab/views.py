from django.core.urlresolvers import reverse
from django.db.models import Q
from django.shortcuts import render_to_response, redirect
from django.template import RequestContext
from apps.simfactory.models import Job


def job_compare(request):
    object_list = None
    error_msg = None
    if request.method == 'POST':
        job_list = request.POST.getlist('job_ids')
        object_list = Job.objects.filter(pk__in=job_list)
        if object_list:
            model_id = object_list[0].model_input.model.id
            for j in object_list:
                if j.model_input.model.id != model_id:
                    error_msg = "The selected jobs are associated with different models. You must select jobs running the same model to compare."

    return render_to_response('simlab/job_compare.html',
                              {'object_list': object_list, 'error_msg': error_msg},
                              context_instance=RequestContext(request))
