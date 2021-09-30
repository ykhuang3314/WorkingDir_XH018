simulator( 'spectre )
design(	 "/home/saul/Sim/DC_BIAS_NMOS_L_test/spectre/schematic/netlist/netlist")
resultsDir( "/home/saul/Sim/DC_BIAS_NMOS_L_test/spectre/schematic" )
modelFile( 
    '("/pkg/xfab/XKIT/xh018/cadence/v8_0/spectre/v8_0_1/lpmos/config.scs" "default")
    '("/pkg/xfab/XKIT/xh018/cadence/v8_0/spectre/v8_0_1/lpmos/param.scs" "3s")
    '("/pkg/xfab/XKIT/xh018/cadence/v8_0/spectre/v8_0_1/lpmos/bip.scs" "tm")
    '("/pkg/xfab/XKIT/xh018/cadence/v8_0/spectre/v8_0_1/lpmos/cap.scs" "tm")
    '("/pkg/xfab/XKIT/xh018/cadence/v8_0/spectre/v8_0_1/lpmos/dio.scs" "tm")
    '("/pkg/xfab/XKIT/xh018/cadence/v8_0/spectre/v8_0_1/lpmos/mos.scs" "tm")
    '("/pkg/xfab/XKIT/xh018/cadence/v8_0/spectre/v8_0_1/lpmos/photo.scs" "tm")
    '("/pkg/xfab/XKIT/xh018/cadence/v8_0/spectre/v8_0_1/lpmos/res.scs" "tm")
)
analysis('dc ?saveOppoint t  ?param "VGS"  ?start "0"  
		?stop "1.8"  ?step "0.02"  )
desVar(	  "VDS" 1	)
desVar(	  "VGS" 1	)
envOption(
	'analysisOrder  list("dc") 
)
save( 'i "/M0/D" )
temp( 27 ) 
run()
selectResult( 'dc )
plot(getData("/M0/D") )

ids = i("/M0/D" ?result "dc")

newWindow
addTitle("IDS Current")
plot(ids)

