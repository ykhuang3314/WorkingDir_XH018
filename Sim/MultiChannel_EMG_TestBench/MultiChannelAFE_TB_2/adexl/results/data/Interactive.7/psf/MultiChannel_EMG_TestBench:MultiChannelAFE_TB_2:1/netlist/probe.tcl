
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
probe -create -emptyok -database ams_database {MultiChannelAFE_TB_2.VINP_CH1}
probe -create -emptyok -database ams_database {MultiChannelAFE_TB_2.VINP_CH2}
probe -create -emptyok -database ams_database {MultiChannelAFE_TB_2.VOUTP_TIA}
probe -create -emptyok -database ams_database {MultiChannelAFE_TB_2.VOUTN_TIA}
probe -create -emptyok -database ams_database {MultiChannelAFE_TB_2.deModOUTP_CH1}
probe -create -emptyok -database ams_database {MultiChannelAFE_TB_2.deModOUTN_CH1}
probe -create -emptyok -database ams_database {MultiChannelAFE_TB_2.deModOUTP_CH2}
probe -create -emptyok -database ams_database {MultiChannelAFE_TB_2.deModOUTN_CH2}
probe -create -emptyok -database ams_database {MultiChannelAFE_TB_2.LPFOUTP_CH1}
probe -create -emptyok -database ams_database {MultiChannelAFE_TB_2.LPFOUTN_CH1}
probe -create -emptyok -database ams_database {MultiChannelAFE_TB_2.LPFOUTP_CH2}
probe -create -emptyok -database ams_database {MultiChannelAFE_TB_2.LPFOUTN_CH2}
probe -create -emptyok -database ams_database {MultiChannelAFE_TB_2.VINN_CH1}
probe -create -emptyok -database ams_database {MultiChannelAFE_TB_2.VINN_CH2}
probe -create -emptyok -database ams_database -flow {MultiChannelAFE_TB_2.M4.1}
probe -create -emptyok -database ams_database -flow {MultiChannelAFE_TB_2.M0.1}
probe -create -emptyok -database ams_database -flow {MultiChannelAFE_TB_2.M1.1}
probe -create -emptyok -database ams_database -flow {MultiChannelAFE_TB_2.M2.1}
probe -create -emptyok -database ams_database -flow {MultiChannelAFE_TB_2.IPRB4.in}
probe -create -emptyok -database ams_database -flow {MultiChannelAFE_TB_2.IPRB5.in}

