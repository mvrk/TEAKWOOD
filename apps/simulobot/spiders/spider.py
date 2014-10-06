#from django.core.serializers.json import DjangoJSONEncoder

__author__ = 'wuyi'

import pytz
import sys
from dateutil import parser
from scrapy.spider import BaseSpider
from scrapy.selector import HtmlXPathSelector
import datetime
from scrapy.http import Request
import MySQLdb
import os

# os.environ["DJANGO_SETTINGS_MODULE"] = "simulobot.spiders.djangosettings"
#from apps.datafactory.models import BuoyData

# synchronize with Django database settings.
from settings.settings import DATABASES

#
# DATABASES = {
#     'default': {
#         'ENGINE': 'django.contrib.gis.db.backends.mysql', # Add 'postgresql_psycopg2', 'mysql', 'sqlite3' or 'oracle'.
#         'NAME': 'teakwood', # Or path to database file if using sqlite3.
#         'USER': 'root', # Not used with sqlite3.
#         'PASSWORD': 'ngchc', # Not used with sqlite3.
#         'HOST': 'localhost', # Set to empty string for localhost. Not used with sqlite3.
#         'PORT': '', # Set to empty string for default. Not used with sqlite3.
#         'OPTIONS': {
#             'init_command': 'SET storage_engine=MyISAM',
#             }
#     }
# }
#

DJANGO_SETTINGS = {
    'DATABASE_NAME': DATABASES['default']['NAME'],
    'DATABASE_USER': DATABASES['default']['USER'],
    'DATABASE_PASSWORD': DATABASES['default']['PASSWORD'],
    'DATABASE_HOST': DATABASES['default']['HOST'],
    'DATABASE_TABLE': 'datafactory_buoydata',
    'DATABASE_TIME_TABLE': 'datafactory_timerecord'
}

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


def delta_interval(queue, available_time_interval):
    remove_list = []
    for q in queue:
        for t in available_time_interval:
            if q['end'] < t['start']:
                pass
            elif q['start'] < t['start']:
                if q['end'] < t['end']:
                    q['end'] = t['start']
                elif q['end'] >= t['end']:
                    queue.append({'start': t['end'], 'end': q['end']})
                    q['end'] = t['start']
            elif q['start'] >= t['start'] and q['start'] < t['end']:
                if q['end'] < t['end']:
                    remove_list.append(q)
                    break
                elif q['end'] >= t['end']:
                    q['start'] = t['end']
            elif q['start'] >= t['end']:
                pass
            else:
                print "unexpected case"

    result = [elem for elem in queue if elem not in remove_list]
    return result


