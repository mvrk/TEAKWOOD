from dateutil import parser
from scrapy.spider import BaseSpider
import datetime
outputfile = "pser.inp"




class WaterSpider(BaseSpider):
    name = "Water"

    URL_STUB = "http://opendap.co-ops.nos.noaa.gov/axis/webservices/predictions/response.jsp?stationId={0}&beginDate={1}&endDate={2}&datum=MSL&unit=0&timeZone=0&dataInterval=6&format=text&Submit=Submit"

    start_urls = [
    #"http://opendap.co-ops.nos.noaa.gov/axis/webservices/highlowtidepred/response.jsp?stationId=8454000&beginDate=20130606&endDate=20130706&datum=MLLW&unit=0&timeZone=0&format=text&Submit=Submit"
    ]

    content = {}
    def get_current_station(self):
        return self.stationID_list[self.station_slot]

    def get_current_datum(self):
        return self.DATUM_lst[self.datum_slot]



    def __init__(self,
                 stationID="8735180",
                 sDate="2013-06-06 00:00:00",
                 eDate="2013-07-06 23:00:00",
                 ):
        self.stationID = stationID
        self.stationID_list = stationID.split()#[val for val in stationID.split() for _ in (0, 1)]

        self.recordindex = 0.0;
        self.startDate = parser.parse(sDate)
        self.endDate = parser.parse(eDate)
        self.sDate = self.startDate.strftime("%Y%m%d")
        self.eDate = self.endDate.strftime("%Y%m%d")
       
        open(outputfile, 'w').close()
        self.gen_urls()
        pass

    def needStore(self, dtime):
        if dtime >= self.startDate and dtime <= self.endDate:
            return True
        return False

    def gen_urls(self):
        for sid in self.stationID_list:
            urlstr = self.URL_STUB.format(sid, self.sDate, self.eDate)
            self.start_urls.append(urlstr)

    def parse(self, response):
        reslst = response.body.split('\n')
        slot = 0
        trimslot = 0
        for str in reslst:
			str = str.replace(" ", "")
			if "IDDateTimePred" in str:
				trimslot = slot
			slot = slot + 1

        trimlst = reslst[trimslot + 3:]

        newData = False

        for str in trimlst:
            recordlst = str.split()

            if not recordlst:
                continue
            if len(recordlst) != 4:
                continue

            #print recordlst
            timestr = recordlst[1] + " " + recordlst[2]+":00"
            timestr = timestr.replace('/','-')

            d_time = datetime.datetime.strptime(timestr, "%m-%d-%Y %H:%M:%S")
            if self.needStore(d_time):
			 
                with open(outputfile, 'a') as the_file:
                    the_file.write('{0:.2f}    {1:.2f}   \n'.format(self.recordindex, float(recordlst[3])))
			
                self.recordindex += 1.0


