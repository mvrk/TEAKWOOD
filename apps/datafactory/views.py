import csv
from django.contrib.sites.models import Site
from django.core.exceptions import PermissionDenied
from django.shortcuts import render_to_response
from django.template import RequestContext
from django.shortcuts import redirect, get_object_or_404
from django.contrib.auth.decorators import login_required, user_passes_test
import time
import simplejson
from apps.datafactory.forms import DataRequestForm
from apps.datafactory.models import DataRequest, Station, CurrentData, TideData
from django.core.urlresolvers import reverse
from apps.datafactory.models import BuoyData
from django.db.models import Q
from django.http import HttpResponse
import subprocess
import os
from settings.settings import SIMULOCEAN_DOMAIN
from apps.simfactory.models import Job
from utils.simlib import station_poi_list


@login_required
def station_poilist(request):
    stations = Station.objects.filter(
        Q(lat__gte=SIMULOCEAN_DOMAIN['LATITUDE_MIN']) & Q(lat__lte=SIMULOCEAN_DOMAIN['LATITUDE_MAX']) & Q(
            lon__gte=SIMULOCEAN_DOMAIN['LONGITUDE_MIN']) & Q(lon__lte=SIMULOCEAN_DOMAIN['LONGITUDE_MAX']))
    return station_poi_list(stations)


# we need request to get the full url for the output text file.
@login_required
@user_passes_test(lambda u: u.is_superuser)
def station_exportmarker(request):
    poi_list = station_poilist(request)
    # domain_dir = os.path.normpath("%s/D%d" % (domain.project.cwd, domain.id))
    # poi_file = open(os.path.normpath("%s/%s/simulocean_marker.txt" % (MEDIA_ROOT, domain_dir)), 'wb')
    response = HttpResponse(content_type='text/csv')
    response["Content-Disposition"] = "attachment; filename= simulocean_station.csv"
    poi_writer = csv.writer(response, delimiter='\t')
    poi_writer.writerow(['lat', 'lon', 'title', 'icon', 'iconSize', 'iconOffset', 'description'])
    for poi in poi_list:
        poi_writer.writerow(
            [poi['lat'], poi['lon'], poi['title'], poi['icon'], poi['iconSize'], poi['iconOffset'],
             poi['description']])
    return response


@login_required
def datarequest_mapview(request):
    stations = Station.objects.filter(
        Q(lat__gte=SIMULOCEAN_DOMAIN['LATITUDE_MIN']) & Q(lat__lte=SIMULOCEAN_DOMAIN['LATITUDE_MAX']) & Q(
            lon__gte=SIMULOCEAN_DOMAIN['LONGITUDE_MIN']) & Q(lon__lte=SIMULOCEAN_DOMAIN['LONGITUDE_MAX']))
    #
    # stations = Station.objects.filter(
    #     Q(lat__gte=15) & Q(lat__lte=33) & Q(lon__gte=-99) & Q(lon__lte=-84))

    site = Site.objects.get_current()

    return render_to_response('datafactory/station_mapview.html',
                              {'stations': stations, 'url': "http://%s" % site},
                              context_instance=RequestContext(request))


@login_required
def datafactory_opendap(request, job_id=None):
    if job_id:
        job = get_object_or_404(Job, pk=job_id)
    else:
        job = None
    return render_to_response('datafactory/datafactory_opendap.html',
                              {'job': job}, context_instance=RequestContext(request))


@login_required
def datarequest_add(request):
    object_list = None
    error_msg = None
    #
    # # sticks in a POST or renders empty form
    form = DataRequestForm(request.POST or None)

    if form.is_valid() and request.method == 'POST':
        drmodel = form.save(commit=False)
        #add extra attributes that users shall not add

        drmodel.user = request.user
        drmodel = form.save(commit=True)

        station_list = request.POST.getlist('station_list')
        if not station_list:
            error_msg = 'You need to select at least one station.'

        station = None
        for s in station_list:
            station = Station.objects.get(pk=s)
            drmodel.stations.add(station)

        drmodel.provider = station.source

        if station.source == 'CO-OPS':
            drmodel.provider = '%s-%s' % (station.source, station.measurement.upper())
        drmodel.save()
        drmodel.name = "%s_%s_DR%d" % (drmodel.user, drmodel.provider, drmodel.id)
        drmodel.name = drmodel.name.upper()
        drmodel.submit()
        return redirect(reverse("datafactory_datarequestlist"))
    stations = Station.objects.all()
    # stations = Station.objects.filter(
    #     Q(lat__gte=SIMULOCEAN_DOMAIN['LATITUDE_MIN']) & Q(lat__lte=SIMULOCEAN_DOMAIN['LATITUDE_MAX']) & Q(
    #         lon__gte=SIMULOCEAN_DOMAIN['LONGITUDE_MIN']) & Q(lon__lte=SIMULOCEAN_DOMAIN['LONGITUDE_MAX']))
    return render_to_response('datafactory/datarequest_add.html',
                              {'datarequest_form': form, 'object_list': stations,
                               'error_msg': error_msg},
                              context_instance=RequestContext(request))


