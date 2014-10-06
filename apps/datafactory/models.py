import os
import subprocess
from django.views.generic import ListView
from django.db import models
# from django.contrib.gis.geos import Point
from django.db.models import Q
from django.contrib.auth.models import User, Group
from django.shortcuts import get_object_or_404
from apps.teakwood.models import CommonInfo

import math

import logging
# from settings.settings import MEDIA_ROOT
from settings.settings import SIMULOCEAN_DOMAIN

log = logging.getLogger(__name__)


# Haversine distance
def distance(start, end, unit='km'):
    lat1, lon1 = start
    lat2, lon2 = end
    r = 6371 # km
    dlat = math.radians(lat2 - lat1)
    dlon = math.radians(lon2 - lon1)
    a = math.sin(dlat / 2) * math.sin(dlat / 2) + math.cos(math.radians(lat1)) \
                                                  * math.cos(math.radians(lat2)) * math.sin(dlon / 2) * math.sin(
        dlon / 2)
    c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
    d = r * c
    if unit == 'mile':
        d = d / 1.60934
    return d


class Station(models.Model):
    name = models.CharField(max_length=60, null=False, blank=False)

    # lat and lon
    lat = models.FloatField("Latitude")
    lon = models.FloatField("Longitude")
    source = models.CharField(max_length=10)
    measurement = models.CharField(max_length=10)

    # owner
    provider = models.CharField(max_length=60, null=True, blank=True)
    # name
    description = models.CharField(max_length=120, null=True, blank=True)

# objects = models.GeoManager()

    def __unicode__(self):
        return unicode(self.name)


    def get_url(self):
        if self.source == "NDBC":
            return "http://www.ndbc.noaa.gov/station_page.php?station=%s" % self.name
        elif self.source == "CO-OPS":
            return "http://tidesandcurrents.noaa.gov/cdata/StationInfo?id=%s" % self.name


class DataRequest(CommonInfo):
    stations = models.ManyToManyField(Station)
    provider = models.CharField(max_length=64, null=True, blank=True)
    # this is a text file
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    status = models.PositiveSmallIntegerField(null=True, blank=True)

    # def get_station_list(self):
    #     station_list = self.station_list.split(',')
    #     log.debug(station_list)
    #     return Station.objects.filter(pk__in=station_list)

    def get_fields(self):
        return [(field.verbose_name, field._get_val_from_obj(self))
                for field in self.__class__._meta.fields]

    def __unicode__(self):
        return unicode(self.name)
        # model for ListViewing project

    def submit(self):
        workingdir = os.path.dirname(__file__)
        stations = []
        provider = None
        source = None
        measurement = None
        for s in self.stations.all():
            stations.append(s.name)
            measurement = s.measurement
            source = s.source

        # CO-OPS has current and tide
        if source == 'CO-OPS':
            provider = '%s-%s' % (source, measurement.upper())
        else:
            provider = source

        stations = (' ').join(stations)
        print stations
        runscrapy_cmd = os.path.abspath(
            "%s/runscrapy.py -s \"%s\" -t \"%s\" -e \"%s\" -p \"%s\"" % (os.path.dirname(__file__),
                                                                         stations,
                                                                         self.start_time,
                                                                         self.end_time,
                                                                         provider))
        self.status = 0
        print runscrapy_cmd

        log.info(runscrapy_cmd)

        try:
            p = subprocess.Popen(runscrapy_cmd, cwd=workingdir, shell=True, stdout=subprocess.PIPE,
                                 stderr=subprocess.PIPE)

            output = p.communicate()
            print output[0]
            print output[1]

            err_msg = [x for x in output[1].split('\n') if 'deprecated' not in x and x]
            print "err_msg", err_msg
            if "No data grabbed!" in output[1]:
                self.status = 2
            elif len(err_msg) > 1:
                self.status = 1

        except Exception as e:
            print e
            self.status = 1

        self.save()
        return

        #
        # self.symlink_modeldata()
        # self.create_pbsscript()
        # self.rsync_to_compute()
        # local_dir = os.path.normpath("%s/%s" % (MEDIA_ROOT, self.local_dir))
        # qsub_cmd = "ssh %s@%s qsub %s/%s" % (
        #     self.machine.account, self.machine.hostname, self.remote_dir, self.script_name)
        # log.info(qsub_cmd)
        #
        # try:
        #     p = subprocess.Popen(qsub_cmd, cwd=local_dir, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        #     output = p.communicate()
        #     if output[1]:
        #         log.error(output[1])
        #     if output[0]:
        #         self.jobid = output[0].split('.')[0]
        #
        # except Exception:
        #     raise
        # self.progress = 0
        # self.save()
        # self.get_qstat()


class BuoyData(models.Model):
    sid = models.CharField(max_length=16)
    time = models.DateTimeField()
    wdir = models.IntegerField()
    wspd = models.FloatField()
    gst = models.FloatField()
    wvht = models.FloatField()
    dpd = models.FloatField()
    apd = models.FloatField()
    mwd = models.IntegerField()
    pres = models.FloatField()
    atmp = models.FloatField()
    wtmp = models.FloatField()
    dewp = models.FloatField()
    vis = models.FloatField()
    tide = models.FloatField()

    def get_fields(self):
        return [(field.verbose_name, field._get_val_from_obj(self))
                for field in self.__class__._meta.fields]

    def __unicode__(self):
        return unicode("%s-%s" % (self.sid, self.id))


