from django.contrib import admin
from models import CoastalModel, ModelInput, SWANParameters, SWANConfig, Delft3DParameters, Delft3DConfig, \
    ADCIRCParameters, ADCIRCConfig, CaFunwaveParameters, CaFunwaveConfig

admin.site.register(CoastalModel)
admin.site.register(ModelInput)
admin.site.register(SWANParameters)
admin.site.register(SWANConfig)
admin.site.register(Delft3DParameters)
admin.site.register(Delft3DConfig)
admin.site.register(ADCIRCConfig)
admin.site.register(ADCIRCParameters)
admin.site.register(CaFunwaveParameters)
admin.site.register(CaFunwaveConfig)

