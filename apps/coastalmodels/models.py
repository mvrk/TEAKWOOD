import os
from django.db import models
from django.utils.datastructures import SortedDict
from django.views.generic import ListView
from django.db.models import Q
from apps.teakwood.models import CommonInfo
from apps.workflow.models import Project
from settings.settings import MEDIA_ROOT
import logging

from utils.system import render_to_file

log = logging.getLogger(__name__)

#===============================
#
# Models List
#
#===============================

class CoastalModel(models.Model):
    name = models.CharField(max_length=60)
    version = models.CharField(max_length=20)
    description = models.TextField(default='', null=True, blank=True)
    image = models.ImageField(upload_to="images", help_text='Size 235x144')
    web_site = models.URLField(null=True, blank=True)

    # we need either parfile name or par file extension to deal with users uploaded files.

    # in SWAN the par file is called INPUT
    parfile_name = models.CharField(max_length=60, null=True, blank=True)

    # mdf is the extension of the primary parameter file of Delft3D
    parfile_extension = models.CharField(max_length=5, null=True, blank=True)

    # input editor shall point to the URL name of the link that the web-based editor implemented within Django.
    config_editor = models.CharField(max_length=256, null=True, blank=True)
    config_list = models.CharField(max_length=256, null=True, blank=True)

    def get_fields(self):
        return [(field.verbose_name, field._get_val_from_obj(self))
                for field in self.__class__._meta.fields]

    def __unicode__(self):
        return "%s (%s)" % (self.name.strip(), self.version)

    class META:
        unique_together = ('name', 'version')

# list of supported Models List
class CoastalModelList(ListView):
    model = CoastalModel

    def get_queryset(self):
        return CoastalModel.objects.all()


#===============================
#
# Model Input
#
#===============================

TEAKWOOD_POI = [
    ('domain', 'use domain'),
    ('file', 'file (teakwood.poi)'),
]


class ModelInput(CommonInfo):
# associated project (important to link this to other parts of teakwood)
    project = models.ForeignKey(Project, related_name="%(class)s_related")
    model = models.ForeignKey(CoastalModel)
    # extend the authentication modules; group shares the project

    # a prior model that this model must depend on
    prior_model = models.ForeignKey('self', help_text="(Select the prior model input)", null=True, blank=True)

    input_dir = models.CharField(max_length=256)
    upload_now = models.BooleanField("Upload input data now", default=True)
    parfile_ready = models.BooleanField(default=False)
    poi_type = models.CharField(help_text="(Select how the points of interest shall be added)", max_length=64,
                                choices=TEAKWOOD_POI, null=True, blank=True)

    def get_fields(self):
        return [(field.verbose_name, field._get_val_from_obj(self))
                for field in self.__class__._meta.fields]

    def __unicode__(self):
        return self.name


# model for ListViewing model inputs
class ModelInputList(ListView):
    model = ModelInput

    def get_queryset(self):
        return ModelInput.objects.filter(
            Q(user=self.request.user) |
            Q(group__in=self.request.user.groups.all())).order_by('-id')


#===============================
#
#  SWAN Parameters and Configs
#
#===============================

