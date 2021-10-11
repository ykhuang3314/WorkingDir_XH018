
# This is the NC-SIM(R) probe command file
# used in the AMS-ADE integration.


#
# Database settings
#
if { [info exists ::env(AMS_RESULTS_DIR) ] } { set AMS_RESULTS_DIR $env(AMS_RESULTS_DIR)} else {set AMS_RESULTS_DIR "../psf"}
database -open ams_database -into ${AMS_RESULTS_DIR} -default

#
# Probe settings
#
probe -create -emptyok -database ams_database {TCA_DSL_Chopping_TB.net089}
probe -create -emptyok -database ams_database {TCA_DSL_Chopping_TB.net086}
probe -create -emptyok -database ams_database {TCA_DSL_Chopping_TB.Vinp}
probe -create -emptyok -database ams_database {TCA_DSL_Chopping_TB.Vinn}
probe -create -emptyok -database ams_database {TCA_DSL_Chopping_TB.VSp}
probe -create -emptyok -database ams_database {TCA_DSL_Chopping_TB.VSn}
probe -create -emptyok -database ams_database {TCA_DSL_Chopping_TB.net070}
probe -create -emptyok -database ams_database {TCA_DSL_Chopping_TB.net074}
probe -create -emptyok -database ams_database {TCA_DSL_Chopping_TB.LPFoutp}
probe -create -emptyok -database ams_database {TCA_DSL_Chopping_TB.LPFoutn}
probe -create -emptyok -database ams_database -flow {TCA_DSL_Chopping_TB.IPRB1.in}
probe -create -emptyok -database ams_database -flow {TCA_DSL_Chopping_TB.IPRB0.in}
probe -create -emptyok -database ams_database -flow {TCA_DSL_Chopping_TB.M30.1}
probe -create -emptyok -database ams_database -flow {TCA_DSL_Chopping_TB.M31.1}

