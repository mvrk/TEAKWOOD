__author__ = 'wuyi'

import sys
from curl_data import *
#from symbol import yield_expr
import datetime

def noaa_url_construction(noaatype, stationid, obsprpty, startdate, starttime, enddate, endtime, datum):
    if noaatype == 1:
        baseurl = "http://opendap.co-ops.nos.noaa.gov/ioos-dif-sos/SOS?service=SOS&request=GetObservation&version=1.0.0&responseFormat=text/xml;schema=%22ioos/0.6.1%22"
    elif noaatype == 2:
        baseurl = "http://sdf.ndbc.noaa.gov/sos/server.php?request=GetObservation&service=SOS&version=1.0.0&responseFormat=text/xml;schema=%22ioos/0.6.1%22"
    offering = "offering=urn:ioos:station:NOAA.NOS.CO-OPS:"+str(stationid)
    prpty = "observedProperty="+obsprpty
    eventtime = "eventTime="+startdate+"T"+starttime+"Z/"+enddate+"T"+endtime+"Z"
    prefix_datum = "result=VerticalDatum%3D%3Durn:x-noaa:def:datum:"
    if datum == "NAVD":
        result = "epsg::5103"
    else:
        result = "noaa::"+datum
    cmburl = baseurl+"&"+offering+"&"+prpty+"&"+eventtime
    return cmburl

def str2datetime(dtstring):
    #string like 2011-04-25T18:00:00Z
    tmpstr = dtstring.partition('T')
    date = tmpstr[0]
    time = tmpstr[2]
    year = int(date.partition('-')[0])
    month = int(date.partition('-')[2].partition('-')[0])
    day = int(date.partition('-')[2].partition('-')[2])
    time = time.partition('Z')[0]
    hour = int(time.partition(':')[0])
    minute = int(time.partition(':')[2].partition(':')[0])
    second = int(time.partition(':')[2].partition(':')[2])
    dt = datetime.datetime(year, month, day, hour, minute, second)
    return dt


data_interval = datetime.timedelta(3,0)

class timerange_list:
    def __init__(self):
        self.start = []
        self.end = []
        self.interval = datetime.timedelta(0)
        self.length = 0
    def add_timerange(self, starttime, endtime):
        if not isinstance(starttime, datetime.datetime) or not isinstance(endtime, datetime.datetime):
            print 'the input time must be of the class datetime.datetime! \n'
            sys.exit(0)
        self.start.append(starttime)
        self.end.append(endtime)
        self.length = self.length+1
    def add_interval(self, intvl):
        if not isinstance(intvl, datetime.timedelta):
            print 'the interval must be of the class datetime.timedelta! \n'
            sys.exit(0)
        self.interval = intvl


def sep_date_range(startdate, enddate, interval):
    if not isinstance(startdate, datetime.datetime) or not isinstance(enddate, datetime.datetime):
        print 'the input dates must be of the class datetime.datetime! \n'
        sys.exit(0)
    if not isinstance(interval, datetime.timedelta):
        print 'the interval must be of the class datetime.timedelta! \n'
        sys.exit(0)
    trl = timerange_list()
    timediff = enddate-startdate
    rangecount = float(timediff.days*24*3600+timediff.seconds)/float(interval.days*24*3600+interval.seconds)
    if int(rangecount) < rangecount:
        rangecount = int(rangecount)+1
    else:
        rangecount = int(rangecount)

    trl.add_interval(interval)
    tmpstart = startdate
    for i in range(rangecount):
        tmpend = tmpstart+interval
        if tmpend > enddate:
            tmpend = enddate
        trl.add_timerange(tmpstart, tmpend)
        tmpstart = tmpstart + interval
    return trl

def datetime2str(dtobj):
    tmpyear = str(dtobj.year)
    tmpmonth = str(dtobj.month)
    tmpday = str(dtobj.day)
    if len(tmpyear) < 4:
        print 'Wrong year! \n'
        sys.exit(0)
    while len(tmpmonth) < 2:
        tmpmonth = '0'+tmpmonth
    while len(tmpday) < 2:
        tmpday = '0'+tmpday
    tmpdatestr = tmpyear+'-'+tmpmonth+'-'+tmpday
    tmphour = str(dtobj.hour)
    tmpminute = str(dtobj.minute)
    tmpsecond = str(dtobj.second)
    while len(tmphour) < 2:
        tmphour = '0'+tmphour
    while len(tmpminute) < 2:
        tmpminute = '0'+tmpminute
    while len(tmpsecond) < 2:
        tmpsecond = '0'+tmpsecond
    tmptimestr = tmphour+':'+tmpminute+':'+tmpsecond
    dtstr = tmpdatestr + 'T' + tmptimestr+ 'Z'
    return dtstr

##
# archive_data_by_date('test.txt', '2011-01-25T00:00:00Z', '2011-04-10T00:00:00Z', 'co-ops-sos', [8761724, "winds", "noaa::MLLW"])
##
def gen_urls(startstr, endstr, ds_name, urlargs=[]):
    startdate = str2datetime(startstr)
    enddate = str2datetime(endstr)
    #generate individual time ranges
    url_lists = []
    tr_list = sep_date_range(startdate, enddate, data_interval)
    for i in range(tr_list.length):
        moreargs = []
        tmptimerange = datetime2str(tr_list.start[i])
        tmptimerange = tmptimerange+'/'+datetime2str(tr_list.end[i])
        moreargs.extend(urlargs)
        moreargs.append(tmptimerange)
        #generate url
        tmpurl = url_construction(ds_name, moreargs)
        url_lists.append(tmpurl)

    return url_lists
