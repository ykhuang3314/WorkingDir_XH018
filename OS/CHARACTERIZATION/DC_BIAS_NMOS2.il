;====================== Set to XL mode =========================================
ocnSetXLMode()
ocnxlProjectDir( "./Sim" )
ocnxlTargetCellView( "CHARACTERIZATION" "DC_BIAS_NMOS" "adexl" )
ocnxlResultsLocation( "" )
ocnxlSimResultsLocation( "" )
ocnxlMaxJobFail( 20 )

;====================== Tests setup ============================================

;---------- Test "CHARACTERIZATION:DC_BIAS_NMOS:VGS" ------------- 
ocnxlBeginTest("CHARACTERIZATION:DC_BIAS_NMOS:VGS")
simulator( 'spectre )
design( "CHARACTERIZATION" "DC_BIAS_NMOS" "schematic")
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
analysis('dc ?param "VGS"  ?start "0"  ?stop "1.8"  
		?step ".1"  )
desVar(	  "VDS" 1	)
desVar(	  "VGS" 1	)
envOption(
	'analysisOrder  list("dc" "pz" "dcmatch" "stb" "tran" "envlp" "ac" "lf" "noise" "xf" "sp" "pss" "pac" "pstb" "pnoise" "pxf" "psp" "qpss" "qpac" "qpnoise" "qpxf" "qpsp" "hb" "hbac" "hbstb" "hbnoise" "hbxf" "sens" "acmatch") 
)
option( ?categ 'turboOpts
	'apsplus  t 
	'uniMode  "APS" 
)
save( 'i "/M0/D" )
temp( 27 ) 
ocnxlOutputTerminal( "/M0/D" ?plot t ?save t)
ocnxlOutputExpr( "deriv(IDC(\"/M0/D\"))" ?name "gm" ?plot t ?evalType 'point)
ocnxlEndTest() ; "CHARACTERIZATION:DC_BIAS_NMOS:VGS"

;---------- Test "CHARACTERIZATION:DC_BIAS_NMOS:VDS" ------------- 
ocnxlBeginTest("CHARACTERIZATION:DC_BIAS_NMOS:VDS")
simulator( 'spectre )
design( "CHARACTERIZATION" "DC_BIAS_NMOS" "schematic")
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
analysis('dc ?param "VGS"  ?start "0"  ?stop "1.8"  
		?step ".1"  )
desVar(	  "VDS" 1	)
desVar(	  "VGS" 1	)
envOption(
	'analysisOrder  list("dc" "pz" "dcmatch" "stb" "tran" "envlp" "ac" "lf" "noise" "xf" "sp" "pss" "pac" "pstb" "pnoise" "pxf" "psp" "qpss" "qpac" "qpnoise" "qpxf" "qpsp" "hb" "hbac" "hbstb" "hbnoise" "hbxf" "sens" "acmatch") 
)
option( ?categ 'turboOpts
	'apsplus  t 
	'uniMode  "APS" 
)
save( 'i "/M0/D" )
temp( 27 ) 
ocnxlOutputTerminal( "/M0/D" ?plot t ?save t)
ocnxlOutputExpr( "deriv(IDC(\"/M0/D\"))" ?name "gm" ?plot t ?evalType 'point)
ocnxlEndTest() ; "CHARACTERIZATION:DC_BIAS_NMOS:VDS"

;====================== Sweeps setup ===========================================
ocnxlSweepVar("VDS" "0:0.1:1.8")
ocnxlSweepVar("VGS" "1")

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
