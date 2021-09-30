simulator( 'spectre )
;design(	 "/home/ykhuang/workingdir/Sim/Ex_SeriesStage/spectre/schematic/netlist/netlist")
design("DAY2" "Ex_SeriesStage" "schematic")
createNetlist()
resultsDir( "/home/ykhuang/workingdir/Sim/Ex_SeriesStage/spectre/schematic" )
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

/*global variable*/

VS = 1
IT = 0

;param of NMOS
gm1 = 6.792m
rds1 = 1863.33
cgs1 = 18.80f
cgd1 = 6.24f
cds1 = 4.92f
cdb1 = 7.44f


desVar(	  "VS" VS	)
desVar(	  "IT" IT	)
desVar(	  "cdb1" cdb1	)
desVar(	  "cds1" cds1	)
desVar(	  "cgd1" cgd1	)
desVar(	  "cgs1" cgs1	)
desVar(	  "gm1" gm1	)
desVar(	  "rds1" rds1	)


/***************************************************/
/* Closed loop Gain                                */
/* The source must be active, and the loop closed  */
/* Set the IS = 1, gm = gm1, and IT = 0            */  
/***************************************************/

desVar(	  "VS" 1	)
desVar(	  "IT" 0	)
desVar(	  "gm1" gm1	)

analysis('pz ?p "/VOUT"  ?vprobe "/V0"  )
analysis('ac ?start "0.1"  ?stop "300M"  ?dec "20"  )

envOption(
	'analysisOrder  list("ac" "pz") 
)

temp( 27 ) 
run()

selectResult( 'ac )
;plot(getData("/OUT") )

Gain = v("/VOUT" ?result "ac")
Gain_phase = phaseDeg(Gain)
newWindow()
plot(Gain)
addSubwindowTitle("Gain Magnitude")
addSubwindow
plot(Gain_phase)
addSubwindowTitle("Gain Phase")
addSubwindow
pzPlot( ?result "pz")
addSubwindowTitle("Pole-Zero Gain")

/*****************************************************/
/* Asymptotic Gain                                   */
/* the source must be active (IS=1), the loop closed */
/* with gm -> INF and the test source inactive       */
/*****************************************************/

desVar(	  "VS" 1	)
desVar(	  "IT" 0	)
desVar(	  "gm1" 1000	)

analysis('ac ?start "0.1"  ?stop "300M"  ?dec "20"  )
analysis('pz ?p "/VOUT" ?vprobe "/V0")

envOption(
        'analysisOrder  list("ac" "pz")
)

run()

selectResult( 'ac )

Gain = v("/VOUT" ?result "ac")
Gain_phase = phaseDeg(Gain)
newWindow()
plot(Gain)
addSubwindowTitle("Asymtotic Gain Magnitude")
addSubwindow
plot(Gain_phase)
addSubwindowTitle("AsymptoticGain Phase")
addSubwindow
pzPlot( ?result "pz")
addSubwindowTitle("Pole-Zero Asymptotic Gain")

/**********************************************************/
/* Open loop gain                                         */
/* The source must be inactive (IS=0), the loop open      */
/* gm=0, and the a test source inserted IT = 1.           */
/* The returning Vgs is sensed. and Beta (B)is calculated:*/
/* B = Vgs/Itest = Vgs (Itest = 1). Finally the loop gain */
/* is found: AB = B*gm                                    */
/**********************************************************/

analysis('ac ?start "0.1"  ?stop "300M"  ?dec "20"  )
analysis('pz ?p "/VG" ?iprobe "/I1" )

envOption(
        'analysisOrder  list("ac" "pz")
)

desVar(   "VS"  0      )
desVar(   "IT"  1      )
desVar(   "gm1" 0      )

save( 'v "/VG" )

run()

selectResult( 'ac )

VGS = v("/VG" ?result "ac")
AB = VGS*gm1
AB_phase = phaseDeg(AB)

newWindow
plot(AB)
addSubwindowTitle("AB")
addSubwindow
plot(AB_phase)
addSubwindowTitle("AB Phase")
addSubwindow
pzPlot( ?result "pz" )  
addSubwindowTitle("Pole-Zero AB")

/***********************************************/
/* Root-locus                                  */
/* pole-zero of gain is analyzed when          */
/* gm1 is swept from 0 to its nominal value    */
/***********************************************/

; analysis('pz ?p ""  ?n ""  ?oprobe "/IPRB0" ?iprobe "/I5"  ?porti "1" ?param "gm1" ?start "0.0"  ?stop gm1  ?step "0.5m" )
analysis('pz ?p "/VOUT"  ?vprobe "/V0"  ?param "gm1" ?start "0"  ?stop gm1 ?step ".05m"  )
envOption(
        'analysisOrder  list("pz")
)

desVar(   "VS"  1      )
desVar(   "IT"  0      )

run()

newWindow
pzPlot( ?result "pz" )  
addSubwindowTitle("Root locus")
