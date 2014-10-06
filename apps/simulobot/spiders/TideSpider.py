from dateutil import parser
from scrapy.spider import BaseSpider
import datetime

import MySQLdb
import pytz

DB_SETTINGS = {
    'DATABASE_NAME': 'teakwood',
    'DATABASE_USER': 'root',
    'DATABASE_PASSWORD': 'ngchc',
    'DATABASE_HOST': 'localhost',
    'DATABASE_TABLE': 'datafactory_tidedata',
    'DATABASE_TIME_TABLE': 'datafactory_tide_timerecord',
    }

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
                    queue.append({'start':t['end'], 'end':q['end']})
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

        if q['start'] == q['end']:
            remove_list.append(q)

    result = [ elem for elem in queue if elem not in remove_list ]
    return result



class TideSpider(BaseSpider):
    name = "Tide"

    URL_STUB = "http://opendap.co-ops.nos.noaa.gov/axis/webservices/highlowtidepred/response.jsp?stationId={0}&beginDate={1}&endDate={2}&datum=MSL&unit=0&timeZone=0&format=text&Submit=Submit"

    SQL_INSERT_STUB = """
                    INSERT INTO {4} (sid,
                        time, pred, type) VALUES (
                    \"{0}\", \"{1}\", {2}, \"{3}\"
                    )
                """
    DATUM_lst = ["MHHW", "MHW", "DTL", "MTL", "MSL", "MLW", "MLLW", "MAVD", "STND"]

    start_urls = [
    #"http://opendap.co-ops.nos.noaa.gov/axis/webservices/highlowtidepred/response.jsp?stationId=8454000&beginDate=20130606&endDate=20130706&datum=MLLW&unit=0&timeZone=0&format=text&Submit=Submit"
    ]

    content = {}
    def initDB(self):
        try:
            self.db = MySQLdb.connect(host=self.dbhost, user=self.dbuser, passwd=self.dbpwd, db=self.db)
            self.db.query("""
             CREATE TABLE IF NOT EXISTS %s (
             id INT NOT NULL AUTO_INCREMENT PRIMARY  KEY,
             sid CHAR(16) NOT NULL,
             time DATETIME NOT NULL,
             pred FLOAT NOT NULL,
             type CHAR(1) NOT NULL)
            """ % DB_SETTINGS['DATABASE_TABLE'])


            self.db.query("""
             CREATE TABLE IF NOT EXISTS %s (
             id INT NOT NULL AUTO_INCREMENT PRIMARY  KEY,
             sid CHAR(16) NOT NULL,
             stime DATETIME NOT NULL,
             etime DATETIME NOT NULL
            )
            """ % DB_SETTINGS['DATABASE_TIME_TABLE'])

        except Exception as e:
            print 'db err!'

    def get_current_station(self):
        return self.stationID_list[self.station_slot]

    def get_current_datum(self):
        return self.DATUM_lst[self.datum_slot]

    def get_available_time(self, target_station_id):
        #get the available time record
        self.available_time = []
        cursor = self.db.cursor()
        sql_str = "SELECT * FROM {0} WHERE sid = \"{1}\"".format(DB_SETTINGS["DATABASE_TIME_TABLE"], target_station_id)
        cursor.execute(sql_str)
        result = cursor.fetchall()
        for r in result:
            self.available_time.append({'start':(r[2]).replace(tzinfo=pytz.utc),
                                        'end': r[3].replace(tzinfo=pytz.utc)})

    def build_current_station(self):
        self.get_available_time(self.get_current_station())
        self.need_store_time = delta_interval([{'start': self.startDate.astimezone(pytz.utc),
                                                'end': self.endDate.astimezone(pytz.utc)}], self.available_time)

    def __init__(self,
                 stationID="8454000",
                 sDate="2013-06-06 00:00:00 EST-0500",
                 eDate="2013-07-06 23:00:00 EST-0500",

                 user=DB_SETTINGS['DATABASE_USER'],
                 host=DB_SETTINGS['DATABASE_HOST'],
                 pwd=DB_SETTINGS['DATABASE_PASSWORD'],
                 db=DB_SETTINGS['DATABASE_NAME']):
        self.stationID = stationID
        self.stationID_list = stationID.split()#[val for val in stationID.split() for _ in (0, 1)]

        self.startDate = parser.parse(sDate).astimezone(pytz.utc)
        self.endDate = parser.parse(eDate).astimezone(pytz.utc)

        self.sDate = self.startDate.strftime("%Y%m%d")
        self.eDate = self.endDate.strftime("%Y%m%d")

        self.dbuser = user
        self.dbhost = host
        self.dbpwd = pwd
        self.db = db
        self.station_slot = 0
        self.datum_slot = 0
        self.gen_urls()

        self.initDB()
        self.build_current_station()
        pass

    def needStore(self, dtime):
        for interval in self.need_store_time:
            if dtime >= interval['start'] and dtime <= interval['end']:
                return True
        return False

    def gen_urls(self):
        for sid in self.stationID_list:
            urlstr = self.URL_STUB.format(sid, self.sDate, self.eDate)
            print urlstr
            self.start_urls.append(urlstr)

    def parse(self, response):
        reslst = response.body.split('\n')
        slot = 0
        trimslot = 0
        for str in reslst:
			str = str.replace(" ", "")
			if "DateTimePredType" in str:
				trimslot = slot
			slot = slot + 1

        trimlst = reslst[trimslot + 3:]


        newData = False

        for str in trimlst:
            recordlst = str.split()

            if not recordlst:
                continue

            for i in range(1, len(recordlst) - 1, 3):
                timestr = recordlst[0] + " " + recordlst[i]+":00"
                timestr = timestr.replace('/','-')

                d_time_unware = datetime.datetime.strptime(timestr, "%m-%d-%Y %H:%M:%S")
                d_time1 = pytz.utc.localize(d_time_unware)
                d_time = d_time1.astimezone(pytz.utc)

                if self.needStore(d_time):
                    sql_str = self.SQL_INSERT_STUB.format(self.get_current_station().lower(), d_time_unware, recordlst[i + 1], recordlst[i + 2], 'datafactory_tidedata')
                    self.db.query(sql_str)
                    newData = True
                #parse the time
                #if time need to store
                #append to content

        self.db.commit()


        if newData:
            sql_str = "INSERT INTO {0} (sid, stime, etime) VALUES (\"{1}\", \"{2}\", \"{3}\")".format(
                DB_SETTINGS['DATABASE_TIME_TABLE'],
                self.get_current_station(),
                self.startDate.astimezone(pytz.utc).strftime("%Y-%m-%d %H:%M:%S"),
                self.endDate.astimezone(pytz.utc).strftime ("%Y-%m-%d %H:%M:%S")
            )

            self.db.query(sql_str)
            self.db.commit()

        self.station_slot = self.station_slot + 1
        self.datum_slot = 0

        if (self.station_slot < len(self.start_urls)):
            yield self.start_urls[self.station_slot]
