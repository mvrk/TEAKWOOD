#!/bin/python
import csv
import urlparse
import xml.etree.ElementTree as ET
import urllib
import urllib
import os
import zipfile
import datetime
DATAFACTORY_STATIONS = {
    'NDBC': {
        'src_url': 'http://www.ndbc.noaa.gov/activestations.xml',
    },
    'CO-OPS-CURRENT': {
        'src_url': 'http://tidesandcurrents.noaa.gov/cdata/StationListFormat?type=Current%20Data&filter=active&format=csv',
    },
    'CO-OPS-TIDE': {
        'src_url': 'http://tidesandcurrents.noaa.gov/kml/coops-tidepredictions.kmz',
    }
}

stations_file = 'teakwood-stations-%s.csv' % datetime.date.today().isoformat()

# all the stations will be written into one file
fout = open(stations_file, 'wb')
writer = csv.writer(fout, delimiter=';')

# NDBC stations
if DATAFACTORY_STATIONS.has_key('NDBC'):
    src = 'NDBC'
    measurement = 'MET'
    url = DATAFACTORY_STATIONS[src]['src_url']
    ndbc_fn = 'ndbc-stations.xml'
    urllib.urlretrieve(url, ndbc_fn)
    ndbc_file = open(ndbc_fn, 'rb')

    tree = ET.parse(ndbc_file)
    stations = tree.getroot()

    for station in stations:
        writer.writerow(['', station.attrib['id'], station.attrib['lat'], station.attrib['lon'], src, measurement,
                         station.attrib['owner'], "%s(%s)" % (station.attrib['name'], station.attrib['pgm'])])
    ndbc_file.close()

if DATAFACTORY_STATIONS.has_key('CO-OPS-CURRENT'):
    src = 'CO-OPS'
    measurement = 'CURRENT'
    url = DATAFACTORY_STATIONS['CO-OPS-CURRENT']['src_url']
    coops_fn = 'coops-curr-stations.csv'
    urllib.urlretrieve(url, coops_fn)
    coops_file = open(coops_fn, 'rb')

    reader = csv.reader(coops_file, delimiter=',')

    # skip the first line
    next(reader)
    for line in reader:
        writer.writerow(['', line[0], line[2], line[3], src, measurement, line[1], line[4]])
    coops_file.close()

if DATAFACTORY_STATIONS.has_key('CO-OPS-TIDE'):
    src = 'CO-OPS'
    measurement = 'TIDE'
    url = DATAFACTORY_STATIONS['CO-OPS-TIDE']['src_url']
    coops_kmz = 'coops-tide-stations.kmz'
    coops_kml = 'coops-tide-stations.kml'

    urllib.urlretrieve(url, coops_kmz)

    # uncompress kmz file to get kml file
    zfile = zipfile.ZipFile(coops_kmz)
    for name in zfile.namelist():
        (dirname, filename) = os.path.split(name)
        if os.path.exists(dirname):
            os.mkdir(dirname)
        fd = open(coops_kml, 'wb')
        fd.write(zfile.read(name))
        fd.close()

    tree = ET.parse(coops_kml)
    folder = tree.find(".//{http://earth.google.com/kml/2.2}Folder")
    stations = folder.findall(".//{http://earth.google.com/kml/2.2}Placemark")
    for station in stations:
        (lon, lat) = station[1][0].text.split(',')
        writer.writerow(['', station[3].text, lat, lon, src, measurement, station[0].text, station[4].text])

fout.close()
