from scrapy.spider import BaseSpider
from scrapy.selector import XmlXPathSelector
from dateutil import parser
import datetime


outfilename = "qser.inp"

class RiverSpider(BaseSpider):
    name = "River"
    URL_STUB = "http://waterdata.usgs.gov/nwis/dv?cb_00060=on&format=rdb&period=&begin_date={1}&end_date={2}&site_no={0}&referred_module=sw"
    start_urls = []



    def __init__(self,
                 sDate="1991-04-05 00:00:00",
                 eDate="1991-04-06 23:00:00",
                 ):
        self.stationID = ""
        self.stationID_list = []

        self.startDate = parser.parse(sDate)
        self.endDate = parser.parse(eDate)

        self.sDate = self.startDate.strftime("%Y-%m-%d")
        self.eDate = self.endDate.strftime("%Y-%m-%d")

        self.station_slot = 0

        self.gen_urls()
        open(outfilename, 'w').close()
        self.sumup = []

    def needStore(self, dtime):
        if dtime >= self.startDate and dtime <= self.endDate:
            return True
        return False

    def gen_urls(self):
        urlstr = self.URL_STUB.format("02469761", self.sDate, self.eDate)
        print urlstr
        self.start_urls.append(urlstr)
        urlstr2 = self.URL_STUB.format("02428400", self.sDate, self.eDate)
        print urlstr2
        self.start_urls.append(urlstr2)



    def parse(self, response):
        open("response", 'wb').write(response.body)

        with open("response") as f:
            content = f.readlines()

        newData = False;
        idx = 0
        for line in content:
            if line[0] == '#':
                continue

            aglst = line.split()
            if aglst[0] == "USGS":
                if (len(aglst) == 9):
                    aglst = aglst[:3] + aglst[7:]
                elif (len(aglst) < 9):
                    aglst = aglst[:3]  + ['0', 'P'] 

                [agency_cd, site_no, thedatetime, discharge, acc] = aglst

                d_time = datetime.datetime.strptime(thedatetime + " 00:00", "%Y-%m-%d %H:%M")

                if self.needStore(d_time):
                    if self.station_slot == 0:
                        self.sumup.append(int(discharge))
                    else:
                        if idx < len(self.sumup):
                            self.sumup[idx] += int(discharge)

                    idx += 1

        self.station_slot = self.station_slot + 1

        if (self.station_slot < len(self.start_urls)):
            yield self.start_urls[self.station_slot]
        else:
            with open(outfilename, 'a') as the_file:
                for index, item in enumerate(self.sumup):
                    the_file.write('{0:.2f}    {1:.2f}   \n'.format(float(index), float(item)))

        return 