class Spider(BaseSpider):
    name = "Spider"
    start_urls = []
    date_list = []
    available_time = []
    need_store_time = []
    data_grabbed = 0
    data_saved = 0

    SQL_INSERT_STUB = """
                    INSERT INTO {15} (sid,
                        time, wdir, wspd , gst  ,
                        wvht , dpd, apd  , mwd  ,
                        pres , atmp, wtmp , dewp ,
                        vis  , tide
                    ) VALUES (
                    \"{0}\", \"{1}\", {2}, {3},
                    {4}, {5}, {6}, {7},
                    {8}, {9}, {10}, {11},
                    {12}, {13}, {14}
                    )
                """

    def initDB(self):
        try:
            self.db = MySQLdb.connect(host=self.dbhost, user=self.dbuser, passwd=self.dbpwd, db=self.db)
            self.db.query("""
             CREATE TABLE IF NOT EXISTS %s (
             id INT NOT NULL AUTO_INCREMENT PRIMARY  KEY,
             sid CHAR(16) NOT NULL,
             time DATETIME NOT NULL,
             wdir INT NOT NULL,
             wspd FLOAT NOT NULL,
             gst  FLOAT NOT NULL,
             wvht FLOAT NOT NULL,
             dpd  FLOAT NOT NULL,
             apd  FLOAT NOT NULL,
             mwd  INT NOT NULL,
             pres FLOAT NOT NULL,
             atmp FLOAT NOT NULL,
             wtmp FLOAT NOT NULL,
             dewp FLOAT NOT NULL,
             vis  FLOAT NOT NULL,
             tide FLOAT NOT NULL)
            """ % DJANGO_SETTINGS['DATABASE_TABLE'])


            #create the time table
            self.db.query("""
             CREATE TABLE IF NOT EXISTS %s (
             id INT NOT NULL AUTO_INCREMENT PRIMARY  KEY,
             sid CHAR(16) NOT NULL,
             stime DATETIME NOT NULL,
             etime DATETIME NOT NULL
            )
            """ % DJANGO_SETTINGS['DATABASE_TIME_TABLE'])

        except Exception as e:
            pass

    def needStore(self, dtime):
        for interval in self.need_store_time:
            if dtime >= interval['start'] and dtime <= interval['end']:
                return True
        return False

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

    def get_available_time(self, target_station_id):
        #get the available time record
        self.available_time = []
        cursor = self.db.cursor()
        sql_str = "SELECT * FROM %s WHERE sid = '%s'" % (DJANGO_SETTINGS["DATABASE_TIME_TABLE"], target_station_id)
        print sql_str
        cursor.execute(sql_str)
        result = cursor.fetchall()
        for r in result:
            self.available_time.append({'start': (r[2]).replace(tzinfo=pytz.utc),
                                        'end': r[3].replace(tzinfo=pytz.utc)})

    def get_current_station(self):
        return self.stationID_list[self.station_slot]

    def build_current_station(self):
        self.url_slot = 0
        self.get_available_time(self.get_current_station())
        self.need_store_time = delta_interval([{'start': self.startDate.astimezone(pytz.utc),
                                                'end': self.endDate.astimezone(pytz.utc)}], self.available_time)


    def __init__(self,
                 stationID="42001",
                 sDate="2014-10-05 00:00:00",
                 eDate="2014-10-05 23:00:00",
                 user=DJANGO_SETTINGS['DATABASE_USER'],
                 host=DJANGO_SETTINGS['DATABASE_HOST'],
                 pwd=DJANGO_SETTINGS['DATABASE_PASSWORD'],
                 db=DJANGO_SETTINGS['DATABASE_NAME'],
                 **kwargs):
        super(Spider, self).__init__(self.name, **kwargs)

        self.stationID = stationID
        self.stationID_list = stationID.split()
        self.startDate = parser.parse(sDate)
        self.endDate = parser.parse(eDate)

        self.dbuser = user
        self.dbhost = host
        self.dbpwd = pwd
        self.db = db

        self.station_slot = 0

        self.generate_date_list()

        self.initDB()

        self.start_urls = ["http://www.ndbc.noaa.gov/station_history.php?station=%s" % self.get_current_station()]
        self.build_current_station()

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
        else:
            #write inquery time data in database
            if self.data_grabbed == 0:
                sys.stderr.write("No data grabbed!")
            else:
                print "%d records saved!" % self.data_saved
                sql_str = "INSERT INTO %s (sid, stime, etime) VALUES (\"%s\", \"%s\", \"%s\")" % (
                    DJANGO_SETTINGS['DATABASE_TIME_TABLE'],
                    self.get_current_station(),
                    self.startDate.astimezone(pytz.utc).strftime("%Y-%m-%d %H:%M:%S"),
                    self.endDate.astimezone(pytz.utc).strftime("%Y-%m-%d %H:%M:%S")
                )

                self.db.query(sql_str)
                self.db.commit()

            #go to next station
            if self.station_slot < len(self.stationID_list) - 1:
                self.station_slot = self.station_slot + 1
                self.start_urls = []
                self.build_current_station()
                self.start_urls = [
                    "http://www.ndbc.noaa.gov/station_history.php?station=%s" % self.get_current_station()]
                return Request(self.start_urls[0], callback=self.parse, dont_filter=True)

            return None

    def time_delta(self):
        pass


    def parse_hourly(self, response):
        hxs = HtmlXPathSelector(response)
        #datalist = [ str(line) for line in hxs.select('//body/p/text()').extract()[0] ]
        cur = self.db.cursor()
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

            #insert data to db
            sql_str = self.SQL_INSERT_STUB.format(self.get_current_station().lower(), time,
                                                  wdir, wspd, gst, wvht, dpd, apd, mwd, pres,
                                                  atmp, wtmp, dewp, vis, tide, 'datafactory_buoydata')

            self.db.query(sql_str)
            self.data_saved = self.data_saved + 1

        self.db.commit()

        yield self.next_request()

    def parse_core(self, datalist):
        WITH_PYTD_LEN = 19
        PYTD_POS = 17

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
                [year, month, day, hour, min,
                 wdir, wspd, gst, wvht, dpd,
                 apd, mwd, pres, atmp, wtmp, dewp, vis,
                 tide] = split_list

                d_time = datetime.datetime(int(year), int(month), int(day), int(hour), int(min), 0, 0, pytz.UTC)

                if not self.needStore(d_time):
                    continue

                time = "%s" % datetime.datetime(int(year), int(month), int(day), int(hour), int(min), 0)

                #insert data to db
                sql_str = self.SQL_INSERT_STUB.format(self.get_current_station().lower(), time,
                                                      wdir, wspd, gst, wvht, dpd, apd, mwd, pres,
                                                      atmp, wtmp, dewp, vis, tide, 'datafactory_buoydata')

                self.db.query(sql_str)
                self.data_saved = self.data_saved + 1

            except Exception as e:
                print sql_str
                print e

        for r in recordlist:
            r.save()

    def parse_main(self, response):
        hxs = HtmlXPathSelector(response)
        cur = self.db.cursor()
        datalist = str(hxs.select('//body/p/text()').extract()[0]).split('\n')
        self.data_grabbed = self.data_grabbed + len(datalist[2:])

        self.parse_core(datalist[2:])

        self.db.commit()
        yield self.next_request()


    def parse_real_day(self, response):
        hxs = HtmlXPathSelector(response)
        #datalist = [ str(line) for line in hxs.select('//body/p/text()').extract()[0] ]
        cur = self.db.cursor()
        datalist = str(hxs.select('//body/p/text()').extract()[0]).split('\n')

        self.data_grabbed = self.data_grabbed + len(datalist[2:])

        self.parse_core(reversed(datalist[2:]))
        self.db.commit()
        yield self.next_request()


