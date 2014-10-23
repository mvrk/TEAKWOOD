# Django settings for TEAKWOOD
import os, sys, socket

import djcelery
djcelery.setup_loader()

# an extra join is necessary due to the file structure used.
teakwood_home = os.path.normpath(os.path.join(os.path.dirname(__file__), os.path.pardir))

# we have the following options now for the celery broker. More could be easily added 
# http://docs.celeryproject.org/en/latest/getting-started/brokers/index.html

# 'django'   : Using the Django Database
# 'rabbitmq' : Using RabbitMQ
# 'redis'    : Using Redis

HOSTNAME = socket.gethostname()

if HOSTNAME == "localhost.localdomain" or "guojiarui@gmail.com":
    SITE_ID = 1
    DEBUG = True
    TEAKWOOD_AMQP = 'rabbitmq'
    DATABASES = {
        'default': {
            # 'ENGINE': 'django.contrib.gis.db.backends.mysql',
            'ENGINE': 'django.db.backends.mysql',
            # Add 'postgresql_psycopg2', 'mysql', 'sqlite3' or 'oracle'.
            'NAME': 'TEAKWOOD', # Or path to database file if using sqlite3.
            'USER': 'root', # Not used with sqlite3.
            'PASSWORD': '699622', # Not used with sqlite3.
            'HOST': 'localhost', # Set to empty string for localhost. Not used with sqlite3.
            'PORT': '', # Set to empty string for default. Not used with sqlite3.
            # 'OPTIONS': {
            #     'init_command': 'SET storage_engine=MyISAM',
            # }
        }
    }

elif HOSTNAME == "teakwood":
    SITE_ID = 3
    DEBUG = True
    TEAKWOOD_AMQP = 'rabbitmq'
    DATABASES = {
        'default': {
            # 'ENGINE': 'django.contrib.gis.db.backends.mysql',
            'ENGINE': 'django.db.backends.mysql',
            # Add 'postgresql_psycopg2', 'mysql', 'sqlite3' or 'oracle'.
            'NAME': 'TEAKWOOD', # Or path to database file if using sqlite3.
            'USER': 'root', # Not used with sqlite3.
            'PASSWORD': '699622', # Not used with sqlite3.
            'HOST': 'localhost', # Set to empty string for localhost. Not used with sqlite3.
            'PORT': '', # Set to empty string for default. Not used with sqlite3.
            # 'OPTIONS': {
            #     'init_command': 'SET storage_engine=MyISAM',
            # }
        }
    }

# for production systems. RabbitMQ works better. You can config your own system by following 
# the example below.

elif HOSTNAME == "http://dare.cct.lsu.edu/teakwood":
    SITE_ID = 2
    DEBUG = False
    TEAKWOOD_AMQP = 'rabbitmq'
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.mysql',
            'NAME': 'TEAKWOOD', # Or path to database file if using sqlite3.
            'USER': 'root', # Not used with sqlite3.
            'PASSWORD': '699622', # Not used with sqlite3.
            'HOST': 'localhost', # Set to empty string for localhost. Not used with sqlite3.
            'PORT': '', # Set to empty string for default. Not used with sqlite3.
        }
    }

else:
    DEBUG = False
    TEAKWOOD_AMQP = 'django'

    # set your database information here
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.mysql',
            'NAME': 'TEAKWOOD', # Or path to database file if using sqlite3.
            'USER': 'root', # Not used with sqlite3.
            'PASSWORD': '699622', # Not used with sqlite3.
            'HOST': 'localhost', # Set to empty string for localhost. Not used with sqlite3.
            'PORT': '', # Set to empty string for default. Not used with sqlite3.
        }
    }

sys.path.insert(0, os.path.join(teakwood_home, 'apps'))

TEMPLATE_DEBUG = DEBUG

ADMINS = (
    ('Rui Guo', 'guojiarui@gmail.com'),
)

MANAGERS = ADMINS

# Local time zone for this installation. Choices can be found here:
# http://en.wikipedia.org/wiki/List_of_tz_zones_by_name
# although not all choices may be available on all operating systems.
# In a Windows environment this must be set to your system time zone.
TIME_ZONE = 'America/Chicago'
DATE_FORMAT = 'Y-m-d'
DATETIME_FORMAT = 'Y-m-d h:m'
# Language code for this installation. All choices can be found here:
# http://www.i18nguy.com/unicode/language-identifiers.html
LANGUAGE_CODE = 'en-us'