class SWANParameters(CommonInfo):
    proj = models.CharField(max_length=60, null=False, blank=False, default="'SWAN Project' '1'")
    mode = models.CharField(max_length=60, null=False, blank=False, default="nonstat twod")
    coord = models.CharField(max_length=60, null=False, blank=False, default="sphe ccm")
    set = models.CharField(max_length=60, null=False, blank=False, default="naut")
    friction = models.CharField(max_length=60, null=False, blank=False, default="jonswap 0.067")
    triad = models.CharField(max_length=60, null=True, blank=True)
    prop = models.CharField(max_length=60, null=False, blank=False, default="bsbt")
    gen3 = models.CharField(max_length=60, null=False, blank=False, default="komen agrow")
    breaking = models.CharField(max_length=60, null=True, blank=True)
    wcap = models.CharField(max_length=60, null=True, blank=True)
    off = models.CharField(max_length=60, null=False, blank=False, default="bndchk")
    cgrid = models.TextField(null=False, blank=False,
                             default="curv 180 108 exception -999. -999. circle 36 0.02135 0.6 35")
    read_coor = models.CharField(max_length=60, null=False, blank=False, default="1.0 'grid.xy'")
    inpgrid_bottom = models.TextField(max_length=100, null=False, blank=False,
                                      default="reg -92. 26. 0. 10 10 0.6 0.6 exception -999.")
    read_bottom = models.CharField(max_length=60, null=False, blank=False, default="1. 'bath.bot'")
    inpgrid_wind = models.TextField(null=False, blank=False,
                                    default="reg -98. 7. 0. 38 39 1. 1. exception -999. nonstat 20110101.000000 6 hr 20111231.180000")
    read_wind = models.CharField(max_length=60, null=False, blank=False, default="1. 'ncep2011.wd'")
    numeric = models.CharField(max_length=60, null=False, blank=False, default="accur nonstat 15")
    output = models.CharField(max_length=60, null=False, blank=False, default="block 9")
    points = models.TextField(null=False, blank=False, default="'buoys' file 'buoy.loc'")
    table = models.TextField(null=False, blank=False,
                             default="'buoys' head 'buoy.tab' time xp yp dep wind hs dir rtp per tm01 tm02 pdir out 20110101.000000 1 hr")
    # decomposed from the compute parameter
    time_start = models.CharField(max_length=60, null=False, blank=False, default="20110101.000000",
                                  help_text="in the format of date(8 digits).time(6 digits)")
    time_end = models.CharField(max_length=60, null=False, blank=False, default="20111231.180000",
                                help_text="in the format of date(8 digits).time(6 digits)")
    time_interval = models.PositiveSmallIntegerField(default=1, help_text="in hours")
    # extra fields for managemange purpose
    #    user = models.ForeignKey(User)
    #    group = models.ForeignKey(Group, null=True, blank=True)
    #    model_type = models.ForeignKey(CoastalModel)
    def get_fields(self):
        return [(field.verbose_name, field._get_val_from_obj(self))
                for field in self.__class__._meta.fields]

    # it will be exported to the MODEL input dir
    def export(self):
        swanpardict = SortedDict(self.get_fields())
        # clean up the common infomation
        del swanpardict['ID']
        del swanpardict['name']
        del swanpardict['user']
        del swanpardict['group']
        del swanpardict['time created']
        del swanpardict['last modified']

        # reconstruct COMPUTE line before deleting
        swanpardict['compute'] = "nonst %s %s hr %s" % (
            swanpardict['time start'], swanpardict['time interval'], swanpardict['time end'])
        del swanpardict['time start']
        del swanpardict['time end']
        del swanpardict['time interval']

        if (self.swanconfig):
            swanpar_dir = "%s/%s" % (MEDIA_ROOT, self.swanconfig.model_input.input_dir)
            swanpar_file = os.path.abspath('%s/%s' % (swanpar_dir, self.name))
            log.into(swanpar_file)

            if os.path.exists(swanpar_file):
                os.remove(swanpar_file)

            f = open(swanpar_file, 'w')

            for name, value in swanpardict.items():
                f.write("%s %s\n" % (name, value))
            f.write('stop')
            f.close()
        else:
            log.warn("no need to export without a model input associated with a parameter file")

    def __unicode__(self):
        return str.upper("swan-parameters-%d" % self.id)


# model for ListViewing model inputs
class SWANParametersList(ListView):
    model = SWANParameters

    def get_queryset(self):
        return SWANParameters.objects.filter(
            Q(user=self.request.user) |
            Q(group__in=self.request.user.groups.all())).order_by('-id')


class SWANConfig(CommonInfo):
    # managing parameters related_name="delft3d_config",
    model_input = models.OneToOneField(ModelInput,
                                       help_text="(Select the model input that this SWAN config belongs to)")
    # physical parameters
    parameters = models.OneToOneField(SWANParameters, null=True, blank=True)

    def get_fields(self):
        return [(field.verbose_name, field._get_val_from_obj(self))
                for field in self.__class__._meta.fields]

    def __unicode__(self):
        return self.name.strip()


# model for ListViewing model inputs
class SWANConfigList(ListView):
    model = SWANConfig

    def get_queryset(self):
        return SWANConfig.objects.filter(
            Q(user=self.request.user) |
            Q(group__in=self.request.user.groups.all())).order_by('-id')


#===============================
#
#  Delft3D Parameters and Configs
#
#===============================
D3D_EXTENSION = [
    ('cor', 'Astronomic correction factors'),
    ('dep', 'Bathymetry or depth'),
    ('rgh', 'Bottom roughness'),
    ('bcc', 'Constituents boundary conditions'),
    ('crs', 'Cross-sections'),
    ('grd', 'Curvilinear grid'),
    ('src', 'Discharge locations'),
    ('dis', 'Discharges rates'),
    ('dad', 'Dredge and dump characteristics'),
    ('par', 'Drogues or floating particles'),
    ('dry', 'Dry points'),
    ('bca', 'Flow boundary conditions (astronomic)'),
    ('bch', 'Flow boundary conditions (harmonic)'),
    ('bcq', 'Flow boundary conditions (QH-relation)'),
    ('bct', 'Flow boundary conditions (time-series)'),
    ('fou', 'Fourier analysis input file'),
    ('enc', 'Grid enclosure'),
    ('edy', 'Horizontal eddy viscosity and diffusivity'),
    ('ini', 'Initial conditions'),
    ('mdf', 'Master definition flow'),
    ('mdw', 'Master definition wave'),
    ('mor', 'Morphology characteristics'),
    ('obs', 'Observation points'),
    ('bnd', 'Open boundaries'),
    ('sed', 'Sediment characteristics'),
    ('tem', 'Temperature model parameters'),
    ('thd', 'Thin dams'),
    ('wnd', 'Wind'),
]


