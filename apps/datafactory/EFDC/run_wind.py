#which python
import sys
from windspider import WindSpider
from scrapy.crawler import CrawlerProcess
from scrapy.conf import settings

def run_wind_spider(startDate, endDate, **kwargs):
    wind_crawlerProcess = CrawlerProcess(settings)
    wind_crawlerProcess.install()
    wind_crawlerProcess.configure()
    spider2 = WindSpider("dpia1", sys.argv[1], sys.argv[2])

    wind_crawlerProcess.crawl(spider2)
    try:
        wind_crawlerProcess.start()
        wind_crawlerProcess.stop()
        wind_crawlerProcess.uninstall()
    except Exception as e:
        print e


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print
        print "Usage: ", sys.argv[0], " startDateTime endDateTime"
        print "The date time format: yyyy-mm-dd HH:MM:SS"
        print 
        sys.exit(0)
    run_wind_spider(sys.argv[1], sys.argv[2]) 