# If you set this to False, Django will make some optimizations so as not
# to load the internationalization machinery.
USE_I18N = True

# If you set this to False, Django will not format dates, numbers and
# calendars according to the current locale.
USE_L10N = False

# If you set this to False, Django will not use timezone-aware datetimes.
USE_TZ = True

# Absolute filesystem path to the directory that will hold user-uploaded files.
# Example: "/home/media/media.lawrence.com/media/"

# TODO this is a specific setup for TEAKWOOD if we don't have enough space on the VM.
# we have to rely on mounted external storage for this.
if HOSTNAME == "localhost:8000":
    # MEDIA_ROOT = ' '
    MEDIA_ROOT = "/media/"

else:
    MEDIA_ROOT = os.path.normpath(os.path.join(teakwood_home, 'media/').replace('\\', '/'))

# URL that handles the media served from MEDIA_ROOT. Make sure to use a
# trailing slash.
# Examples: "http://media.lawrence.com/media/", "http://example.com/media/"
MEDIA_URL = ' '
# MEDIA_URL = '/media/

# Absolute path to the directory static files should be collected to.
# Don't put anything in this directory yourself; store your static files
# in apps' "static/" subdirectories and in STATICFILES_DIRS.
# Example: "/home/media/media.lawrence.com/static/"
STATIC_ROOT = os.path.normpath(os.path.join(teakwood_home, 'static/').replace('\\', '/'))

# URL prefix for static files.
# Example: "http://media.lawrence.com/static/"
STATIC_URL = '/static/'

# Additional locations of static files
STATICFILES_DIRS = ('/doc/',
                    # Put strings here, like "/home/html/static" or "C:/www/django/static".
                    # Always use forward slashes, even on Windows.
                    # Don't forget to use absolute paths, not relative paths.
)

# List of finder classes that know how to find static files in
# various locations.
STATICFILES_FINDERS = (
    'django.contrib.staticfiles.finders.FileSystemFinder',
    'django.contrib.staticfiles.finders.AppDirectoriesFinder',
    #    'django.contrib.staticfiles.finders.DefaultStorageFinder',
)

# Make this unique, and don't share it with anybody.
SECRET_KEY = '3u89!ho#)uge%b@7%h(q@m^^=@7$0_ydrm%#s^6(-m4ife1=e5'

# List of callables that know how to import templates from various sources.
TEMPLATE_LOADERS = (
    'django.template.loaders.filesystem.Loader',
    'django.template.loaders.app_directories.Loader',
    #     'django.template.loaders.eggs.Loader',
)

MIDDLEWARE_CLASSES = (
    'django.middleware.common.CommonMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    #'django.contrib.flatpages.middleware.FlatpageFallbackMiddleware',
    # Uncomment the next line for simple clickjacking protection:
    # 'django.middleware.clickjacking.XFrameOptionsMiddleware',
)

ROOT_URLCONF = 'settings.urls'

# Python dotted path to the WSGI application used by Django's runserver.
WSGI_APPLICATION = 'settings.wsgi.application'

TEMPLATE_DIRS = (
    os.path.join(teakwood_home, 'templates').replace('\\', '/'),
)

# don't activate unnecessary apps
INSTALLED_APPS = (
    'django.contrib.auth',
    # 'django_openid_auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.sites',
    'django.contrib.messages',
    #    'django.contrib.staticfiles',
    #    'django.contrib.flatpages',
    'django.contrib.admin',
    'django.contrib.admindocs',
    #    'django.contrib.gis',
    #    'django_extensions',
    #    'olwidget',
    #'grappelli',
    'registration',
    'djcelery',
    'profiles',
    'apps.teakwood',
    'apps.simfactory',
    'apps.simlab',
    'apps.coastalmodels',
    'apps.datafactory',
    'apps.simreport',
    'apps.simesh',
    'apps.simviz',
    'apps.fileupload',
    'apps.workflow',
    'apps.accounts',
)

