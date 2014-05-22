#! /usr/bin/env python
import os

from dsd_parser import *
from str2datetime import *

#example url as follows:
#http://opendap.co-ops.nos.noaa.gov/ioos-dif-sos/SOS?service=SOS&request=GetObservation&version=1.0.0&responseFormat=text/xml;schema=%22ioos/0.6.1%22&offering=urn:ioos:station:NOAA.NOS.CO-OPS:8764044&observedProperty=water_surface_height_above_reference_datum&eventTime=2011-04-25T16:25:00Z/2011-04-28T11:59:00Z&result=VerticalDatum%3D%3Durn:ioos:def:datum:noaa::MLLW
ds_set = parse_dsd_file("noaa_data_source.txt")

def url_construction(ds_name, args=[]):
   #get the ds descriptor object from ds_set
    flag = False
    for dsobj in ds_set:
        if dsobj.dsname == ds_name:
            flag = True
            break
    if flag == False:
        print "Data source is not loaded. Please check the data source file! \n"
        return ''
    if len(dsobj.dsparams) != len(args):
        print "Arguments can't match data source descriptor! \n"
        return ''

    cmburl = dsobj.baseurl
    #check arguments
    count = 0
    for arg in args:
        urlseg = '&'+dsobj.dsparams[count].pname+'='
        if len(dsobj.dsparams[count].poptions) >0 :
            #check to see if arguments appear in the option list
            if dsobj.dsparams[count].ptype == 'string':
                if dsobj.dsparams[count].poptions.count(arg) == 0:
                    print "The argument "+arg+" is not declared in data source! \n"
                    return ''
            elif dsobj.dsparams[count].ptype == 'integer':
                if int(arg) < dsobj.dsparams[count].poptions[0] or int(arg) > dsobj.dsparams[count].poptions[1]:
                    print 'The argument '+str(arg)+' is out of range! \n'
            elif dsobj.dsparams[count].ptype == 'timerange':
                #extract the string to save as a datetime object
                tmpdatetime = arg.partition('/')
                tmpdatetime1 = str2datetime(tmpdatetime[0])
                tmpdatetime2 = str2datetime(tmpdatetime[2])
                if tmpdatetime1 > dsobj.dsparams[count].poptions[1] or tmpdatetime1 < dsobj.dsparams[count].poptions[0]:
                    print "Time out of range! \n"
                    return ''
                if tmpdatetime2 > dsobj.dsparams[count].poptions[1] or tmpdatetime2 < dsobj.dsparams[count].poptions[0]:
                    print "Time out of range! \n"
                    return ''
        #construct the parameter in url
        urlseg = urlseg+dsobj.dsparams[count].prefix+str(arg)
        cmburl = cmburl + urlseg
        count = count +1
    return cmburl

def curl_data_to_file(inurl, filename, ext="xml"):
    cmdstr = "curl "+"\""+ inurl+"\""+" >"+filename+"."+ext
    os.system(cmdstr)
