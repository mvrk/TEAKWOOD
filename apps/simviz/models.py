from django.db import models
from apps.datafactory.models import DataRequest, Station
#from simfactory.models import Job

NDBC_FIELD_TABLE = [
    ('wdir', 'WDIR (deg) (wind direction)'),
    ('wspd', 'WSPD (m/s) (wind speed)'),
    ('gst', 'GST (m/s) (peak 5 or 8 second gust speed)'),
    ('wvht', 'WVHT (m) (significant wave height)'),
    ('dpd', 'DPD (sec) (dominant wave period)'),
    ('apd', 'APD (sec) (average wave period)'),
    ('mwd', 'MWD (deg) (direction from which the waves at DPD are coming'),
    ('pres', 'PRES (hPa) (sea level pressure)'),
    ('atmp', 'ATMP (degC) (air temperature)'),
    ('wtmp', 'WTMP (degC) (sea surface temperature)'),
    ('dewp', 'DEWP (degC) (dewpoint temperature)'),
    ('vis', 'VIS (nmi) (station visibility)'),
    ('tide', 'TIDE (ft) (water level in feet above or below MLLW)'),
    ]

class PlotObs(models.Model):
    data_request = models.ForeignKey(DataRequest)
    field_name = models.CharField(max_length=10, choices=NDBC_FIELD_TABLE)

# this could be added later
MODEL_FIELD_TABLE = [
    ('xwindv', 'x-windv (m/s) (wind velocity along X)'),
    ('ywindv', 'y-windv (m/s) (wind velocity along Y)'),
    ('hs', 'hsig (m) significant wave height'),
    ('dir', 'dir (degr) average wave direction'),
    ('rtp', 'rtpeak (sec) relative peak period'),
    ('per', 'period (sec) average absolute wave period'),
    ('tm01', 'tm01 (sec) average absolute wave period'),
    ('tm02', 'tm02 (sec) zero-crossing period'),
    ('pdi', 'pkdir (degr) direction of peak of the spectrum')
]

class SimTSData(models.Model):
#    job = models.ForeignKey(Job)
    sid = models.ForeignKey(Station)
    time = models.DateTimeField()
    xwindv = models.FloatField()
    ywindv = models.FloatField()
    hs = models.FloatField()
    dir = models.FloatField()
    rtp = models.FloatField()
    per = models.FloatField()
    tm01 = models.FloatField()
    tm02 = models.FloatField()
    pdi = models.FloatField()

    def get_fields(self):
        return [(field.verbose_name, field._get_val_from_obj(self))
                for field in self.__class__._meta.fields]

    def __unicode__(self):
        return unicode(self.id)
        # model for ListViewing project


class PlotSim(models.Model):
#    job = models.ForeignKey(Job)
    sid = models.ForeignKey(Station)
    field_name = models.CharField(max_length=10, choices=MODEL_FIELD_TABLE)