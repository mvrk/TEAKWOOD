# Create your views here.
import csv
import os
#import netCDF4 as nc
from django.http import HttpResponse
import numpy as np
from django.contrib.auth.decorators import login_required
from django.contrib.sites.models import Site
from django.core.urlresolvers import reverse
from django.db.models import Q
from django.shortcuts import render_to_response, redirect, get_object_or_404
from django.template import RequestContext
from apps.simesh.models import Domain
from apps.simesh.forms import DomainForm
from apps.datafactory.models import Station
import logging
from utils.simlib import station_poi_list

log = logging.getLogger(__name__)

# @login_required
# def simesh_domain(request):
#     return render_to_response('simesh/mesh.html', context_instance=RequestContext(request))
#

# def domain_add(request):
#     return render_to_response('simesh/mesh.html', context_instance=RequestContext(request))
from settings.settings import MEDIA_ROOT
from utils.system import mkdir_p, render_to_file, exportfile


@login_required
def domain_add(request, project_id=None):
    if project_id:
        form = DomainForm(request.POST or None, initial={"project": project_id})
    else:
        form = DomainForm(request.POST or None)

    # form = DomainForm(request.POST or None)
    if form.is_valid():
        dmodel = form.save(commit=False)
        dmodel.user = request.user
        dmodel.group = dmodel.project.group
        #        cmodel.project = project
        dmodel.save()

        dmodel.name = "%s_%s_D%d" % (dmodel.user, dmodel.project.name, dmodel.id)
        dmodel.name = dmodel.name.upper()

        domain_dir = os.path.normpath("%s/D%d" % (dmodel.project.cwd, dmodel.id))
        mkdir_p(os.path.abspath("%s/%s" % (MEDIA_ROOT, domain_dir)))
        domain_exportpoi_txt(dmodel.id)
        domain_exportpoi_marker(request, dmodel.id)
        dmodel.save()

        return redirect(reverse("simesh_domainlist"))
    return render_to_response('simesh/domain_add.html',
                              {'form': form},
                              context_instance=RequestContext(request))


def domain_view(request, domain_id):
    # sticks in a POST or renders empty form
    domain = get_object_or_404(Domain, pk=domain_id)
    site = Site.objects.get_current()
    if request.user == domain.user or request.user.groups.filter(name=domain.group):
        return render_to_response('simesh/domain_detail.html',
                                  {'object': domain, 'url': "http://%s" % site},
                                  context_instance=RequestContext(request))
    else:
        return redirect(reverse("simesh_domainlist"))


@login_required
def domain_delete(request, domain_id):
    domain = get_object_or_404(Domain, pk=domain_id)

    # we delete the entry by keep the data
    if request.user == domain.user:
        domain.delete()

        # for illegal request we simple ignore.
    return redirect(reverse("simesh_domainlist"))


@login_required
def domain_poilist(domain):
    stations = Station.objects.filter(
        Q(lat__gte=domain.latitude_min) & Q(lat__lte=domain.latitude_max) & Q(lon__gte=domain.longitude_min) & Q(
            lon__lte=domain.longitude_max))
    return station_poi_list(stations)

# we need request to get the full url for the output text file.
@login_required
def domain_exportpoi_html(request, domain_id):
    domain = get_object_or_404(Domain, pk=domain_id)
    poi_list = domain_poilist(domain)
    response = render_to_response("simesh/poi_template.html",
                                  {'poi_list': poi_list}, context_instance=RequestContext(request), mimetype='text/txt')
    response["Content-Disposition"] = "attachment; filename= teakwood.poi"
    return response


def domain_exportpoi_txt(domain_id):
    domain = get_object_or_404(Domain, pk=domain_id)
    poi_list = domain_poilist(domain)
    domain_dir = os.path.normpath("%s/D%d" % (domain.project.cwd, domain.id))
    poi_file = os.path.normpath("%s/%s/teakwood.poi" % (MEDIA_ROOT, domain_dir))
    log.debug(poi_file)
    try:
        render_to_file(poi_file, 'simesh/poi_template.html', {"poi_list": poi_list})
    except Exception:
        raise