@login_required
def datarequest_edit(request, datarequest_id):
    # sticks in a POST or renders empty form
    datarequest = get_object_or_404(DataRequest, pk=datarequest_id)

    if request.user != datarequest.user:
        return redirect(reverse("datafactory_datarequestlist"))

    form = DataRequestForm(request.POST or None, instance=datarequest)

    if form.is_valid():
        drmodel = form.save(commit=False)
        #add extra attributes that users shall not add
        drmodel.save()

        # for illegal request we simple ignore.
        return redirect(reverse("datafactory_datarequestlist"))

    else:
        return render_to_response('datafactory/datarequest_edit.html',
                                  {'datarequest_form': form, 'datarequest_id': datarequest_id},
                                  context_instance=RequestContext(request))


def datarequest_view(request, datarequest_id):
    # sticks in a POST or renders empty form
    datarequest = get_object_or_404(DataRequest, pk=datarequest_id)

    if request.user == datarequest.user or request.user.groups.filter(name=datarequest.group):
        return render_to_response('datafactory/datarequest_detail.html',
                                  {'object': datarequest},
                                  context_instance=RequestContext(request))
    else:
        return redirect(reverse("datafactory_datarequestlist"))


@login_required
def datarequest_delete(request, datarequest_id):
    datarequest = get_object_or_404(DataRequest, pk=datarequest_id)

    # we delete the entry by keep the data
    if request.user == datarequest.user:
        datarequest.delete()
        # for illegal request we simple ignore.
    return redirect(reverse("datafactory_datarequestlist"))


@login_required
def datarequest_buoyexportcsv(request, datarequest_id):
    datarequest = get_object_or_404(DataRequest, pk=datarequest_id)

    sids = []
    for station in datarequest.stations.all():
        sids.append(station.name)

    buoydata = BuoyData.objects.filter(Q(time__gte=datarequest.start_time), Q(time__lte=datarequest.end_time),
                                       Q(sid__in=sids))

    response = HttpResponse(content_type='text/csv')
    response["Content-Disposition"] = "attachment; filename= %s.csv" % datarequest.name

    writer = csv.writer(response, delimiter='\t')
    # poi_writer.writerow(['lat', 'lon', 'title', 'icon', 'iconSize', 'iconOffset', 'description'])
    for b in buoydata:
        writer.writerow(
            [b.id, b.sid, b.time, b.wdir, b.wspd, b.gst, b.wvht, b.dpd, b.apd, b.mwd, b.pres, b.atmp, b.wtmp, b.dewp,
             b.vis, b.tide])
    return response


@login_required
def datarequest_currentexportcsv(request, datarequest_id):
    datarequest = get_object_or_404(DataRequest, pk=datarequest_id)

    sids = []
    for station in datarequest.stations.all():
        sids.append(station.name)

    currentdata = CurrentData.objects.filter(Q(time__gte=datarequest.start_time), Q(time__lte=datarequest.end_time),
                                             Q(sid__in=sids))

    response = HttpResponse(content_type='text/csv')
    response["Content-Disposition"] = "attachment; filename= %s.csv" % datarequest.name

    writer = csv.writer(response, delimiter='\t')
    # poi_writer.writerow(['lat', 'lon', 'title', 'icon', 'iconSize', 'iconOffset', 'description'])
    for c in currentdata:
        writer.writerow(
            [c.id, c.sid, c.time, c.currentspd, c.currentdir])
    return response


@login_required
def datarequest_tideexportcsv(request, datarequest_id):
    datarequest = get_object_or_404(DataRequest, pk=datarequest_id)

    sids = []
    for station in datarequest.stations.all():
        sids.append(station.name)

    tidedata = TideData.objects.filter(Q(time__gte=datarequest.start_time), Q(time__lte=datarequest.end_time),
                                       Q(sid__in=sids))

    response = HttpResponse(content_type='text/csv')
    response["Content-Disposition"] = "attachment; filename= %s.csv" % datarequest.name

    writer = csv.writer(response, delimiter='\t')
    # poi_writer.writerow(['lat', 'lon', 'title', 'icon', 'iconSize', 'iconOffset', 'description'])
    for t in tidedata:
        writer.writerow([t.id, t.sid, t.time, t.pred, t.type])
    return response