class Delft3DParameters(CommonInfo):
    # model_input = models.OneToOneField(ModelInput, related_name="delft3d_parameters",
    #                                    help_text="(Select the model input that this parameter file belongs to)")
    #
    # physical parameters
    ident = models.CharField(max_length=60, null=True, blank=True, default="")
    runid = models.CharField(max_length=60, null=True, blank=True, default="")
    runtxt = models.CharField(max_length=60, null=True, blank=True, default="")
    filcco = models.CharField(max_length=60, null=True, blank=True, default="")
    fmtcco = models.CharField(max_length=60, null=True, blank=True, default="")
    anglat = models.CharField(max_length=60, null=True, blank=True, default="5.3000000e+001")
    grdang = models.CharField(max_length=60, null=True, blank=True, default="0.0000000e+000")
    filgrd = models.CharField(max_length=60, null=True, blank=True, default="")
    fmtgrd = models.CharField(max_length=60, null=True, blank=True, default="")
    mnkmax = models.CharField(max_length=60, null=True, blank=True, default="105 82 1")
    thick = models.CharField(max_length=60, null=True, blank=True, default="1.0000000e+002")
    fildep = models.CharField(max_length=60, null=True, blank=True, default="")
    fmtdep = models.CharField(max_length=60, null=True, blank=True, default="")
    fildry = models.CharField(max_length=60, null=True, blank=True, default="")
    fmtdry = models.CharField(max_length=60, null=True, blank=True, default="")
    filtd = models.CharField(max_length=60, null=True, blank=True, default="")
    fmttd = models.CharField(max_length=60, null=True, blank=True, default="")
    nambar = models.CharField(max_length=60, null=True, blank=True, default="")
    mnbar = models.CharField(max_length=60, null=True, blank=True, default="[ ] [ ]")
    mnwlos = models.CharField(max_length=60, null=True, blank=True, default="[ ] [ ]")
    itdate = models.CharField(max_length=60, null=True, blank=True, default="")
    tunit = models.CharField(max_length=60, null=True, blank=True, default="")
    tstart = models.CharField(max_length=60, null=True, blank=True, default="0.0000000e+000")
    tstop = models.CharField(max_length=60, null=True, blank=True, default="1.8000000e+002")
    dt = models.CharField(max_length=60, null=True, blank=True, default="1.0000000e+000")
    tzone = models.CharField(max_length=60, null=True, blank=True, default="0")
    sub1 = models.CharField(max_length=60, null=True, blank=True, default="")
    sub2 = models.CharField(max_length=60, null=True, blank=True, default="")
    namc1 = models.CharField(max_length=60, null=True, blank=True, default="")
    namc2 = models.CharField(max_length=60, null=True, blank=True, default="")
    namc3 = models.CharField(max_length=60, null=True, blank=True, default="")
    namc4 = models.CharField(max_length=60, null=True, blank=True, default="")
    namc5 = models.CharField(max_length=60, null=True, blank=True, default="")
    wnsvwp = models.CharField(max_length=60, null=True, blank=True, default="")
    filwnd = models.CharField(max_length=60, null=True, blank=True, default="")
    fmtwnd = models.CharField(max_length=60, null=True, blank=True, default="")
    wndint = models.CharField(max_length=60, null=True, blank=True, default="")
    filic = models.CharField(max_length=60, null=True, blank=True, default="")
    fmtic = models.CharField(max_length=60, null=True, blank=True, default="")
    zeta0 = models.CharField(max_length=60, null=True, blank=True, default="0.0000000e+000")
    u0 = models.CharField(max_length=60, null=True, blank=True, default="[.]")
    v0 = models.CharField(max_length=60, null=True, blank=True, default="[.]")
    s0 = models.CharField(max_length=60, null=True, blank=True, default="[.]")
    t0 = models.CharField(max_length=60, null=True, blank=True, default="[.]")
    c01 = models.CharField(max_length=60, null=True, blank=True, default="0.0000000e+000")
    i0 = models.CharField(max_length=60, null=True, blank=True, default="[.]")
    restid = models.CharField(max_length=60, null=True, blank=True, default="")
    filbnd = models.CharField(max_length=60, null=True, blank=True, default="")
    fmtbnd = models.CharField(max_length=60, null=True, blank=True, default="")
    filbch = models.CharField(max_length=60, null=True, blank=True, default="")
    fmtbch = models.CharField(max_length=60, null=True, blank=True, default="")
    filbct = models.CharField(max_length=60, null=True, blank=True, default="")
    fmtbct = models.CharField(max_length=60, null=True, blank=True, default="")
    filbcq = models.CharField(max_length=60, null=True, blank=True, default="")
    fmtbcq = models.CharField(max_length=60, null=True, blank=True, default="")
    filana = models.CharField(max_length=60, null=True, blank=True, default="")
    filcor = models.CharField(max_length=60, null=True, blank=True, default="")
    filbcc = models.CharField(max_length=60, null=True, blank=True, default="")
    fmtbcc = models.CharField(max_length=60, null=True, blank=True, default="")
    rettis = models.CharField(max_length=60, null=False, blank=False,
                              default="0.0000000e+000 0.0000000e+000 0.0000000e+000")
    rettib = models.CharField(max_length=60, null=False, blank=False,
                              default="0.0000000e+000 0.0000000e+000 0.0000000e+000")
    ag = models.CharField(max_length=60, null=True, blank=True, default="9.8100004e+000")
    rhow = models.CharField(max_length=60, null=True, blank=True, default="1.0000000e+003")
    alph0 = models.CharField(max_length=60, null=True, blank=True, default="[.]")
    tempw = models.CharField(max_length=60, null=True, blank=True, default="1.5000000e+001")
    salw = models.CharField(max_length=60, null=True, blank=True, default="3.1000000e+001")
    rouwav = models.CharField(max_length=60, null=True, blank=True, default="")
    wstres = models.CharField(max_length=128, null=False, blank=False,
                              default="2.4999999e-003  0.0000000e+000  2.4999999e-003  0.0000000e+000")
    rhoa = models.CharField(max_length=60, null=True, blank=True, default="1.0000000e+000")
    betac = models.CharField(max_length=60, null=True, blank=True, default="5.0000000e-001")
    equili = models.CharField(max_length=60, null=True, blank=True, default="")
    tkemod = models.CharField(max_length=60, null=True, blank=True, default="")
    ktemp = models.CharField(max_length=60, null=True, blank=True, default="0")
    fclou = models.CharField(max_length=60, null=True, blank=True, default="0.0000000e+000")
    sarea = models.CharField(max_length=60, null=True, blank=True, default="0.0000000e+000")
    filtmp = models.CharField(max_length=60, null=True, blank=True, default="")
    fmttmp = models.CharField(max_length=60, null=True, blank=True, default="")
    temint = models.CharField(max_length=60, null=True, blank=True, default="")
    tstmp = models.CharField(max_length=60, null=True, blank=True, default="[.] [.]")
    roumet = models.CharField(max_length=60, null=True, blank=True, default="")
    filrgh = models.CharField(max_length=60, null=True, blank=True, default="")
    fmtrgh = models.CharField(max_length=60, null=True, blank=True, default="")
    ccofu = models.CharField(max_length=60, null=True, blank=True, default="2.1000000e-002")
    ccofv = models.CharField(max_length=60, null=True, blank=True, default="2.1000000e-002")
    xlo = models.CharField(max_length=60, null=True, blank=True, default="0.0000000e+000")
    htur2d = models.CharField(max_length=60, null=True, blank=True, default="")
    filedy = models.CharField(max_length=60, null=True, blank=True, default="")
    fmtedy = models.CharField(max_length=60, null=True, blank=True, default="")
    vicouv = models.CharField(max_length=60, null=True, blank=True, default="1.0000000e+001")
    dicouv = models.CharField(max_length=60, null=True, blank=True, default="1.0000000e+001")
    vicoww = models.CharField(max_length=60, null=True, blank=True, default="[.]")
    dicoww = models.CharField(max_length=60, null=True, blank=True, default="[.]")
    irov = models.CharField(max_length=60, null=True, blank=True, default="0")
    z0v = models.CharField(max_length=60, null=True, blank=True, default="[.]")
    cmu = models.CharField(max_length=60, null=True, blank=True, default="[.]")
    cpran = models.CharField(max_length=60, null=True, blank=True, default="[.]")
    filsed = models.CharField(max_length=60, null=True, blank=True, default="")
    filmor = models.CharField(max_length=60, null=True, blank=True, default="")
    iter = models.CharField(max_length=60, null=True, blank=True, default="2")
    dryflp = models.CharField(max_length=60, null=True, blank=True, default="")
    dpsopt = models.CharField(max_length=60, null=True, blank=True, default="")
    dpuopt = models.CharField(max_length=60, null=True, blank=True, default="")
    dryflc = models.CharField(max_length=60, null=True, blank=True, default="1.0000000e-001")
    dco = models.CharField(max_length=60, null=True, blank=True, default="1.0000000e+001")
    tlfsmo = models.CharField(max_length=60, null=True, blank=True, default="0.0000000e+000")
    thetqh = models.CharField(max_length=60, null=True, blank=True, default="0.0000000e+000")
    forfuv = models.CharField(max_length=60, null=True, blank=True, default="")
    forfww = models.CharField(max_length=60, null=True, blank=True, default="")
    sigcor = models.CharField(max_length=60, null=True, blank=True, default="")
    trasol = models.CharField(max_length=60, null=True, blank=True, default="")
    momsol = models.CharField(max_length=60, null=True, blank=True, default="")
    filsrc = models.CharField(max_length=60, null=True, blank=True, default="")
    fmtsrc = models.CharField(max_length=60, null=True, blank=True, default="")
    fildis = models.CharField(max_length=60, null=True, blank=True, default="")
    fmtdis = models.CharField(max_length=60, null=True, blank=True, default="")
    filsta = models.CharField(max_length=60, null=True, blank=True, default="")
    fmtsta = models.CharField(max_length=60, null=True, blank=True, default="")
    filpar = models.CharField(max_length=60, null=True, blank=True, default="")
    fmtpar = models.CharField(max_length=60, null=True, blank=True, default="")
    eps = models.CharField(max_length=60, null=True, blank=True, default="[.]")
    filcrs = models.CharField(max_length=60, null=True, blank=True, default="")
    fmtcrs = models.CharField(max_length=60, null=True, blank=True, default="")
    smhydr = models.CharField(max_length=60, null=True, blank=True, default="")
    smderv = models.CharField(max_length=60, null=True, blank=True, default="")
    smproc = models.CharField(max_length=60, null=True, blank=True, default="")
    pmhydr = models.CharField(max_length=60, null=True, blank=True, default="")
    pmderv = models.CharField(max_length=60, null=True, blank=True, default="")
    pmproc = models.CharField(max_length=60, null=True, blank=True, default="")
    shhydr = models.CharField(max_length=60, null=True, blank=True, default="")
    shderv = models.CharField(max_length=60, null=True, blank=True, default="")
    shproc = models.CharField(max_length=60, null=True, blank=True, default="")
    shflux = models.CharField(max_length=60, null=True, blank=True, default="")
    phhydr = models.CharField(max_length=60, null=True, blank=True, default="")
    phderv = models.CharField(max_length=60, null=True, blank=True, default="")
    phproc = models.CharField(max_length=60, null=True, blank=True, default="")
    phflux = models.CharField(max_length=60, null=True, blank=True, default="")
    filfou = models.CharField(max_length=60, null=True, blank=True, default="")
    online = models.CharField(max_length=60, null=True, blank=True, default="")
    prmap = models.CharField(max_length=60, null=True, blank=True, default="[.]")
    prhis = models.CharField(max_length=60, null=False, blank=False,
                             default="0.0000000e+000  0.0000000e+000  0.0000000e+000")
    flmap = models.CharField(max_length=60, null=False, blank=False,
                             default="9.0000000e+001  9.0000000e+001  1.8000000e+002")
    flhis = models.CharField(max_length=60, null=False, blank=False,
                             default="0.0000000e+000  1.0000000e+001  1.8000000e+002")
    flpp = models.CharField(max_length=60, null=False, blank=False,
                            default="0.0000000e+000  6.0000000e+001  1.2960000e+004")
    flrst = models.CharField(max_length=60, null=True, blank=True, default="0.0000000e+000")
    waveol = models.CharField(max_length=60, null=True, blank=True, default="")
    addtim = models.CharField(max_length=60, null=True, blank=True, default="")

    # def __init__(self, d3d_mdf_file, *args, **kwargs):
    #     d3d_mdf_dict = d3dmdf2dict(d3d_mdf_file)
    #     super(Delft3DParameters, self).__init__(self, d3d_mdf_dict)

    def get_fields(self):
        return [(field.verbose_name, field._get_val_from_obj(self))
                for field in self.__class__._meta.fields]

    def __unicode__(self):
        return str.upper("delft3d_parameters")


