__author__ = 'wuyi'

import sys
from dateutil import parser
from scrapy.spider import BaseSpider
from scrapy.selector import HtmlXPathSelector
import datetime
from scrapy.http import Request
import os
outputfile = "wser.inp"



MonthStr = [None, "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

#xpaths:
# '/html/body/table[2]/tr/td[3]/ul/li[1]/ul/li[1]/a/text()'
# returns
# [u'Jan', u'Feb', u'Mar', u'Apr', u'May', u'Jun', u'Jul', u'Aug']


#/html/body/table[2]/tr/td[3]/ul/li[1]/b/text()
#returns
#[u'Quality controlled data for 2014']
#use this to check the year

#'/html/body/table[2]/tr/td[3]/ul/li[1]/ul/li[1]/a/@href'
#returns
#[u'/download_data.php?filename=4200112014.txt.gz&dir=data/stdmet/Jan/', u'/download_data.php?filename=4200122014.txt.gz&dir=data/stdmet/Feb/', u'/download_data.php?filename=4200132014.txt.gz&dir=data/stdmet/Mar/', u'/download_data.php?filename=4200142014.txt.gz&dir=data/stdmet/Apr/', u'/download_data.php?filename=4200152014.txt.gz&dir=data/stdmet/May/', u'/download_data.php?filename=4200162014.txt.gz&dir=data/stdmet/Jun/', u'/download_data.php?filename=4200172014.txt.gz&dir=data/stdmet/Jul/', u'data/stdmet/Aug/42001.txt']
#the links.
#analyse the content..
#return Request(self.start_urls[0], callback=self.parse_main, dont_filter=True)


#for previous years:
#'/html/body/table[2]/tr/td[3]/ul/li[2]/ul/li[1]/a/text()'
#returns
#[u'1975', u'1976', u'1977', u'1978', u'1979', u'1980', u'1981', u'1982', u'1983', u'1984', u'1985', u'1986', u'1987', u'1988', u'1989', u'1990', u'1991', u'1992', u'1993', u'1994', u'1995', u'1996', u'1997', u'1998', u'1999', u'2000', u'2001', u'2002', u'2003', u'2004', u'2005', u'2006', u'2007', u'2008', u'2009', u'2010', u'2011']

#for href of the years:
#'/html/body/table[2]/tr/td[3]/ul/li[2]/ul/li[1]/a/@href'




class WindSpider(BaseSpider):
    name = "windspider"
    start_urls = []
    date_list = []
    available_time = []
    need_store_time = []
    data_grabbed = 0
    data_saved = 0



    def generate_date_list(self):
        today = datetime.date.today()
        #in past years, urls are stored in a whole file
        if self.endDate.year < today.year:
            for yr in range(self.startDate.year, self.endDate.year + 1):
                self.date_list.append(datetime.date(yr, 1, 1))
        else:
            for yr in range(self.startDate.year, today.year):
                self.date_list.append(datetime.date(yr, 1, 1))

            if not self.date_list:
                for mn in range(self.startDate.month, self.endDate.month + 1):
                    self.date_list.append(datetime.date(today.year, mn, 1))
            else:
                for mn in range(1, self.endDate.month + 1):
                    self.date_list.append(datetime.date(today.year, mn, 1))

    def get_current_station(self):
        return self.stationID

    def __init__(self,
                 stationID="dpia1",
                 sDate="1991-04-05 00:00:00",
                 eDate="1991-04-05 23:00:00",
                 **kwargs):
        super(WindSpider, self).__init__(self.name, **kwargs)
        open(outputfile, 'w').close()
        self.recordindex = 0;
        self.stationID = stationID
        self.url_slot = 0
        self.stationID_list = stationID.split()
        self.startDate = parser.parse(sDate)
        self.endDate = parser.parse(eDate)

        self.generate_date_list()


        self.start_urls = ["http://www.ndbc.noaa.gov/station_history.php?station=%s" % self.get_current_station()]

    #We need to handle realtime data as well.
    def gen_date_url(self, response, date):
        try:
            hxs = HtmlXPathSelector(response)
            month_data_title = hxs.select('/html/body/table[2]/tr/td[3]/ul/li[1]/b/text()').extract()
            year = int((str(month_data_title[0]).split())[-1])
            if year == date.year:
                #construcut url for the current year
                month_list = [str(mon) for mon in
                              hxs.select('/html/body/table[2]/tr/td[3]/ul/li[1]/ul/li[1]/a/text()').extract()
                ]
                month_str = MonthStr[date.month]

                #last month
                if month_str == month_list[-1]:
                    cur_month_url = "http://www.ndbc.noaa.gov/data/stdmet/{0}/{1}.txt".format(month_str,
                                                                                              self.get_current_station().lower())
                    self.start_urls.append(cur_month_url)

                #has the data
                elif month_str in month_list:
                    #currently has no data, needs to get the real data
                    #href is:
                    #http://www.ndbc.noaa.gov/download_data.php?filename=4200112014.txt.gz&dir=data/stdmet/Jan/
                    #actual is:
                    #http://www.ndbc.noaa.gov/view_text_file.php?filename=4200122014.txt.gz&dir=data/stdmet/Feb/
                    month_urls = [str(mon_url) for mon_url in
                                  hxs.select('/html/body/table[2]/tr/td[3]/ul/li[1]/ul/li[1]/a/@href').extract()
                    ]
                    act_month_url_post_fix = month_urls[date.month - 1].split('?')[-1]
                    act_month_url = 'http://www.ndbc.noaa.gov/view_text_file.php?' + act_month_url_post_fix
                    self.start_urls.append(act_month_url)

                else:
                    #currently has no data, needs to get the real data
                    #get the real time data

                    pass

            elif year > date.year:
                #go for past years
                prev_year_list = [int(yr) for yr in
                                  hxs.select('/html/body/table[2]/tr/td[3]/ul/li[2]/ul/li[1]/a/text()').extract()
                ]

                if date.year in prev_year_list:
                    prev_year_urls = [str(year_url) for year_url in
                                      hxs.select('/html/body/table[2]/tr/td[3]/ul/li[2]/ul/li[1]/a/@href').extract()
                    ]

                    act_year_url_post_fix = prev_year_urls[prev_year_list.index(date.year)].split('?')[-1]
                    act_year_url = 'http://www.ndbc.noaa.gov/view_text_file.php?' + act_year_url_post_fix
                    self.start_urls.append(act_year_url)
        except Exception as e:
            print "..."


    def parse(self, response):
        today = datetime.date.today()
        if self.startDate.date() > today:
            print "date error!"
            raise

        #generate the list of
        for d in self.date_list:
            delta = (today - d).days
            if delta < 0:
                pass
            elif delta == 0:
                # get the 24 real time data
                # get the hour
                for hr in range(0, self.endDate.hour):
                    url = "http://www.ndbc.noaa.gov/data/hourly2/hour_{0}.txt".format(hr)
                    self.start_urls.append(url)

            elif delta < 5:
                url = "http://www.ndbc.noaa.gov/data/5day2/{0}_5day.txt".format(self.get_current_station().upper())
                self.start_urls.append(url)
            elif delta < 45:
                url = "http://www.ndbc.noaa.gov/data/realtime2/{0}.txt".format(self.get_current_station().upper())
                self.start_urls.append(url)
            else:
                self.gen_date_url(response, d)

        yield self.next_request()


    def next_request(self):
        if self.url_slot < len(self.start_urls) - 1:
            #get the current station
            self.url_slot = self.url_slot + 1
            next_url = self.start_urls[self.url_slot]
            if "/hourly2/" in next_url:
                return Request(next_url, callback=self.parse_hourly, dont_filter=True)
            elif "/realtime2/" in next_url:
                return Request(next_url, callback=self.parse_real_day, dont_filter=True)
            else:
                return Request(next_url, callback=self.parse_main, dont_filter=True)
        return None

    def time_delta(self):
        pass

    def parse_hourly(self, response):
        hxs = HtmlXPathSelector(response)
        #datalist = [ str(line) for line in hxs.select('//body/p/text()').extract()[0] ]
        datalist = str(hxs.select('//body/p/text()').extract()[0]).split('\n')
        self.data_grabbed = self.data_grabbed + len(datalist[2:])
        recordlist = []

        for dstr in datalist[2:]:
            if not dstr:
                continue

            try:
                datum = str(dstr).replace('M', '0')

                [station, year, month, day, hour, min, wdir, wspd,
                 gst, wvht, dpd, apd, mwd, pres, atmp, wtmp, dewp, vis, tide] = datum.split()
            except Exception as e:
                print datum

            if station.upper() != self.get_current_station().upper():
                continue

            d_time = datetime.datetime(int(year), int(month), int(day), int(hour), int(min), 0, 0, pytz.UTC)

            if not self.needStore(d_time):
                continue

            time = "%s" % datetime.datetime(int(year), int(month), int(day), int(hour), int(min), 0)

            with open(outputfile, 'a') as the_file:
                the_file.write('{0:.2f}    {1:.2f}    {2:.2f}\n'.format(self.recordindex, float(wspd), float(wdir)))
            self.recordindex = self.recordindex + 1

        yield self.next_request()

    def needStore(self, dtime):
        if dtime >= self.startDate and dtime <= self.endDate:
            return True
        return False

    def parse_core(self, datalist):
        WITH_PYTD_LEN = 19
        PYTD_POS = 16

        recordlist = []
        for dstr in datalist:
            if not dstr:
                continue

            datum = str(dstr).replace('M', '0')
            # realtime data has 19 fields with extra pytd data, which located in the 17 position.
            # pop out the pytd.

            try:
                split_list = datum.split()
                if len(split_list) == WITH_PYTD_LEN:
                    # pop out the penult.
                    pytd = split_list.pop(PYTD_POS)

                if len(split_list) > 16:
                    split_list = split_list[:4] + split_list[5:7]
                elif len(split_list) == 16:
                    split_list = split_list[:6]

                [year, month, day, hour,
                 wdir, wspd] = split_list

                year1 = int(year)
                if year1 < 20:
					year1 += 2000
                if year1 < 100:
					year1 += 1900

                d_time = datetime.datetime(year1, int(str(month)), int(str(day)), int(str(hour)), 
						0, 0)
                #print d_time
                #print self.startDate
                if not self.needStore(d_time):
                    continue

                with open(outputfile, 'a') as the_file:
					the_file.write('{0:.2f}    {1:.2f}    {2:.2f}\n'.format(self.recordindex, float(wspd), float(wdir)))

                self.recordindex = self.recordindex + 1

            except Exception as e:
                print e

        for r in recordlist:
            r.save()

    def parse_main(self, response):
        hxs = HtmlXPathSelector(response)
        datalist = str(hxs.select('//body/p/text()').extract()[0]).split('\n')
        self.data_grabbed = self.data_grabbed + len(datalist[2:])

        self.parse_core(datalist[2:])

        yield self.next_request()


    def parse_real_day(self, response):
        hxs = HtmlXPathSelector(response)
        #datalist = [ str(line) for line in hxs.select('//body/p/text()').extract()[0] ]
        datalist = str(hxs.select('//body/p/text()').extract()[0]).split('\n')

        self.data_grabbed = self.data_grabbed + len(datalist[2:])

        self.parse_core(reversed(datalist[2:]))
        yield self.next_request()


