;====================== Set to XL mode =========================================
ocnSetXLMode()
ocnxlProjectDir( "./Sim" )
ocnxlTargetCellView( "CHARACTERIZATION" "NOISE_NMOS" "adexl" )
ocnxlResultsLocation( "" )
ocnxlSimResultsLocation( "" )
ocnxlMaxJobFail( 20 )

;====================== Tests setup ============================================

;---------- Test "CHARACTERIZATION:NOISE_NMOS:1" ------------- 
ocnxlBeginTest("CHARACTERIZATION:NOISE_NMOS:1")
simulator( 'spectre )
design( "CHARACTERIZATION" "NOISE_NMOS" "schematic")
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

load("OS/CHARACTERIZATION/global.il")
FLOW = 1.0 ; Lower frequency 
FHIGH = 1e9  ; Higher frequency

analysis('dc ?saveOppoint t  )
analysis('noise ?start FLOW  ?stop FHIGH  ?dec "10"  
		?oprobe "/IPRB1"  ?iprobe "/V2"  )
desVar(	  "IDS" IDS1	)
desVar(	  "L" L1)
desVar(	  "NF" NF1	)
desVar(	  "VDS" VDS1	)
desVar(	  "WF" WF1	)
envOption(
	'firstRun  t 
	'analysisOrder  list("dc" "noise" "pz" "dcmatch" "stb" "tran" "envlp" "ac" "lf" "xf" "sp" "pss" "pac" "pstb" "pnoise" "pxf" "psp" "qpss" "qpac" "qpnoise" "qpxf" "qpsp" "hb" "hbac" "hbstb" "hbnoise" "hbxf" "sens" "acmatch") 
)
temp( 27 ) 
ocnxlOutputExpr( "getData(\"in\" ?result \"noise\")" ?name "input noise; A / sqrt(Hz)" ?plot t)
ocnxlEndTest() ; "CHARACTERIZATION:NOISE_NMOS:1"

;---------- Test "CHARACTERIZATION:NOISE_NMOS:2" ------------- 
ocnxlBeginTest("CHARACTERIZATION:NOISE_NMOS:2")
simulator( 'spectre )
design( "CHARACTERIZATION" "NOISE_NMOS" "schematic")
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
analysis('dc ?saveOppoint t  )
analysis('noise ?start FLOW  ?stop FHIGH  ?dec "10"  
		?oprobe "/IPRB0"  ?iprobe "/I6"  )
desVar(	  "IDS" IDS1	)
desVar(	  "L" L1)
desVar(	  "NF" NF1	)
desVar(	  "VDS" VDS1	)
desVar(	  "WF" WF1	)
envOption(
	'firstRun  t 
	'analysisOrder  list("dc" "noise" "pz" "dcmatch" "stb" "tran" "envlp" "ac" "lf" "xf" "sp" "pss" "pac" "pstb" "pnoise" "pxf" "psp" "qpss" "qpac" "qpnoise" "qpxf" "qpsp" "hb" "hbac" "hbstb" "hbnoise" "hbxf" "sens" "acmatch") 
)
temp( 27 ) 
ocnxlOutputExpr( "getData(\"in\" ?result \"noise\")" ?name "input noise; A / sqrt(Hz)" ?plot t)
ocnxlEndTest() ; "CHARACTERIZATION:NOISE_NMOS:2"

;====================== Sweeps setup ===========================================
ocnxlSweepVar("IDS" "IDS1")
ocnxlSweepVar("L" "L1")
ocnxlSweepVar("NF" "NF1")
ocnxlSweepVar("VDS" "VDS1")
ocnxlSweepVar("WF" "WF1")

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
	"maxjobs" "2"
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

;*********************************
;* Input refferred noise current *
;*********************************
ocnxlOpenResults(?testName "CHARACTERIZATION:NOISE_NMOS:2")
selectResults('noise)

in_in = getData("in" ?result "noise")
in_in_dB = dB20(in_in)

;********************************
;* Input referred noise voltage *
;********************************
ocnxlOpenResults(?testName "CHARACTERIZATION:NOISE_NMOS:1")
selectResults('noise)

vn_in = getData("in" ?result "noise")
vn_in_dB = dB20(vn_in)

vn_out = getData("out" ?result "noise")
vn_out_dB = dB20(vn_out)

;====================== End XL Mode command ===================================
ocnxlEndXLMode()

;*******************
;* Present results *
;*******************

;*******************
;*  Noise Summary  *
;*******************
noiseSummary( 'integrated ?result "noise" ?noiseUnit "V" ?from FLOW ?to FHIGH )

vn_in_2 = pow(vn_in,2)
NBand = FHIGH - FLOW
IN_Noise_2 = integ( vn_in_2, FLOW, FHIGH)
IN_Noise = sqrt(IN_Noise_2)
IN_Noise_val = value(IN_Noise WF1) ;convert wave to val

IN_Noise_2_aver = IN_Noise_2/NBand
IN_Noise_aver = sqrt(IN_Noise_2_aver)
IN_Noise_aver_val = value(IN_Noise_aver WF1) ; convert wave to val

printf("INPUT REFERRED NOISE VOLTAGE = %4.2e V(Hz) \n" IN_Noise_val)

printf("AVERAGE INPUT REFERRED NOISE VOLTAGE = %4.2e V/sqrt(Hz) \n" IN_Noise_aver_val)
printf("From: %4.2eHz to %4.2eHz" FLOW FHIGH)

clearAll()

newWindow()
plot( in_in ?expr '( "Input noise I NMOS"))
addSubwindow()
plot( in_in_dB ?expr '( "Input noise I NMOS dB"))

newWindow()
plot( vn_in ?expr '( "input noise V NMOS"))

addSubwindow()
plot( vn_in_dB ?expr '( "input noise V dB NMOS"))

addSubwindow()
plot( vn_out_dB ?expr '( "Output noise I dB NMOS"))