DELFT3DFLOWTYPE = [
    ('sd', 'Single domain'),
    ('dd', 'Domain decomposition'),
]


class Delft3DConfig(CommonInfo):
    model_input = models.OneToOneField(ModelInput, related_name="delft3d_config",
                                       help_text="(Select the model input that this Delft3D config belongs to)")
    # physical parameters
    parameters = models.OneToOneField(Delft3DParameters, null=True, blank=True)

    flowtype = models.CharField("flow type", max_length=2, default='sd', choices=DELFT3DFLOWTYPE)
    swan = models.BooleanField("couple with SWAN", default=False)

    a0_correction = models.FloatField(default=0.0, help_text="(A0 correction water level boundaries for nesthd2)")

    # madel specific controlling parameters
    # config_name = models.CharField("Config file name", max_length=60, null=False, blank=False, default="teakwood.ini")
    # mdf_file = models.CharField("MDF file name", max_length=60, null=True, blank=True, default="teakwood.mdf")
    nested_model = models.BooleanField("Nested model", default=False)

    # # the following fields are relevant to nested runs
    # prior_model = models.ForeignKey(ModelInput,
    #                                 help_text="(Select the overall model for this nested one)", null=True,
    #                                 blank=True, related_name="prior_model")
    nested_runid = models.CharField(max_length=16, null=True, blank=True)
    prior_runid = models.CharField(max_length=16, null=True, blank=True)
    # def create_config(self):
    #     """
    #     the script will be created under the local job dir.
    #     """
    #     config = "%s/%s" % (os.path.normpath("%s/%s" % (MEDIA_ROOT, self.model_input.input_dir)), self.config_name)
    #     log.debug(config)
    #     try:
    #         render_to_file(config, 'conastalmodels/config_file_template.html', {"config": self})
    #     except Exception:
    #         raise

    def get_fields(self):
        return [(field.verbose_name, field._get_val_from_obj(self))
                for field in self.__class__._meta.fields]

    def __unicode__(self):
        return self.name.strip()


