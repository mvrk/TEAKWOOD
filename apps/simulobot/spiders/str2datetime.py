#! /usr/bin/env python

import datetime

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

def datetime2str2(dtobj):
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
    dtstr = tmpdatestr + ' ' + tmptimestr
    return dtstr


def date2str(dtobj):
    tmpdatestr = str(dtobj.year)+'-'+str(dtobj.month)+'-'+str(dtobj.day)
    return tmpdatestr
