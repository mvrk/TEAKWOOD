# Django settings for simulocean
from subprocess import Popen, PIPE

project = {
    'name': 'fool',

    'models': {
        'executable': '/usr/bin/ls',
        'parameter_file': '.',
    },

    'jobs': {
        'processors': 1,
    },

    'machines': {
        'hostname': 'localhost:8000',
        'account': 'simulocean',
        'working_directory': '/home/simulocean',
    }
}

def run():
    print project


if __name__ == "__main__":
    run()
