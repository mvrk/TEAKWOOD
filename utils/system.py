import os, errno
from glob import glob
#import codecs
import subprocess
import tempfile, zipfile
from django.http import HttpResponse
from django.core.servers.basehttp import FileWrapper
from django.template.loader import render_to_string
import logging
from settings.settings import MEDIA_ROOT

log = logging.getLogger(__name__)

# mkdir -p #
def mkdir_p(path):
    try:
        log.info("mkdir -p %s" % path)
        os.makedirs(path, 0777)
    except OSError as exc: # Python >2.5
        if exc.errno == errno.EEXIST:
            log.warn("dir already exists.")
            pass
        else:
            raise


# def tail(f, n=20, offset=0):
#     stdin, stdout = os.popen2("tail -n " + n + offset + " " + f)
#     stdin.close()
#     lines = stdout.readlines()
#     stdout.close()
#     return lines[:, -offset]


# the default rysnc option is -rLptgoDv. Notice that -a == rlptgoD copy symbolic links
# while -L will copy the references.
def rsync(src, dest, ssh_cmd=None, rsync_cmd='rsync', rsync_options='-rLptgoDv --delete', block=True):
    if ssh_cmd != None:
        cmd = "%s %s %s %s %s" % (ssh_cmd, rsync_cmd, rsync_options, src, dest)
    else:
        cmd = "%s %s %s %s" % (rsync_cmd, rsync_options, src, dest)
    log.info(cmd)
    p = subprocess.Popen(cmd, cwd=MEDIA_ROOT, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

    if block:
        output = p.communicate()
        if output[1]:
            log.error(output[1])


def scp(src, dest, ssh_cmd=None, scp_cmd='scp', scp_options='', block=True):
    if ssh_cmd != None:
        cmd = "%s %s %s %s %s" % (ssh_cmd, scp_cmd, scp_options, src, dest)
    else:
        cmd = "%s %s %s %s" % (scp_cmd, scp_options, src, dest)
    log.info(cmd)
    p = subprocess.Popen(cmd, cwd=MEDIA_ROOT, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

    if block:
        output = p.communicate()
        if output[1]:
            log.error(output[1])


def send_file(request):
    """
    Send a file through Django without loading the whole file into
    memory at once. The FileWrapper will turn the file object into an
    iterator for chunks of 8KB.
    """
    filename = __file__ # Select your file here.
    wrapper = FileWrapper(file(filename))
    response = HttpResponse(wrapper, content_type='text/plain')
    response['Content-Length'] = os.path.getsize(filename)
    return response


def send_zipfile(request):
    """
    Create a ZIP file on disk and transmit it in chunks of 8KB,
    without loading the whole file into memory. A similar approach can
    be used for large dynamic PDF files.
    """
    temp = tempfile.TemporaryFile()
    archive = zipfile.ZipFile(temp, 'w', zipfile.ZIP_DEFLATED)
    for index in range(10):
        filename = __file__ # Select your files here.
        archive.write(filename, 'file%d.txt' % index)
    archive.close()
    wrapper = FileWrapper(temp)
    response = HttpResponse(wrapper, content_type='application/zip')
    response['Content-Disposition'] = 'attachment; filename=test.zip'
    response['Content-Length'] = temp.tell()
    temp.seek(0)
    return response


def render_to_file(filename, template, context):
    log.info(render_to_string(template, context))
    open(filename, 'w', 'utf-8').write(render_to_string(template, context))

# create symbolic links for all files under src_dir under dst_dir
def symlink_all(src_dir, dst_dir):
    # make sure we have dst_dir ready;
    mkdir_p(dst_dir)
    # create symbolic links to
    for src_path in glob("%s/*" % src_dir):
        try:
            os.symlink(os.path.abspath(src_path), os.path.join(dst_dir, os.path.basename(src_path)))
        except OSError as exc: # Python >2.5
            if exc.errno == errno.EEXIST:
                log.warn("symlink already exists.")
                pass
            else:
                raise


def exportfile(fin_name=None, fout_name=None, content_type=None):
    fsock = open (fin_name,'r')
    response = HttpResponse(fsock, content_type=content_type)
    response["Content-Disposition"] = "attachment; filename=%s"% fout_name
    return response
