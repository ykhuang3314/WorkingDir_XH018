simulator( 'spectre )
;design(	 "/home/ykhuang/workingdir/Sim/SP2_BIAS1/spectre/schematic/netlist/netlist")
design("Exercise6" "SP2_BIAS1" "schematic")
createNetlist
resultsDir( "/home/ykhuang/workingdir/Sim/SP2_BIAS1/spectre/schematic" )
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


FLOW = 1.0e6
FHIGH = 30.0e6

analysis('noise ?start FLOW  ?stop FHIGH  ?dec "10" ?p "/OUT"  
		?n "/gnd!"  ?oprobe ""  ?iprobe "/V2"  )
analysis('dc ?saveOppoint t  )


envOption(
	'analysisOrder  list("dc" "noise") 
)
temp( 27 ) 
run()

noiseSummary( 'integrated ?result "noise" ?noiseUnit "V" ?from FLOW ?to FHIGH )

vn_in = getData("in" ?result "noise")
vn_in_dB = dB20(vn_in)
plot(vn_in)

vn_in_2 = pow(vn_in,2)
NBand = FHIGH - FLOW
VN_Noise_2 = integ( vn_in_2, FLOW, FHIGH)
VN_Noise = sqrt(VN_Noise_2)
;IN_Noise_val = value(IN_Noise WF1) ;convert wave to val

VN_Noise_2_aver = VN_Noise_2/NBand
VN_Noise_aver = sqrt(VN_Noise_2_aver)
;IN_Noise_aver_val = value(IN_Noise_aver WF1) ; convert wave to val

printf("INPUT REFERRED NOISE VOLTAGE = %4.2e V(Hz) \n" VN_Noise)

printf("AVERAGE INPUT REFERRED NOISE CURRENT = %4.2e V/sqrt(Hz) \n" VN_Noise_aver)
printf("From: %4.2eHz to %4.2eHz" FLOW FHIGH)