# model for ListViewing model inputs
class Delft3DParametersList(ListView):
    model = Delft3DParameters

    def get_queryset(self):
        return Delft3DParameters.objects.filter(
            Q(user=self.request.user) |
            Q(group__in=self.request.user.groups.all())).order_by('-id')


# model for ListViewing model inputs
class Delft3DConfigList(ListView):
    model = Delft3DConfig

    def get_queryset(self):
        return Delft3DConfig.objects.filter(
            Q(user=self.request.user) |
            Q(group__in=self.request.user.groups.all())).order_by('-id')


#===============================
#
#  FVCOM Parameters and Configs
#
#===============================

class FVCOMConfig(CommonInfo):
    # managing parameters related_name="delft3d_config",
    model_input = models.OneToOneField(ModelInput, related_name="fvcom_config",
                                       help_text="(Select the model input that this FVCOM config belongs to)")
    # physical parameters
    # parameters = models.OneToOneField(FVCOMParameters, null=True, blank=True)
    case_name = models.CharField(max_length=8)

    def get_fields(self):
        return [(field.verbose_name, field._get_val_from_obj(self))
                for field in self.__class__._meta.fields]

    def __unicode__(self):
        return self.name.strip()


# model for ListViewing model inputs
class FVCOMConfigList(ListView):
    model = FVCOMConfig

    def get_queryset(self):
        return FVCOMConfig.objects.filter(
            Q(user=self.request.user) |
            Q(group__in=self.request.user.groups.all())).order_by('-id')

