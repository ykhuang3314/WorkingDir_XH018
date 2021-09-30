;====================== Set to XL mode =========================================
ocnSetXLMode()
ocnxlProjectDir( "./Sim" )
ocnxlTargetCellView( "EXERCISE1" "S5_STATIC_LIN" "adexl" )
ocnxlResultsLocation( "" )
ocnxlSimResultsLocation( "" )
ocnxlMaxJobFail( 20 )

;====================== Tests setup ============================================

;---------- Test "EXERCISE1:S5_STATIC_LIN:1" ------------- 
ocnxlBeginTest("EXERCISE1:S5_STATIC_LIN:1")
simulator( 'spectre )
design( "EXERCISE1" "S5_STATIC_LIN" "schematic")
createNetlist
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
FLOW = 100.0
FHIGH = 30.0M
analysis('noise ?start FLOW  ?stop FHIGH  ?dec "10"
                ?oprobe "/IPRB0"  ?iprobe "/I5"  )
analysis('pz ?p ""  ?n ""  ?oprobe "/IPRB0"  
		?iprobe "/I5"  ?porti "1"  )
analysis('dc ?saveOppoint t  ?param "IS_DC"  ?start "-8u"  
		?stop "8u"  ?step ".01u"  )
analysis('ac ?start "100"  ?stop "300M"  ?dec "10"  )
desVar(	  "IS_DC" 0	)
desVar(	  "R1" 100k	)
desVar(	  "R2" 400	)
desVar(	  "IS" 1	)
envOption(
	'firstRun  t 
	'analysisOrder  list("dc" "ac" "pz" "dcmatch" "stb" "tran" "envlp" "lf" "noise" "xf" "sp" "pss" "pac" "pstb" "pnoise" "pxf" "psp" "qpss" "qpac" "qpnoise" "qpxf" "qpsp" "hb" "hbac" "hbstb" "hbnoise" "hbxf" "sens" "acmatch") 
)
option( ?categ 'turboOpts
	'apsplus  t 
	'uniMode  "APS" 
)
save( 'i "/IPRB0/MINUS" )
temp( 27 ) 
;ocnxlOutputTerminal( "/IPRB0/MINUS" ?plot t ?save t)
;ocnxlOutputExpr( "pzFrequencyAndRealFilter(getData(\"zeros\" ?result \"pz\"))" ?name "Zeros" ?plot t)
;ocnxlOutputExpr( "pzFrequencyAndRealFilter(getData(\"poles\" ?result \"pz\"))" ?name "Poles" ?plot t)ocnxlOutputExpr( "deriv(IS(\"/IPRB0/MINUS\"))" ?plot t ?evalType 'point)
ocnxlEndTest() ; "EXERCISE1:S5_STATIC_LIN:1"

;====================== Sweeps setup ===========================================
;ocnxlSweepVar("IS_DC" "0")
;ocnxlSweepVar("R1" "100k")
;ocnxlSweepVar("R2" "400")
;ocnxlSweepVar("IS" "1")

;====================== Model Group setup ==========================================

;====================== Corners setup ==========================================

;====================== Checks and Asserts setup ============================================
ocnxlPutChecksAsserts(?netlist nil)

;====================== Job setup ==============================================
ocnxlJobSetup( '(
	"blockemail" "1"
	"configuretimeout" "300"
	"distributionmethod" "Local"
	"jobruntype" "ICRP"
	"estimatememoryvalue" ""
	"lingertimeout" "300"
	"maxjobs" "1"
	"name" "ADE XL Default"
	"preemptivestart" "1"
	"reconfigureimmediately" "1"
	"runtimeout" "-1"
	"showerrorwhenretrying" "1"
	"showoutputlogerror" "0"
	"startmaxjobsimmed" "1"
	"starttimeout" "300"
	"usesameprocess" "1"
) )

;====================== Disabled items =========================================

;====================== Run Mode Options ======================================

;====================== Starting Point Info ======================================

;====================== Run command ============================================
ocnxlRun( ?mode 'sweepsAndCorners ?nominalCornerEnabled t ?allCornersEnabled t ?allSweepsEnabled t)
ocnxlOutputSummary(?exprSummary t ?specSummary t ?detailed t ?wave t)
ocnxlOpenResults()

;====================== End XL Mode command ===================================
ocnxlEndXLMode()

/************/
/* RESULTS  */
/************/

;AC GAIN
selectResult( 'ac )
GainAC = i("/IPRB0/MINUS")

newWindow
addSubwindow
plot(GainAC)
addSubwindowTitle("Gain AC")

;POLE-ZERO 
addSubwindow
pzPlot( ?result "pz")
addSubwindowTitle("Poles and Zeros")

;DC GAIN
selectResult( 'dc)
outDC = i("/IPRB0/MINUS")

addSubwindow
plot(outDC)
addSubwindowTitle("Out DC")

GainDC = deriv(outDC)

addSubwindow
plot(GainDC)
addSubwindowTitle("Gain DC")

;Estimation of Static Nonlinearity
G0 = value(GainDC 0)
EP = (G0-value(GainDC 2u))/G0
EN = (G0-value(GainDC -2u))/G0

IM2 = abs((EP-EN)/4)
IM3 = abs((EP+EN)/8)

IM2_val = value(IM2 1)
IM3_val = value(IM3 1)

IM2_dB = dB20(IM2_val)
IM3_dB = dB20(IM3_val)

printf("*********************************")
printf("\nStatic nonlinearity results\n")
printf("IM2 = %4.2f dB\n" IM2_dB)
printf("IM3 = %4.2f dB\n" IM3_dB)
printf("*********************************")

;Noise
noiseSummary( 'integrated ?result "noise" ?noiseUnit "A" ?from FLOW ?to FHIGH ?paramValues list(1.0))

in_in = getData("in" ?result "noise")
in_in_dB = dB20(in_in)

addSubwindow
plot(in_in)
addSubwindowTitle("Noise")

in_in_2 = pow(in_in,2)
NBand = FHIGH - FLOW
IN_Noise_2 = integ( in_in_2, FLOW, FHIGH)
IN_Noise = sqrt(IN_Noise_2)
IN_Noise_val = value(IN_Noise 1.0) ;convert wave to val

IN_Noise_2_aver = IN_Noise_2/NBand
IN_Noise_aver = sqrt(IN_Noise_2_aver)
IN_Noise_aver_val = value(IN_Noise_aver 1.0) ; convert wave to val

printf("INPUT REFERRED NOISE CURRENT = %4.2e A(Hz) \n" IN_Noise_val)

printf("AVERAGE INPUT REFERRED NOISE CURRENT = %4.2e A/sqrt(Hz) \n" IN_Noise_aver_val)
printf("From: %4.2eHz to %4.2eHz" FLOW FHIGH)


 


