#!/usr/bin/env python
#from tornado.options import _Options

__author__ = 'wuyi'

# append the teakwood_home to be in python path
import sys
#from BeautifulSoup import BeautifulSoup

# on the VM, WSGI works differently. It has trouble with the path.
sys.path.append("../..")

#from scrapy import settings
from scrapy.crawler import CrawlerProcess
from scrapy.conf import settings

from apps.simulobot.spiders.spider import Spider
from apps.simulobot.spiders.CurrentSpider import CurrentSpider
from apps.simulobot.spiders.TideSpider import TideSpider
from apps.simulobot.spiders.USGSSpider import USGSSpider

#from apps.simulobot.spiders.TCSpider import TCSpider
from optparse import OptionParser


def run_curr_scrapy(stationID, startDate, endDate, **kwargs):
    settings.overrides.update({}) # your settings
    crawlerProcess = CrawlerProcess(settings)
    crawlerProcess.install()
    crawlerProcess.configure()
    spider = CurrentSpider(stationID, startDate, endDate)
    crawlerProcess.crawl(spider)
    try:
        crawlerProcess.start()
    except:
        print "error"

def run_usgs_scrapy(stationID, startDate, endDate, **kwargs):
    settings.overrides.update({}) # your settings
    crawlerProcess = CrawlerProcess(settings)
    crawlerProcess.install()
    crawlerProcess.configure()
    spider = USGSSpider(stationID, startDate, endDate)
    crawlerProcess.crawl(spider)
    try:
        crawlerProcess.start()
    except:
        print "error"

def run_tide_scrapy(stationID, startDate, endDate, **kwargs):
    settings.overrides.update({}) # your settings
    crawlerProcess = CrawlerProcess(settings)
    crawlerProcess.install()
    crawlerProcess.configure()
    spider = TideSpider(stationID, startDate, endDate)
    crawlerProcess.crawl(spider)
    try:
        crawlerProcess.start()
    except:
        print "error"


def runscrapy(stationID, startDate, endDate, **kwargs):
    crawlerProcess = CrawlerProcess(settings)
    crawlerProcess.install()
    crawlerProcess.configure()

    spider = Spider(stationID, startDate, endDate)
    crawlerProcess.crawl(spider)
    try:
        crawlerProcess.start()
        crawlerProcess.stop()
        crawlerProcess.uninstall()
    except Exception as e:
        print e



if __name__ == "__main__":
    print "in main!"
    parser = OptionParser()
    parser.add_option("-p", "--provider", dest="provider",
		help="data provider")
    parser.add_option("-s", "--station", dest="station",
        help="station name")

    parser.add_option("-t", "--starttime", dest="starttime",
        help="start name")
    parser.add_option("-e", "--endtime", dest="endtime",
        help="end time")
    options, args = parser.parse_args()
    print options
    print options.station

    #, options['starttime'], options['endtime']
    if options.provider == "NDBC":
        print 'Grabbing NDBC data ...'
        runscrapy(options.station, options.starttime, options.endtime)
    elif options.provider == "CO-OPS-CURRENT":
        print 'Grabbing CO-OPS-CURRENT data ...'
        run_curr_scrapy(options.station, options.starttime, options.endtime)
    elif options.provider == "CO-OPS-TIDE":
        print 'Grabbing CO-OPS-TIDE data ...'
        run_tide_scrapy(options.station, options.starttime, options.endtime)
    elif options.provider == "USGS":
        print 'Grabbing USGS data ...'
        run_usgs_scrapy(options.station, options.starttime, options.endtime)
