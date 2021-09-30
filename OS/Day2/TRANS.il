simulator( 'spectre )
;design(	 "/home/saul/Sim/TRANS/spectre/schematic/netlist/netlist")
design("DAY2" "TRANS" "schematic")
createNetlist()
resultsDir( "/home/ykhuang/workingdir/Sim/TRANS/spectre/schematic" )
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

;load("OS/CHARACTERIZATION/global.il")

IS = 1;
IT = 0;

;NMOS1: W1_tot = 100.00um  L1 = 1.00um  IDS1 = 0.1000mA  VDS1 = 0.50V
  gm1 = 1.576m
  rds1 = 579303.50
  cgs1 = 478.16f
  cgd1 = 33.11f
  cds1 = 229.60f
  cdb1 = 148.55f
  vgs1 = 0.4792
  Gain1 = 913.07
  gm_id1 = 15.76
 ; Ft1 = 490.65 MHz 


desVar(	  "IS" IS	)
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

desVar(	  "IS" 1	)
desVar(	  "IT" 0	)
desVar(	  "gm1" gm1	)

analysis('pz ?p "/OUT"  ?iprobe "/I1"  )
analysis('ac ?start "0.1"  ?stop "300M"  ?dec "20"  )

envOption(
	'analysisOrder  list("ac" "pz") 
)

temp( 27 ) 
run()

selectResult( 'ac )
;plot(getData("/OUT") )

Gain = v("/OUT" ?result "ac")
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

desVar(	  "IS" 1	)
desVar(	  "IT" 0	)
desVar(	  "gm1" 1000	)

analysis('ac ?start "0.1"  ?stop "300M"  ?dec "10"  )
analysis('pz ?p "/OUT" ?iprobe "/I1")

envOption(
        'analysisOrder  list("ac" "pz")
)

run()

selectResult( 'ac )

Gain = v("/OUT" ?result "ac")
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
analysis('pz ?p "/B" ?iprobe "/I3" )

envOption(
        'analysisOrder  list("ac" "pz")
)

desVar(   "IS"  0      )
desVar(   "IT"  1      )
desVar(   "gm1" 0      )

save( 'v "/B" )

run()

selectResult( 'ac )

B = v("/B" ?result "ac")
AB = B*gm1
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
analysis('pz ?p "/OUT"  ?iprobe "/I1"  ?param "gm1" ?start "0"  ?stop gm1 ?step ".05m"  )
envOption(
        'analysisOrder  list("pz")
)

desVar(   "IS"  1      )
desVar(   "IT"  0      )

run()

newWindow
pzPlot( ?result "pz" )  
addSubwindowTitle("Root locus")

; Note: The new Visualization and analysis tool do not display correctly this sweep (it plots Mag, vs quality factor Q). 
; A Workaraound is to open the data manually following these steps:
; 1) Create a new window in the vis. and an. tool
; 2) Go to the menu and select Browser->Results->Open Results. Select the results directory for the sim
; 3) A file three appears in the browser at the left. Select "pz". Under the Signals Tab it should appear 
;    the data saved during the pz simualtion. select both "poles" and "zeros" using Ctrl+click
; 4) Right-click on the selected items and select "Plot Signal"
; 5) The data should be plotted con the window, but it is connecting the points with lines. Right click on
;    the display window and select Type->Scatter Plot