# we will output the data to user in multiple forms
# @login_required
# def datarequest_exportcsv(request, datarequest_id):
#     datarequest = get_object_or_404(DataRequest, pk=datarequest_id)
#
#     objects = BuoyData.objects.filter(Q(time__gte=datarequest.start_time), Q(time__lte=datarequest.end_time),
#                                       Q(sid__in=datarequest.stations.name))
#
#     response = render_to_response("datafactory/datarequest_exportcsv.html",
#                                   {'objects': objects}, context_instance=RequestContext(request), mimetype='text/csv')
#     response['Content-Disposition'] = "attachment; filename=%s_%s%s%s_%s%s%s.csv" % (
#         datarequest.stations,
#         datarequest.start_time.year, datarequest.start_time.month, datarequest.start_time.day,
#         datarequest.end_time.year, datarequest.end_time.month, datarequest.end_time.day
#     )
#     return response
#

@login_required
def datarequest_exportjson(request, datarequest_id, field_name):
    json = []
    datarequest = get_object_or_404(DataRequest, pk=datarequest_id)
    objects = BuoyData.objects.filter(Q(time__gte=datarequest.start_time), Q(time__lte=datarequest.end_time),
                                      Q(sid__in=datarequest.stations))
    value_list = objects.values_list('time', field_name)

    for t, v in value_list:
        json.append([int(time.mktime(t.timetuple())) * 1000, float(v)])
    json = simplejson.dumps(json)
    return HttpResponse(json, mimetype="application/json")


# from geraldo import Report, landscape, ReportBand, ObjectValue, SystemField, \
#     BAND_WIDTH, Label
#
# from reportlab.lib.pagesizes import A4
# from reportlab.lib.units import cm
# from reportlab.lib.enums import TA_RIGHT, TA_CENTER
#
#
# class ReportRequest(Report):
#     title = 'Report'
#     author = 'NGCHC Scgate'
#
#     page_size = landscape(A4)
#     margin_left = 2 * cm
#     margin_top = 2 * cm
#     margin_right = 2 * cm
#     margin_bottom = 2 * cm
#
#
#     class band_page_header(ReportBand):
#         height = 1.3 * cm
#         elements = [
#             SystemField(expression='%(report_title)s', top=0.1 * cm, left=0, width=BAND_WIDTH,
#                         style={'fontName': 'Helvetica-Bold', 'fontSize': 14, 'alignment': TA_CENTER}),
#             Label(text="ID", top=0.8 * cm, left=0.5 * cm),
#             Label(text="Station ID", top=0.8 * cm, left=2.5 * cm),
#             Label(text="Time", top=0.8 * cm, left=7.5 * cm),
#             Label(text="Wind Direction", top=0.8 * cm, left=11.5 * cm),
#             Label(text="Wind Speed", top=0.8 * cm, left=17 * cm),
#             Label(text="Wind Gust", top=0.8 * cm, left=20 * cm),
#             SystemField(expression=u'Page %(page_number)d of %(page_count)d', top=0.1 * cm,
#                         width=BAND_WIDTH, style={'alignment': TA_RIGHT}),
#         ]
#         borders = {'bottom': True}
#
#     class band_page_footer(ReportBand):
#         height = 0.5 * cm
#         elements = [
#             Label(text='Geraldo Reports', top=0.1 * cm),
#             SystemField(expression=u'Printed in %(now:%Y, %b %d)s at %(now:%H:%M)s', top=0.1 * cm,
#                         width=BAND_WIDTH, style={'alignment': TA_RIGHT}),
#         ]
#         borders = {'top': True}
#
#
#     class band_detail(ReportBand):
#         height = 0.5 * cm
#         elements = [
#             ObjectValue(attribute_name='id', left=0.5 * cm),
#             ObjectValue(attribute_name='sid', left=3 * cm),
#             ObjectValue(attribute_name='time', left=5.5 * cm),
#             ObjectValue(attribute_name='wdir', left=13 * cm),
#             ObjectValue(attribute_name='wspd', left=17 * cm),
#             ObjectValue(attribute_name='gst', left=20 * cm),
#         ]
#
#
# from geraldo.generators import PDFGenerator
#
#
# def report(request, datarequest_id):
#     datarequest = get_object_or_404(DataRequest, pk=datarequest_id)
#     resp = HttpResponse(mimetype='application/pdf')
#     objects = BuoyData.objects.filter(Q(time__gte=datarequest.start_time), Q(time__lte=datarequest.end_time),
#                                       Q(sid__exact=datarequest.stations))
#     report = ReportRequest(queryset=objects)
#     report.generate_by(PDFGenerator, filename=resp)
#
#     return resp