#===============================
#
#  ADCIRC Parameters and Configs
#
#===============================

class ADCIRCParameters(CommonInfo):
    def get_fields(self):
        return [(field.verbose_name, field._get_val_from_obj(self))
                for field in self.__class__._meta.fields]

    def __unicode__(self):
        return str.upper("swan-parameters-%d" % self.id)


ADCIRC_SUBDOMAINS = [
    ('partmesh', 'Partition mesh using metis'),
    ('prepall', 'Full pre-process'),
    ('prepspec', 'Specify the names of input files'),
    ('prep15', 'Localizes RunInfo (fort.15) file'),
    ('prep13', 'Localizes NodalAttributes (fort.13) file'),
    ('hotLocalize', 'Localizes global hotstart file ONLY'),
    ('hotGlobalize', 'Globalizes local hotstart files ONLY'),
]

CERA_ADCIRC_GRIDS = [
    ('sl16_alpha_2007_26', 'SL16 Alpha 2007 26'),
    ('ec95d', 'ec95d'),
    ('ocpr_v19a_DesAllemands4CERA', 'OCPR v19a DesAllemands4CERA'),
    ('sl15v3_2007_r9a', 'SL15v3 2007 r9a'),
    ('SL15v3', 'SL15v3'),
    ('sl15_2007_IHNC_r03q_levchk', 'SL15 2007 IHNC r03q levchk'),
    ('nc6b', 'nc6b'),
    ('FEMAR2', 'FEMAR2'),
    ('FEMAR3', 'FEMAR3'),
    ('FEMAR4', 'FEMAR4'),
    ('ULLR2D', 'ULLR2D'),
]

