import subprocess

start_date = '1991-04-05 00:00:00'
end_date   = '1991-04-05 23:00:00'

subprocess.call(['python','run_river.py', start_date, end_date])
subprocess.call(['python','run_wind.py', start_date, end_date])
subprocess.call(['python','run_water.py', start_date, end_date])

