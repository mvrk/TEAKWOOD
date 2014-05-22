import sys
from optparse import OptionParser
from riverspider import RiverSpider
from scrapy.crawler import CrawlerProcess
from scrapy.conf import settings

def run_river_spider(startDate, endDate, **kwargs):
    water_crawlerProcess = CrawlerProcess(settings)
    water_crawlerProcess.install()
    water_crawlerProcess.configure()


    spider = RiverSpider(sys.argv[1], sys.argv[2])
    water_crawlerProcess.crawl(spider)
    try:
        water_crawlerProcess.start()
        water_crawlerProcess.stop()
        water_crawlerProcess.uninstall()
    except Exception as e:
        print e


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print
        print "Usage: ", sys.argv[0], "-t startDateTime -e endDateTime"
        print "The date time format: yyyy-mm-dd HH:MM:SS"
        print 

    run_river_spider(sys.argv[1], sys.argv[2])    