CERA_ADCIRC_WINDMODELS = [
    ('WNAMAW12-NCP', 'WNAMAW12-NCP'),
    ('WNAMAW32-NCP', 'WNAMAW32-NCP'),
    ('vortex-nws19', 'Vortex-NWS19'),
    ('vortex-nws319', 'Vortex-NWS319'),
    ('WNAMAW12+NWS19', 'WNAMAW12+NWS19'),
    ('NWS-305', 'NWS-305'),
    ('fitz-nws4', 'Fitz-NWS4'),
    ('owi', 'OWI'),
    ('lsu', 'LSU'),
    ('Hwind', 'HWind'),
]

CERA_ADCIRC_FILE_FORMAT = [
    ('netcdf', 'NetCDF'),
    ('ascii', 'ASCII'),
]


class ADCIRCCERA(models.Model):
    # Start CERA related output for visualization purpose

    adcircid = models.CharField("CERA ADCIRC id", max_length=60, null=True, blank=True, default="")

    grid = models.CharField("ADCIRC grid", max_length=60, null=True, blank=True, default='sl16_alpha_2007_26',
                            choices=CERA_ADCIRC_GRIDS)

    windmodel = models.CharField("Wind model", max_length=60, null=True, blank=True, default="lsu",
                                 choices=CERA_ADCIRC_WINDMODELS)
    desc_short = models.CharField("Short description", max_length=60, null=True, blank=True, default="")
    description = models.CharField("Description", max_length=500, null=True, blank=True, default="")
    hostname = models.CharField("Host name", max_length=60, null=True, blank=True, default="localhost:8000")
    downloadurl = models.CharField("Download URL", max_length=60, null=True, blank=True, default="")
    elev = models.CharField("Water surface elevation file name", max_length=60, null=True, blank=True,
                            default="fort.63.nc")
    elev_fmt = models.CharField("Water surface elevation format", max_length=60, null=True, blank=True,
                                default="netcdf")
    wvel = models.CharField("Wind velocity file name", max_length=60, null=True, blank=True, default="fort.74.nc")
    wvel_fmt = models.CharField("Wind Velocity File format", max_length=60, null=True, blank=True, default="netcdf")
    hsign = models.CharField("Significant wave height file name", max_length=60, null=True, blank=True,
                             default="swan_HS.63.nc")
    hsign_fmt = models.CharField("Significant wave Height file format", max_length=60, null=True, blank=True,
                                 default="netcdf")
    tps = models.CharField("Peak wave period file name", max_length=60, null=True, blank=True, default="swan_TPS.63.nc")
    tps_fmt = models.CharField("Peak wave period file format", max_length=60, null=True, blank=True, default="netcdf")
    maxelev = models.CharField("Maximum water surface elevation file name", max_length=60, null=True, blank=True,
                               default="")
    maxelev_fmt = models.CharField("Maximum water surface elevation file format", max_length=60, null=True, blank=True,
                                   default="netcdf")
    maxwvel = models.CharField("Maximum wind speed file name", max_length=60, null=True, blank=True,
                               default="maxwvel.63.nc")
    maxwvel_fmt = models.CharField("Maximum wind speed file format", max_length=60, null=True, blank=True,
                                   default="netcdf")
    maxhsign = models.CharField("Maximum significant wave height file name", max_length=60, null=True, blank=True,
                                default="swan_HS_max.63.nc")
    maxhsign_fmt = models.CharField("Maximum significant wave height file format", max_length=60, null=True, blank=True,
                                    default="netcdf")
    maxtps = models.CharField("Maximum significant wave height file name", max_length=60, null=True, blank=True,
                              default="swan_TPS_max.63.nc")
    maxtps_fmt = models.CharField("Maximum significant wave height file format", max_length=60, null=True, blank=True,
                                  default="netcdf")
    # End CERA related output for visualization purpose
    def __unicode__(self):
        return self.adcircid.strip()

    def create_runproperties(self):
        """
        the run properties file will be created under the local job dir.
        """
        script = "%s/%s" % (os.path.normpath("%s/%s" % (MEDIA_ROOT, self.local_dir)), self.script_name)
        log.debug(script)
        try:
            render_to_file(script, 'coastalmodels/adcirc_cera.html', {"adcirc": self})
        except Exception:
            raise


