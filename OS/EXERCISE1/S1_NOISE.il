simulator( 'spectre )
;design(	 "/home/saul/Sim/S1_NULLOR_NOISE/spectre/schematic/netlist/netlist")
design("EXERCISE1" "S1_NULLOR_NOISE" "schematic")
createNetlist
resultsDir( "/home/saul/Sim/S1_NULLOR_NOISE/spectre/schematic" )
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

FLOW = 100.0
FHIGH = 30.0e6

analysis('noise ?start FLOW  ?stop FHIGH  ?dec "10"  
		?oprobe "/IPRB0"  ?iprobe "/I5"  )
analysis('dc ?saveOppoint t  )
desVar(	  "IDS1" 0.8m	)
desVar(	  "L" 0.35u	)
desVar(	  "NF" 40	)
desVar(	  "WF" 20u	)
desVar(	  "R1" 100k	)
desVar(	  "R2" 400	)
desVar(	  "VDS1" 0.5)
desVar(	  "VGS1" 0.4331	)
envOption(
	'analysisOrder  list("dc" "noise") 
)
temp( 27 ) 
run()

noiseSummary( 'integrated ?result "noise" ?noiseUnit "A" ?from FLOW ?to FHIGH )

in_in = getData("in" ?result "noise")
in_in_dB = dB20(in_in)
plot(in_in)

in_in_2 = pow(in_in,2)
NBand = FHIGH - FLOW
IN_Noise_2 = integ( in_in_2, FLOW, FHIGH)
IN_Noise = sqrt(IN_Noise_2)
;IN_Noise_val = value(IN_Noise WF1) ;convert wave to val

IN_Noise_2_aver = IN_Noise_2/NBand
IN_Noise_aver = sqrt(IN_Noise_2_aver)
;IN_Noise_aver_val = value(IN_Noise_aver WF1) ; convert wave to val

printf("INPUT REFERRED NOISE VOLTAGE = %4.2e A(Hz) \n" IN_Noise)

printf("AVERAGE INPUT REFERRED NOISE CURRENT = %4.2e A/sqrt(Hz) \n" IN_Noise_aver)
printf("From: %4.2eHz to %4.2eHz" FLOW FHIGH)
