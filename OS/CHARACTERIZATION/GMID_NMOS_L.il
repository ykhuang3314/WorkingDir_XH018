simulator( 'spectre )
;design(	 "/home/saul/Sim/GMID_NMOS_L/spectre/schematic/netlist/netlist")
design( "CHARACTERIZATION" "GMID_NMOS_L" "schematic")
createNetlist
resultsDir( "/home/ykhuang/workingdir/Sim/GMID_NMOS_L/spectre/schematic" )

load("OS/CHARACTERIZATION/global.il")

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
analysis('dc ?saveOppoint t  ?param "IDS1"  ?start "100n"  
		?stop "20m"  ?dec "10"  )
desVar(	  "IDS1" IDS1	)
desVar(	  "L1" L1	)
desVar(	  "NF1" NF1	)
desVar(	  "VDS1" VDS1	)
desVar(	  "WF1" WF1	)
envOption(
	'firstRun  t 
	'analysisOrder  list("dc") 
)
saveOpPoint( "/I0/M0" ?operatingPoints "gm id" )
temp( 27 ) 
run()
selectResult( 'dc )



gm_id = OS( "/I0/M0" "gm" ) / OS( "/I0/M0" "id" )
newWindow
plot(abs(gm_id))
addTitle("GMID vs. ID")
gm = OS( "/I0/M0" "gm" )
newWindow
plot(abs(gm))
addTitle(gm)

;plot( OS( "/I0/M0" "gm" ) OS( "/I0/M0" "id" ) )
;plot( OS("/I0/M0" "gm") )
;plot( (OS("/I0/M0" "gm") / OS("/I0/M0" "id")) )
