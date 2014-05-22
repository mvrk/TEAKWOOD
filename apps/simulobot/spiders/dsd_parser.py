#! /usr/bin/env python
import sys, datetime

class param_descriptor:
    def __init__(self):
        self.pname = ''
        self.ptype = ''
        self.poptions = []
        self.prefix = ''
    def add_name(self, namestr):
        self.pname = namestr
    def add_type(self, typestr):
        self.ptype = typestr
    def add_option(self, x):
        self.poptions.append(x)
    def remove_option(self):
        return self.poptions.pop()
    def add_prefix(self, prestr):
        self.prefix = prestr
    def is_empty(self):
        if self.pname == '':
            return True
        else:
            return False
    
class ds_descriptor:
    def __init__(self):
        self.dsname = ''
        self.dsdesc = ''
        self.baseurl = ''
        self.dsparams = []
    def add_name(self, namestr):
        self.dsname = str(namestr)
    def add_description(self, descstr):
        self.dsdesc = str(descstr)
    def add_baseurl(self, urlstr):
        self.baseurl = str(urlstr)
    def add_param(self, x):
        self.dsparams.append(x)
    def is_empty(self):
        if self.dsname == '':
            return True
        else:
            return False

def parse_dsd_file(filename):
    ds_set = []
    f = open(filename, 'r').readlines()
    tmpdsobj = ds_descriptor()
    tmpparamobj = param_descriptor()
    for line in f:
        #grab the line before '\n'
        line = line.partition('\n')[0]
        #get rid of '\t' and space around the line
        line = line.strip()
        #comments or blank line
        if line.isspace() or line.startswith('#') or line=='': 
            continue
        lineparts = line.partition('=') 
        if lineparts[0] == line:
            print "unrecognized line!\n" #each line must include '='
            sys.exit(0)
        tmplineparts = []
        for i in range(len(lineparts)):
            tmplineparts.append(lineparts[i].strip())
        lineparts = tmplineparts
        if lineparts[0] == 'name': #create a new data source obj
            if not tmpdsobj.is_empty():  #add the last object
                if not tmpparamobj.is_empty():
                    tmpdsobj.add_param(tmpparamobj)
                ds_set.append(tmpdsobj)
                tmpdsobj = ds_descriptor()
                tmpparamobj = param_descriptor()
            tmpdsobj.add_name(lineparts[2])
            continue
        elif tmpdsobj.is_empty():
                print "Data source name must come first! \n"
                sys.exit(0)
        #other properties of a data source (must be declared after name)
        if lineparts[0] == 'baseurl':
            tmpdsobj.add_baseurl(lineparts[2])
            continue
        elif lineparts[0] == 'description':
            tmpdsobj.add_description(lineparts[2])
            continue
        #param name
        if lineparts[0] == 'param':
            if not tmpparamobj.is_empty():
                tmpdsobj.add_param(tmpparamobj)
                tmpparamobj = param_descriptor()
            tmpparamobj.add_name(lineparts[2])
            continue
        elif tmpparamobj.is_empty():
            print "A parameter must come with its name first! \n"
            sys.exit(0)
        #properties associated with a param
        if lineparts[0] == 'type':    
            tmpparamobj.add_type(lineparts[2])
        elif lineparts[0] == 'prefix':
            tmpparamobj.add_prefix(lineparts[2])
        elif lineparts[0] == 'range':
            if tmpparamobj.ptype != 'integer':
                print "Range is only available for integer! \n"
                sys.exit(0)
            linesegs = lineparts[2].partition('-')
            if linesegs[0] == lineparts[2]:
                print "Right format in range: e.g. 5-10 \n"
                sys.exit(0)
            tmplinesegs = []
            for i in range(len(linesegs)):
                tmplinesegs.append(linesegs[i].strip())
            linesegs = tmplinesegs
            tmpparamobj.add_option(int(linesegs[0]))
            tmpparamobj.add_option(int(linesegs[2]))
            tmpdsobj.add_param(tmpparamobj)
            tmpparamobj = param_descriptor() #assume range is the last property of a param
        elif lineparts[0] == 'option':
            tmpparamobj.add_option(lineparts[2])
        elif lineparts[0] == 'startDate':
            if tmpparamobj.ptype != 'timerange':
                print "Date/Time is only available for timerange! \n"
                sys.exit(0)
            linesegs = lineparts[2].partition('-')
            tmpyear = int(linesegs[0])
            linesegs = linesegs[2].partition('-')
            tmpmonth = int(linesegs[0])
            tmpday = int(linesegs[2])
            tmpdate = datetime.date(tmpyear, tmpmonth, tmpday)
            tmpparamobj.add_option(tmpdate)
        elif lineparts[0] == 'startTime':
            if tmpparamobj.ptype != 'timerange':
                print "Date/Time is only available for timerange! \n"
                sys.exit(0)
            if len(tmpparamobj.poptions) != 1:
                print "Option order must be startDate, startTime, endDate and endTime! \n"
                sys.exit(0)
            linesegs = lineparts[2].partition(':')
            tmphour = int(linesegs[0])
            linesegs = linesegs[2].partition(':')
            tmpmin = int(linesegs[0])
            tmpsecond = int(linesegs[2])
            tmpdate = tmpparamobj.remove_option()
            tmpyear = tmpdate.year
            tmpmonth = tmpdate.month
            tmpday = tmpdate.day
            tmpdatetime = datetime.datetime(tmpyear, tmpmonth, tmpday, tmphour, tmpmin, tmpsecond)
            tmpparamobj.add_option(tmpdatetime)
        elif lineparts[0] == 'endDate':
            if tmpparamobj.ptype != 'timerange':
                print "Date/Time is only available for timerange! \n"
                sys.exit(0)
            linesegs = lineparts[2].partition('-')
            tmpyear = int(linesegs[0])
            linesegs = linesegs[2].partition('-')
            tmpmonth = int(linesegs[0])
            tmpday = int(linesegs[2])
            tmpdate = datetime.date(tmpyear, tmpmonth, tmpday)
            tmpparamobj.add_option(tmpdate)
        elif lineparts[0] == 'endTime':
            if tmpparamobj.ptype != 'timerange':
                print "Date/Time is only available for timerange! \n"
                sys.exit(0)
            if len(tmpparamobj.poptions) != 2:
                print "Option order must be startDate, startTime, endDate and endTime! \n"
                sys.exit(0)
            linesegs = lineparts[2].partition(':')
            tmphour = int(linesegs[0])
            linesegs = linesegs[2].partition(':')
            tmpmin = int(linesegs[0])
            tmpsecond = int(linesegs[2])
            tmpdate = tmpparamobj.remove_option()
            tmpyear = tmpdate.year
            tmpmonth = tmpdate.month
            tmpday = tmpdate.day
            tmpdatetime = datetime.datetime(tmpyear, tmpmonth, tmpday, tmphour, tmpmin, tmpsecond)
            tmpparamobj.add_option(tmpdatetime)
            #then add the param into ds and check consistency
            if tmpparamobj.poptions[0] > tmpparamobj.poptions[1]:
                print "Wrong date range! Start date must be earlier.\n"
                sys.exit(0)
            tmpdsobj.add_param(tmpparamobj)
            tmpparamobj = param_descriptor()
    if not tmpdsobj.is_empty():
        if not tmpparamobj.is_empty():
            tmpdsobj.add_param(tmpparamobj)
        ds_set.append(tmpdsobj)
    return ds_set