class BuoyDataList(ListView):
    model = BuoyData

    def get_queryset(self):
        datarequest_id = self.kwargs['datarequest_id']
        self.datarequest = get_object_or_404(DataRequest, pk=datarequest_id)
        if DataRequest.objects.filter(
                        Q(user=self.request.user) |
                        Q(group__in=self.request.user.groups.all())):
            self.group = self.datarequest.group
            sids = []
            for station in self.datarequest.stations.all():
                sids.append(station.name)
            print sids
            return BuoyData.objects.filter(
                Q(sid__in=sids),
                Q(time__gte=self.datarequest.start_time),
                Q(time__lte=self.datarequest.end_time))
        else:
            return None

    def get_context_data(self, **kwargs):
        # Call the base implementation first to get a context
        context = super(BuoyDataList, self).get_context_data(**kwargs)
        # Add in the publisher
        context['datarequest'] = self.datarequest
        context['user'] = self.request.user
        context['group'] = self.group
        return context

        #    objects = BuoyData.objects.filter()

#
#    response = render_to_response("datafactory/datarequest_export.html",
#        {'objects': objects}, context_instance=RequestContext(request), mimetype='text/csv')
#    response['Content-Disposition'] = "attachment; filename=%s_%s%s%s_%s%s%s.csv" % (
#        datarequest.station,
#        datarequest.start_time.year, datarequest.start_time.month, datarequest.start_time.day,
#        datarequest.end_time.year, datarequest.end_time.month, datarequest.end_time.day
#        )
#    return response


class DataRequestList(ListView):
    model = DataRequest

    def get_queryset(self):
        return DataRequest.objects.filter(
            Q(user=self.request.user) |
            Q(group__in=self.request.user.groups.all())).order_by('-id')


# model for ListViewing project
class StationList(ListView):
    model = Station
    #
    # def get_queryset(self):
    #     return Station.objects.filter(
    #         Q(lat__gte=SIMULOCEAN_DOMAIN['LATITUDE_MIN']) & Q(lat__lte=SIMULOCEAN_DOMAIN['LATITUDE_MAX']) & Q(
    #             lon__gte=SIMULOCEAN_DOMAIN['LONGITUDE_MIN']) & Q(lon__lte=SIMULOCEAN_DOMAIN['LONGITUDE_MAX']))


class TideData(models.Model):
    sid = models.CharField(max_length=16)
    time = models.DateTimeField()

    pred = models.FloatField()
    type = models.CharField(max_length=1)

    def get_fields(self):
        return [(field.verbose_name, field._get_val_from_obj(self))
                for field in self.__class__._meta.fields]

    def __unicode__(self):
        return unicode("%s-%s" % (self.sid, self.id))


class TideDataList(ListView):
    model = TideData

    def get_queryset(self):
        datarequest_id = self.kwargs['datarequest_id']
        self.datarequest = get_object_or_404(DataRequest, pk=datarequest_id)
        if DataRequest.objects.filter(
                        Q(user=self.request.user) |
                        Q(group__in=self.request.user.groups.all())):
            self.group = self.datarequest.group
            sids = []
            for station in self.datarequest.stations.all():
                sids.append(station.name)
            print sids
            return TideData.objects.filter(
                Q(sid__in=sids),
                Q(time__gte=self.datarequest.start_time),
                Q(time__lte=self.datarequest.end_time))
        else:
            return None

    def get_context_data(self, **kwargs):
        # Call the base implementation first to get a context
        context = super(TideDataList, self).get_context_data(**kwargs)
        # Add in the publisher
        context['datarequest'] = self.datarequest
        context['user'] = self.request.user
        context['group'] = self.group
        return context


class CurrentData(models.Model):
    sid = models.CharField(max_length=16)
    time = models.DateTimeField()
    currentspd = models.FloatField()
    currentdir = models.FloatField()

    def get_fields(self):
        return [(field.verbose_name, field._get_val_from_obj(self))
                for field in self.__class__._meta.fields]

    def __unicode__(self):
        return unicode("%s-%s" % (self.sid, self.id))


class CurrentDataList(ListView):
    model = CurrentData

    def get_queryset(self):
        datarequest_id = self.kwargs['datarequest_id']
        self.datarequest = get_object_or_404(DataRequest, pk=datarequest_id)
        if DataRequest.objects.filter(
                        Q(user=self.request.user) |
                        Q(group__in=self.request.user.groups.all())):
            self.group = self.datarequest.group
            sids = []
            for station in self.datarequest.stations.all():
                sids.append(station.name)
            return CurrentData.objects.filter(
                Q(sid__in=sids),
                Q(time__gte=self.datarequest.start_time),
                Q(time__lte=self.datarequest.end_time))
        else:
            return None

    def get_context_data(self, **kwargs):
        # Call the base implementation first to get a context
        context = super(CurrentDataList, self).get_context_data(**kwargs)
        # Add in the publisher
        context['datarequest'] = self.datarequest
        context['user'] = self.request.user
        context['group'] = self.group
        return context
