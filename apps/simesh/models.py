import math
import os
import string
from pyparsing import Suppress, OneOrMore, Word, nums, Regex, quotedString, removeQuotes

from django.db import models
from django.db.models import Q
from django.core.validators import MaxValueValidator, MinValueValidator
from django.views.generic import ListView
from apps.simulocean.models import CommonInfo
from apps.workflow.models import Project


class Domain(CommonInfo):
    project = models.OneToOneField(Project, related_name="domain")
    start_time = models.DateTimeField("Start time (UTC)")
    end_time = models.DateTimeField("End time (UTC)")
    latitude_min = models.FloatField("Lat min (Deg N)",
                                     validators=[
                                         MaxValueValidator(90),
                                         MinValueValidator(-90)
                                     ])
    longitude_min = models.FloatField("Long min (Deg E)",
                                      validators=[
                                          MaxValueValidator(180),
                                          MinValueValidator(-180)
                                      ])
    latitude_max = models.FloatField("Lat max (Deg N)",
                                     validators=[
                                         MaxValueValidator(90),
                                         MinValueValidator(-90)
                                     ])
    longitude_max = models.FloatField("Long max (Deg E)",
                                      validators=[
                                          MaxValueValidator(180),
                                          MinValueValidator(-180)
                                      ])

    def get_path(self):
        return os.path.normpath("%s/D%d" % (self.project.cwd, self.id))

    def get_fields(self):
        return [(field.verbose_name, field._get_val_from_obj(self))
                for field in self.__class__._meta.fields]

    def __unicode__(self):
        return self.name.strip()


class DomainList(ListView):
    model = Domain

    def get_queryset(self):
        return Domain.objects.filter(
            Q(user=self.request.user) |
            Q(group__in=self.request.user.groups.all())).order_by('-id')


def haversine(start, end, unit='km'):
    lat1, lon1 = start
    lat2, lon2 = end
    r = 6371 # km
    dlat = math.radians(lat2 - lat1)
    dlon = math.radians(lon2 - lon1)
    lat1 = math.radians(lat1)
    lat2 = math.radians(lat2)

    a = math.sin(dlat / 2) * math.sin(dlat / 2) + math.cos(lat1) * math.cos(lat2) * math.sin(dlon / 2) * math.sin(
        dlon / 2)
    d = 2 * r * math.asin(math.sqrt(a))
    if unit == 'mile':
        d = d / 1.60934
    return d


class SimeshPOI(object):
    def __init__(self, grd_file=None, poi_file=None, obs_file=None):
        self.x = []
        self.y = []
        self.nx = 0
        self.ny = 0
        self.grd_file = grd_file
        self.poi_file = poi_file
        self.obs_file = obs_file
        self.latlon = []
        self.index = []

    def parse_grd_file(self):
        global __line

        try:
            f = open(self.grd_file, 'r')
        except:
            raise

        for j in range(0, 6):
            __line = f.next()

        (self.nx, self.ny) = map(int, __line.split())

        print "Grid file %s (%d, %d)" % (self.grd_file, self.nx, self.ny)

        f.close()

        floatNumber = Regex(r'-?\d+(\.\d*)?([eE][\+-]\d+)?').setParseAction(lambda s, l, t: [float(t[0])])
        integer = Word(nums).setParseAction(lambda s, l, t: [long(t[0])])
        grdline = Suppress('ETA=') + Suppress(integer) + OneOrMore(floatNumber)

        for a in grdline.searchString(file(self.grd_file).read()):
            if len(self.x) < self.ny:
                self.x.append(a.asList())
            else:
                self.y.append(a.asList())


    def parse_poi_file(self):

        floatNumber = Regex(r'-?\d+(\.\d*)?([eE][\+-]\d+)?').setParseAction(lambda s, l, t: [float(t[0])])
        integer = Word(nums).setParseAction(lambda s, l, t: [long(t[0])])
        numericValue = floatNumber | integer

        poiline = numericValue + numericValue + quotedString.setParseAction(removeQuotes)
        try:
            for a in poiline.searchString(file(self.poi_file).read()):
                self.latlon.append(a.asList())
                print a.asList()
        except TypeError as e:
            print "failed to open poi file"
            raise

    def delft3d_obs_file(self):
        self.parse_grd_file()
        self.parse_poi_file()

        for k in range(0, len(self.latlon)):
            dist = 10000.0
            idx = 0
            idy = 0
            p = [self.latlon[k][0], self.latlon[k][1]]
            for j in range(0, self.ny):
                for i in range(0, self.nx):
                    # print j,i
                    temp = haversine(p, [self.y[j][i], self.x[j][i]])
                    if temp < dist:
                        dist = temp
                        idx = i
                        idy = j
            self.index.append([self.latlon[k][2], idy, idx])
            print "POI (%f %f) INDEX (%d %d) GRIDLOC (%f %f)\n" % (
                self.latlon[k][0], self.latlon[k][1],
                self.index[k][1], self.index[k][2],
                self.y[self.index[k][1]][self.index[k][2]], self.x[self.index[k][1]][self.index[k][2]])

        f = open(self.obs_file, 'w')
        for idx, indexline in enumerate(self.index):
            f.write("%03d %s %5d %5d\r\n" % (idx, string.rjust(indexline[0], 15)[0:15], indexline[1], indexline[2]))


    def gnuplot_file(self):
        for j in range(0, len(self.y)):
            for i in range(0, len(self.x)):
                print self.x[j][i], self.y[j][i]

                # if __name__ == "__main__":
                #     poi = SimeshPOI(grd_file="new02b.grd", poi_file="simulocean.poi", obs_file='simulocean.obs')
                #     poi.delft3d_obs_file()