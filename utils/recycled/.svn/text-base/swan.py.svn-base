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
        swmodel.group = swmodel.model_input.group
        swmodel.model = get_object_or_404(CoastalModel, name='SWAN')
        swmodel.save()
        swmodel.input_dir = swmodel.model_input.input_dir
        swmodel.name = "%s-I%04d" % (swmodel.model_input.name, swmodel.id)
        swmodel.save()
        modelinput = get_object_or_404(ModelInput, pk=swmodel.model_input.id)
        modelinput.parfile_ready = True
        modelinput.upload_parfile = False
        modelinput.save()
        # export to txt file for job submission
        # swaninput_exporttxt(swmodel.id)

        return redirect(reverse("coastalmodels_swaninputlist"))

    return render_to_response('coastalmodels/swan/swaninput_add.html',
                              {'swaninput_form': form},
                              context_instance=RequestContext(request))
