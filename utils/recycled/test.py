import xml.etree.ElementTree as ET
tree = ET.parse('test.xml')
tree
print tree
joblist = tree.findall('./job')
joblist
joblist = tree.findall('./Job')
joblist
for job in joblist: print ("Job[0].job_state")
for job in joblist: print ("Job[0].job_state[0]")
for job in joblist: print (Job[0].job_state[0])
for job in joblist: print (Job[0].job_state)
for job in joblist: print (Job[0])
for job in joblist: print (job[0].job_state)
for job in joblist: print (job[0])
joblist = tree.findall('./Data')
for job in joblist: print (job[0])
for job in joblist: print (job)
joblist = tree.findall('Data')
joblist
joblist = tree.findall('job_state')
joblist
root=tree.getroot()
print root
ET.fromstring(Job_as_string)
for job in root.iter('Job'):
    print job.attrib
for job in root.iter('Job'): print job
for job in root.iter('Job'): print job.attrib
for job in root.iter('Job'): print job.keys
for job in root.iter('Job'): print job.tag
for job in root.findall('Job'): print job.find('job_state').text
for job in root.findall('Job'): print job.find('job_state')
for job in root.findall('Job'): print job.find('job_state').text
for job in root.findall('Job'): print job.find('job_state').text job.find('Job_name')
for job in root.findall('Job'): print job.find('job_state').text job.find('Job_Name')
for job in root.findall('Job'): print job.find('job_state').text + job.find('Job_Name')
for job in root.findall('Job'): print job.find('job_state').text + job.find('Job_Name').text
for job in root.findall('Job'): print job.find('job_state').text  job.find('Job_Name').text
for job in root.findall('Job'): print job.find('job_state').text  + " " + job.find('Job_Name').text
for job in root.findall('Job'): print job.find('job_state').text  + " " + job.find('Job_Name').text