# A sample logging configuration. The only tangible logging
# performed by this configuration is to send an email to
# the site admins on every HTTP 500 error when DEBUG=False.
# See http://docs.djangoproject.com/en/dev/topics/logging for
# more details on how to customize your logging configuration.
LOGGING = {
    'version': 1,
    'disable_existing_loggers': True,
    'formatters': {
        'standard': {
            'format': "[%(asctime)s] %(levelname)s [%(name)s:%(lineno)s] %(message)s",
            'datefmt': "%d/%b/%Y %H:%M:%S"
        },
    },
    'handlers': {
        'null': {
            'level': 'DEBUG',
            'class': 'django.utils.log.NullHandler',
        },
        'logfile': {
            'level': 'DEBUG',
            'class': 'logging.handlers.RotatingFileHandler',
            'filename': teakwood_home + "/TEAKWOOD.logfile",
            'maxBytes': 10 * 1024 * 1024,
            'backupCount': 2,
            'formatter': 'standard',
        },
        'console': {
            'level': 'INFO',
            'class': 'logging.StreamHandler',
            'formatter': 'standard'
        },
        'mail_admins': {
            'level': 'ERROR',
            'filters': ['require_debug_false'],
            'class': 'django.utils.log.AdminEmailHandler'
        }
    },

    'filters': {
        'require_debug_false': {
            '()': 'django.utils.log.RequireDebugFalse'
        }
    },
    'loggers': {
        '': {
            'handlers': ['console', 'logfile'],
            'level': 'DEBUG',
            'propagate': True
        },
        'django': {
            'handlers': ['console'],
            'propagate': True,
            'level': 'WARN',
        },
        'django.db.backends': {
            'handlers': ['console'],
            'level': 'DEBUG',
            'propagate': False,
        },
        'django.request': {
            'handlers': ['console', 'logfile'],
            'level': 'DEBUG',
            'propagate': True,
        },
        #        'django.request': {
        #            'handlers': ['mail_admins'],
        #            'level': 'ERROR',
        #            'propagate': True,
        #        },
    }
}

TEMPLATE_CONTEXT_PROCESSORS = (
    'django.contrib.messages.context_processors.messages',
    'django.contrib.auth.context_processors.auth',
    'django.core.context_processors.static',
    'django.core.context_processors.media',
    'django.core.context_processors.csrf',
    'django.core.context_processors.request',
    'django.contrib.messages.context_processors.messages',
)

# Django-registration settings
# One-week activation window; you may use a different value.
ACCOUNT_ACTIVATION_DAYS = 7
REGISTRATION_OPEN = True
# Accounts
LOGIN_URL = '/login/'
LOGIN_REDIRECT_URL = '/project/list/'
LOGOUT_URL = '/logout/'

# OpenID authentication
# OPENID_SSO_SERVER_URL = 'https://www.google.com/accounts/o8/id'
# AUTHENTICATION_BACKENDS = (
#     'django.contrib.auth.backends.ModelBackend',
#     'settings.auth.GoogleBackend',
#     )

# user profile settings
AUTH_PROFILE_MODULE = "accounts.UserProfile"

# Celery settings
if TEAKWOOD_AMQP == 'rabbitmq':
    BROKER_URL = 'amqp://guest:guest@localhost:5672/'
elif TEAKWOOD_AMQP == 'django':
    BROKER_URL = 'django://'
    INSTALLED_APPS += ('kombu.transport.django', )
elif TEAKWOOD_AMQP == 'redis':
# Where the URL is in the format of: redis://:password@hostname:port/db_number
    BROKER_URL = 'redis://localhost:6379/0'

#Django Email
# EMAIL_HOST = 'localhost:8000'
# EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
# EMAIL_HOST_USER = 'teakwood@localhost:8000'
# EMAIL_PORT = 25

#Django Email
EMAIL_USE_TLS = True
EMAIL_HOST = 'smtp.gmail.com'
EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST_USER = 'guojiarui@gmail.com'
EMAIL_HOST_PASSWORD = ''
EMAIL_PORT = 25

# here you can define a system wide spatial region for your site
# we don't need to maintain the site wise active staion list for
# hosting the observation data. We only need to query the database
# and get a subset of the availd stations.

TEAKWOOD_DOMAIN = {
    'LONGITUDE_MIN': -99,
    'LONGITUDE_MAX': -84,
    'LATITUDE_MIN': 15,
    'LATITUDE_MAX': 33,
}

DATAFACTORY_STATIONS = {
    'NDBC': {
        'src_url': 'http://www.ndbc.noaa.gov/activestations.xml',
    },
    'COOPS-CURRENT': {
        'src_url': 'http://tidesandcurrents.noaa.gov/cdata/StationListFormat?type=Current%20Data&filter=active&format=csv',
    },
}