class ADCIRCConfig(CommonInfo):
# managing parameters
    model_input = models.OneToOneField(ModelInput, related_name="adcirc_config",
                                       help_text="(Select the model input that this ADCIRC config belongs to)")

    swan = models.BooleanField("Couple with SWAN", default=True,
                               help_text='(9 extra I/O processors shall be added when you create a job)')
    # this is relevant to adcprep. We need to check this before job submission
    processor_number = models.PositiveIntegerField("number of processors", null=False, blank=False)
    # # physical parameters
    # parameters = models.OneToOneField(ADCIRCParameters, null=True, blank=True)
    # cera = models.BooleanField("Use CERA", default=True,
    #                            help_text='(CERA Visualization workflow will be triggered after an ADCIRC run finishes)')
    # cera_script = models.OneToOneField(ADCIRCCERA, related_name="adcirc_config",
    #                                    help_text="(CERA run properties)")

    def get_fields(self):
        return [(field.verbose_name, field._get_val_from_obj(self))
                for field in self.__class__._meta.fields]

    def __unicode__(self):
        return self.name.strip()


# model for ListViewing model inputs
class ADCIRCParametersList(ListView):
    model = ADCIRCParameters

    def get_queryset(self):
        return ADCIRCParameters.objects.filter(
            Q(user=self.request.user) |
            Q(group__in=self.request.user.groups.all())).order_by('-id')


# model for ListViewing model inputs
class ADCIRCConfigList(ListView):
    model = ADCIRCConfig

    def get_queryset(self):
        return ADCIRCConfig.objects.filter(
            Q(user=self.request.user) |
            Q(group__in=self.request.user.groups.all())).order_by('-id')


#===============================
#
#  CaFunwave Parameters and Configs
#
#===============================

class CaFunwaveParameters(CommonInfo):
    def get_fields(self):
        return [(field.verbose_name, field._get_val_from_obj(self))
                for field in self.__class__._meta.fields]

    def __unicode__(self):
        return str.upper("swan-parameters-%d" % self.id)


class CaFunwaveConfig(CommonInfo):
# managing parameters
    model_input = models.OneToOneField(ModelInput, related_name="cafunwave_config",
                                       help_text="(Select the model input that this SWAN config belongs to)")
    # physical parameters
    parameters = models.OneToOneField(CaFunwaveParameters, null=True, blank=True)

    def get_fields(self):
        return [(field.verbose_name, field._get_val_from_obj(self))
                for field in self.__class__._meta.fields]

    def __unicode__(self):
        return self.name.strip()

# model for ListViewing model inputs
class CaFunwaveParametersList(ListView):
    model = CaFunwaveParameters

    def get_queryset(self):
        return CaFunwaveParameters.objects.filter(
            Q(user=self.request.user) |
            Q(group__in=self.request.user.groups.all())).order_by('-id')


# model for ListViewing model inputs
class CaFunwaveConfigList(ListView):
    model = CaFunwaveConfig

    def get_queryset(self):
        return CaFunwaveConfig.objects.filter(
            Q(user=self.request.user) |
            Q(group__in=self.request.user.groups.all())).order_by('-id')


#===============================
#
#  EFDC Parameters and Configs
#
#===============================

class EFDCParameters(CommonInfo):
    def get_fields(self):
        return [(field.verbose_name, field._get_val_from_obj(self))
                for field in self.__class__._meta.fields]

    def __unicode__(self):
        return str.upper("swan-parameters-%d" % self.id)


class EFDCConfig(CommonInfo):
# managing parameters
    model_input = models.OneToOneField(ModelInput, related_name="EFDC_config",
                                       help_text="(Select the model input that this SWAN config belongs to)")
    # physical parameters
    parameters = models.OneToOneField(EFDCParameters, null=True, blank=True)

    def get_fields(self):
        return [(field.verbose_name, field._get_val_from_obj(self))
                for field in self.__class__._meta.fields]

    def __unicode__(self):
        return self.name.strip()

# model for ListViewing model inputs
class EFDCParametersList(ListView):
    model = EFDCParameters

    def get_queryset(self):
        return EFDCParameters.objects.filter(
            Q(user=self.request.user) |
            Q(group__in=self.request.user.groups.all())).order_by('-id')


# model for ListViewing model inputs
class EFDCConfigList(ListView):
    model = EFDCConfig

    def get_queryset(self):
        return EFDCConfig.objects.filter(
            Q(user=self.request.user) |
            Q(group__in=self.request.user.groups.all())).order_by('-id')
