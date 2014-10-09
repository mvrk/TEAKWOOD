#!/usr/bin/env python

"""
!!! CAUTIOUS !!!
This script will reset Teakwood database. Only run it when you
know for sure what you are doing. Everything in your database
will be gone once you run this. Database information are from
Django settings file. No input is required for this script.
"""
import os
import datetime
import subprocess
from settings import settings

TEAKWOOD_LOGO = "\n\
===========================================================\n\
             Welcome to TEAKWOOD world!!! \n\
              (c) Copyright to The Authors \n\
	      LGPL Licensed. No Warranty \n\
===========================================================\n"


class TeakwoodInstaller(object):
    def __init__(self):
        """all attributes are private
        """
        self.__db_name = settings.DATABASES["default"]["NAME"]
        self.__db_user = settings.DATABASES["default"]["USER"]
        self.__db_password = "'%s'" % settings.DATABASES["default"]["PASSWORD"]
        self.__db_initsql_dir = "%s/settings/init_sql" % settings.teakwood_home

    def start_celery(self):
        """start celery
        """
        cmd_start_celery = ''

        if settings.TEAKWOOD_AMQP == "rabbitmq":
            cmd_start_celery = '/etc/init.d/celeryd start'
        elif settings.TEAKWOOD_AMQP == "django":
            cmd_start_celery = "nohup %s/manage.py celeryd -v 2 -c 2 -B -s %s/run/celery -E -l INFO -f %s/log/celery.log --pidfile %s/run/celery.pid >/dev/null 2>&1 &" % (
                settings.teakwood_home, settings.teakwood_home, settings.teakwood_home, settings.teakwood_home)

        if cmd_start_celery != '':
            print "start celery daemon ..."
            subprocess.call(cmd_start_celery, shell=True)

    def stop_celery(self):
        """stop celery
        """
        cmd_stop_celery = ''

        if settings.TEAKWOOD_AMQP == "rabbitmq":
            cmd_stop_celery = '/etc/init.d/celeryd stop'
        elif settings.TEAKWOOD_AMQP == "django":
            if os.path.exists("%s/run/celery.pid" % settings.teakwood_home):
                cmd_stop_celery = "kill -15 `cat %s/run/celery.pid`" % settings.teakwood_home

        if cmd_stop_celery != '':
            print "stop celery daemon ..."
            subprocess.call(cmd_stop_celery, shell=True)

    def backup_db(self):
        """back up database
        """
        print "back up teakwood database ..."
        cmd_backup_db = 'mysqldump -u%s -p%s %s > %s/log/%s_%s.sql' \
                        % (self.__db_user,
                           self.__db_password,
                           self.__db_name,
                           settings.teakwood_home,
                           self.__db_name,
                           datetime.date.today())
        subprocess.call(cmd_backup_db, shell=True)

    def drop_db(self):
        """drop old database
        """
        print "drop teakwood database ..."
        cmd_drop_db = 'mysqladmin -u%s -p%s drop %s' % (self.__db_user,
                                                        self.__db_password,
                                                        self.__db_name)
        subprocess.call(cmd_drop_db, shell=True)

    def create_db(self):
        """create a new database
        """
        print "create teakwood database ..."
        cmd_create_db = 'mysqladmin -u%s -p%s create %s' % (self.__db_user,
                                                            self.__db_password,
                                                            self.__db_name)
        subprocess.call(cmd_create_db, shell=True)

    def sync_db(self):
        """make sure we are at the right dir and then synchronize database
        """
        manage_file = "%s/manage.py" % settings.teakwood_home

        cmd_sync_db = 'cd %s; python %s syncdb' % (settings.teakwood_home, manage_file)
        if not os.path.exists(manage_file):
            return "Error: %s doesn't exist" % manage_file
            # syncdb for Django installation
        subprocess.call(cmd_sync_db, shell=True)

    def init_db(self):
        """check all the sql files under settings/init_sql to see
        if we need to initialize any tables.
        this shall be only run once to initialized the database.
        initialize database for Teakwood with sql files under settings/init_sql.
        """
        sql_files = os.listdir(self.__db_initsql_dir)
        for f in sql_files:
            sql_file = os.path.join(self.__db_initsql_dir, f)
            print "initializing tables in the database with " + f + " ..."
            cmd_init_db = 'mysql %s -u%s -p%s < %s' % ( self.__db_name,
                                                        self.__db_user,
                                                        self.__db_password,
                                                        sql_file)

            subprocess.call(cmd_init_db, shell=True)

    def clean_up(self):
        """check all the sql files under teakwood/sql to see
        if we need to initialize any tables.
        this shall be only run once to initialized the database.
        initialize database for Teakwood with sql files under teakwood/init_sql.
        """
        print "cleaning up media/users directory ..."
        cmd_rm_dir = 'rm -rf %s/users/*' % (settings.MEDIA_ROOT)
        subprocess.call(cmd_rm_dir, shell=True)

        cmd_mk_dir = 'mkdir -p %s/log %s/run' % (settings.teakwood_home, settings.teakwood_home)
        subprocess.call(cmd_mk_dir, shell=True)

    def run(self):
        """set up Teakwood
        """
        print TEAKWOOD_LOGO
        self.clean_up()
        self.stop_celery()
        self.backup_db()
        self.drop_db()
        self.create_db()
        self.sync_db()
        self.init_db()
        self.start_celery()


if __name__ == "__main__":
    installer = TeakwoodInstaller()
    installer.run()