@login_required
def domain_exportpoi_marker(request, domain_id):
    domain = get_object_or_404(Domain, pk=domain_id)
    poi_list = domain_poilist(domain)
    domain_dir = os.path.normpath("%s/D%d" % (domain.project.cwd, domain.id))
    poi_file = open(os.path.normpath("%s/%s/teakwood_marker.txt" % (MEDIA_ROOT, domain_dir)), 'wb')
    poi_writer = csv.writer(poi_file, delimiter='\t')
    poi_writer.writerow(['lat', 'lon', 'title', 'icon', 'iconSize', 'iconOffset', 'description'])
    for poi in poi_list:
        poi_writer.writerow(
            [poi['lat'], poi['lon'], poi['title'], poi['icon'], poi['iconSize'], poi['iconOffset'],
             poi['description']])
    log.debug(poi_file)


@login_required
def domain_export_depth(request, domain_id):

    domain = get_object_or_404(Domain, pk=domain_id)

    depth_fin_name = os.path.abspath("%s/%s" % (MEDIA_ROOT, "data/bathymetry/nCHC_3_Arc_2011.nc"))
    depth_fout_name=os.path.normpath("%s/%s/teakwood_depth.nc" % (MEDIA_ROOT, domain.get_path()))

    depth_fout = nc.Dataset(depth_fout_name,'w')

    idx_min = depth_index(depth_fin_name, (domain.latitude_min, domain.longitude_min))

    print idx_min

    idx_max = depth_index(depth_fin_name, (domain.latitude_max, domain.longitude_max))

    if idx_min == None or idx_max == None:
        return render_to_response('simesh/domain_detail.html',
                                  {'object': domain, 'error': "no depth file available in the delected region"},
                                  context_instance=RequestContext(request))

    print idx_max

    ny = idx_max[0] - idx_min[0]
    nx = idx_max[1] - idx_min[1]

    depth_in = nc.Dataset(depth_fin_name).variables['height']
    lat_in = nc.Dataset(depth_fin_name).variables['lat']
    lon_in = nc.Dataset(depth_fin_name).variables['lon']

# creat eoutput arrays
    depth_out = np.empty((ny, nx))
    lat_out = np.empty((ny))
    lon_out = np.empty((nx))

# set output arrays
    depth_out[:] = np.NAN

    depth_out = depth_in[idx_min[0]: idx_max[0], idx_min[1]: idx_max[1]]
    lat_out[:] = lat_in[idx_min[0]: idx_max[0]]
    lon_out[:] = lon_in[idx_min[1]: idx_max[1]]

# set dimensions
    depth_fout.createDimension('lon', nx)
    depth_fout.createDimension('lat', ny)

# create variables
    lat = depth_fout.createVariable('lat', np.dtype('float32').char, 'lat')
    lon = depth_fout.createVariable('lon', np.dtype('float32').char, 'lon')
    depth = depth_fout.createVariable('height', np.dtype('float32').char, ('lat', 'lon'))

    depth[:] = depth_out
    lat[:] = lat_out
    lon[:] = lon_out

    depth_fout.close()

    return exportfile(fin_name=depth_fout_name, fout_name="teakwood_depth.nc", content_type='application/x-netcdf')

# using Jerry's stage 2 arc 3 data
# input (lat, lon) outout (idx_lat, idx_lon)
def depth_index(depth_file, latlon):
    _lat, _lon = latlon

    d = nc.Dataset(depth_file, 'r')
    lon_list = d.variables['lon']
    lat_list = d.variables['lat']

    idx_lat = None
    idx_lon = None

    for i, lat in enumerate(lat_list):
        if _lat >= lat_list[i - 1] and _lat <= lat:
            idx_lat = i
            # print lat_list[i - 1], _lat, lat, idx_lat
    for j, lon in enumerate(lon_list):
        if _lon >= lon_list[j - 1] and _lon <= lon:
            idx_lon = j
            # print lon_list[j - 1], _lon, lon, idx_lon
    d.close()
    if idx_lat and idx_lon:
        return (idx_lat, idx_lon)
    else:
        return None

# def depth_nc (file, idx_min, idx_max)
