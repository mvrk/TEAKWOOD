#! /usr/bin/env python

import os.path, sys
from xml.dom import minidom
from str2datetime import *

class col_data:
    def __init__(self):
        self.sourcename= ''
        self.colnum = 0
        self.rownum = 0
        self.times = []
        self.data = []
        self.colnames = []
        self.colunits = []
        self.lat = 0
        self.lon = 0
        self.startTime = ''
        self.endTime = ''
    def add_time(self, time):
        self.times.append(time)
    def add_row(self, row):
        if len(row) != self.colnum:
            print 'Wrong number in the input!\n'
            sys.exit(0)
        self.data.append(row)
        self.rownum = self.rownum+1
    def add_elem(self, elem, num):
        if num > self.rownum:
            print 'num must be no larger than rownum! \n'
            sys.exit(0)
        if num == self.rownum:
            self.data.append([])
        self.data[num].append(elem)
    def add_col_attr(self, namestr, unitstr):
        self.colnames.append(namestr)
        self.colunits.append(unitstr)
        self.colnum = self.colnum+1
    def add_sourcename(self, namestr):
        self.sourcename = namestr
    def add_timerange(self, start, end):
        self.startTime = str2datetime(start)
        self.endTime = str2datetime(end)
    def add_location(self, latval, lonval):
        self.lat = latval
        self.lon = lonval
        
def noaa_data_extracting(filename):
    """
    Extracting data from noaa xml
    """
    noaa_data = col_data()
    dom = minidom.parse(filename)
    dataElem = dom.getElementsByTagName("ioos:Quantity")
    timeElem = dom.getElementsByTagName("gml:timePosition")
    colnum = int(dataElem.length/timeElem.length)
    rownum = timeElem.length
    #add timerange
    starttime = dom.getElementsByTagName("gml:beginPosition")[0].firstChild.data
    endtime = dom.getElementsByTagName("gml:endPosition")[0].firstChild.data
    noaa_data.add_timerange(starttime, endtime)
    #add latitute and longitude
    locelem = dom.getElementsByTagName("gml:lowerCorner")
    locstr = locelem[0].firstChild.data.partition(' ')
    noaa_data.add_location(float(locstr[0]), float(locstr[2]))
    #check missing data and update colnum
    misscount = 0
    goodcol = []
    for i in range(colnum):
        if dataElem[i].attributes.getNamedItem('xsi:nil'):
            if dataElem[i].attributes.getNamedItem('xsi:nil').nodeValue == 'true':
                misscount = misscount+1
        else:
            goodcol.append(i)
    oldcolnum = colnum
    colnum = colnum - misscount
    #add names and units
    for i in range(colnum):
        tmpname = dataElem[goodcol[i]].attributes.item(0).nodeValue
        tmpunit = dataElem[goodcol[i]].attributes.item(1).nodeValue
        noaa_data.add_col_attr(tmpname, tmpunit)
    #add times and rows 
    for i in range(rownum):
        tmptime = str2datetime(timeElem[i].firstChild.data)
        noaa_data.add_time(tmptime)
        tmprow = []
        for j in range(colnum):
            tmpvalue = float(dataElem[i*oldcolnum+goodcol[j]].firstChild.data)
            tmprow.append(tmpvalue)
        noaa_data.add_row(tmprow)
    return noaa_data

def write_data_to_end(filename, data_obj):
    #test if it is a new file or an old one
    exists_mark = False
    if not os.path.exists(filename):
        f = open(filename, 'w')
    else:
        exists_mark = True
        f = open(filename, 'a')
    #write the first line (names)
    if not exists_mark:
        f.write('#time')
        for j in range(data_obj.colnum):
            f.write(','+data_obj.colnames[j])
        f.write('\n')
        #write the second line (units)
        #f.write('#yyyy-mm-dd hh:mm:ss')
        #for j in range(data_obj.colnum):
        #    f.write(','+data_obj.colunits[j])
        #f.write('\n')
    #write times and data
    i = 0
    while i < data_obj.rownum:
        if exists_mark and i == 0:
            i += 1
            next()  #jump over the first line(redundant data)
        tmpdtstr = datetime2str2(data_obj.times[i])
        f.write(tmpdtstr+',')
        for j in range(data_obj.colnum):
            tmprow = data_obj.data[i]
            f.write(str(tmprow[j]))
            if j < data_obj.colnum-1:
                f.write(',')
            else:
                f.write('\n')
        i = i+1
    f.close()    
    

        
    
