@login_required
def delft3dinput_add(request):
    # sticks in a POST or renders empty form
    form = Delft3DInputForm(request.user, request.POST or None)
    if form.is_valid():
        d3dmodel = form.save(commit=False)
        d3dmodel.user = request.user
        d3dmodel.time_created = datetime.now()
        d3dmodel.last_modified = datetime.now()
        d3dmodel.project = d3dmodel.model_input.project
        d3dmodel.group = d3dmodel.model_input.group
        d3dmodel.model = get_object_or_404(CoastalModel, name='Delft3D')
        d3dmodel.save()
        d3dmodel.input_dir = d3dmodel.model_input.input_dir
        d3dmodel.name = "%s-I%04d" % (d3dmodel.model_input.name, d3dmodel.id)
        d3dmodel.save()
        print d3dmodel
        modelinput = get_object_or_404(ModelInput, pk=d3dmodel.model_input.id)
        modelinput.parfile_ready = True
        modelinput.upload_parfile = False
        modelinput.save()
        # export to txt file for job submission
        # delft3dinput_exporttxt(d3dmodel.id)

        return redirect(reverse("coastalmodels_delft3dinputlist"))

    return render_to_response('coastalmodels/delft3d/delft3dinput_add.html',
                              {'delft3dinput_form': form},
                              context_instance=RequestContext(request))

