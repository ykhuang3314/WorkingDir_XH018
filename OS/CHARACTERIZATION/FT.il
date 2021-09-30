;====================== Set to XL mode =========================================
ocnSetXLMode()
ocnxlProjectDir( "./Sim" )
ocnxlTargetCellView( "CHARACTERIZATION" "FT" "adexl" )
ocnxlResultsLocation( "" )
ocnxlSimResultsLocation( "" )
ocnxlMaxJobFail( 20 )

;====================== Tests setup ============================================


;---------- Test "CHARACTERIZATION:FT:1" ------------- 
ocnxlBeginTest("CHARACTERIZATION:FT:1")
simulator( 'spectre )
design( "CHARACTERIZATION" "FT" "schematic")
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
analysis('ac ?start "1"  ?stop "100G"  ?dec "10"  )

load("OS/CHARACTERIZATION/global.il")

desVar(	  "IDS" IDS1	)
desVar(	  "L" L1	)
desVar(	  "NF" NF1	)
desVar(	  "VDS" VDS1	)
desVar(	  "WF" WF1	)

envOption(
	'analysisOrder  list("dc" "ac" "pz" "dcmatch" "stb" "tran" "envlp" "lf" "noise" "xf" "sp" "pss" "pac" "pstb" "pnoise" "pxf" "psp" "qpss" "qpac" "qpnoise" "qpxf" "qpsp" "hb" "hbac" "hbstb" "hbnoise" "hbxf" "sens" "acmatch") 
)
option( ?categ 'turboOpts
	'apsplus  t 
	'uniMode  "APS" 
)
save( 'i "/IPRB0/MINUS" "G" )
temp( 27 ) 
ocnxlOutputTerminal( "/IPRB0/MINUS" ?plot t ?save t)
ocnxlEndTest() ; "CHARACTERIZATION:FT:1"

;====================== Sweeps setup ===========================================
ocnxlSweepVar("IDS" "{From/To}Decade:1u:10:1m{From/To}")
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
	"maxjobs" "12"
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

; ****************************
;        Generate FT
; ****************************

Gain = dB20(i("/IPRB0/MINUS" ?result "ac"))
FT = cross( Gain 0 1 'falling )

newWindow
plot( Gain ?expr '( "Gain" ) )
addSubwindowTitle( "Current Gain vs. Freq" )
addSubwindow()
plot(FT)
addSubwindowTitle( "FT vs. IDS" )


; *********************
; * Generate FT vs GM
; *********************

;IDS = xval(FT)

vin = v("G" ?result "ac")
gm1 = i("/IPRB0/MINUS" ?result "ac")/vin
gm1_v = value(gm1 10)

IDS = xval(gm1_v)
gm_id = abs(gm1_v/IDS)

newWindow()
plot(gm_id)
addSubwindowTitle( "GM/ID vs. ID" )

addSubwindow()
ocnYvsYplot(?wavex gm_id ?wavey FT)
addSubwindowTitle( "FT vs. GM/ID" )

