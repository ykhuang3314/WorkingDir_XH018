simulator( 'spectre )
;design(	 "/home/ykhuang/workingdir/Sim/Loopgain_SP1/spectre/schematic/netlist/netlist")
design("Exercise6" "Loopgain_SP1" "schematic")
createNetlist()
resultsDir( "/home/ykhuang/workingdir/Sim/Loopgain_SP1/spectre/schematic" )
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


;Parameters of Component

;NMOS1: W1_tot = 400.00um  L1 = 0.35um  IDS1 = 0.6000mA  VDS1 = 0.50V
 gm1 = 11.178m
 rds1 = 23424.63
 cgs1 = 500.14f

 cgd1 = 132.04f
 cds1 = 201.76f
 cdb1 = 411.72f
 ;vgs1 = 0.4547
 ;Gain1 = 261.84
 ;gm_id1 = 18.63
 ;Ft1 = 2814.17 MHz 

;PMOS1: W2_tot = 45.00um  L2 = 0.18um  IDS2 = 0.6500mA  VDS2 = 0.30V
 gm2 = 4.347m
 rds2 = 1598.70
 cgs2 = 51.41f
 cgd2 = 14.53f
 cds2 = 0.08f
 cdb2 = 43.50f
 ;vgs4 = -0.5960
 ;Gain2 = 6.95
 ;gm_id2 = 6.69
 ;Ft2 = 10490.98 MHz 


analysis('pz ?p "/OUT"  ?n "/gnd!"  ?iprobe "/V0"  )
analysis('ac ?start "0.1"  ?stop "300e6"  ?dec "20"  )

desVar(	  "cdb1" cdb1	)
desVar(	  "cdb2" cdb2	)
desVar(	  "cds1" cds1	)
desVar(	  "cds2" cds2	)
desVar(	  "cgd1" cgd1	)
desVar(	  "cgd2" cgd2	)
desVar(	  "cgs1" cgs1	)
desVar(	  "cgs2" cgs2	)
desVar(	  "gm1" gm1	)
desVar(	  "gm2" gm2	)
desVar(	  "rds1" rds1	)
desVar(	  "rds2" rds2	)


/***************************************************/
/* Closed loop Gain                                */
/* The source must be active, and the loop closed  */
/* Set the IS = 1, gm = gm1, and IT = 0            */  
/***************************************************/

desVar(	  "VS" 1	)
desVar(	  "IT" 0	)
desVar(	  "gm1" gm1	)

analysis('pz ?p "/OUT"  ?n "/gnd!"  ?iprobe "/V0"  )
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

desVar(	  "VS" 1	)
desVar(	  "IT" 0	)
desVar(	  "gm1" 1000	)

analysis('pz ?p "/OUT"  ?n "/gnd!"  ?iprobe "/V0"  )
analysis('ac ?start "0.1"  ?stop "300M"  ?dec "20"  )

envOption(
        'analysisOrder  list("ac" "pz")
)
temp(27)
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
analysis('pz ?p "/B" ?iprobe "/I11" )

envOption(
        'analysisOrder  list("ac" "pz")
)

desVar(   "VS"  0      )
desVar(   "IT"  1      )
desVar(   "gm1" 0      )

save( 'v "/B" )
temp(27)
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
analysis('pz ?p "/OUT"  ?iprobe "/V0"  ?param "gm1" ?start "0"  ?stop gm1 ?step ".05m"  )
envOption(
        'analysisOrder  list("pz")
)

desVar(   "IS"  1      )
desVar(   "IT"  0      )
temp(27)
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
