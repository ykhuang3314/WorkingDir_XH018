simulator( 'spectre )

;design(	 "/home/saul/Sim/TRANS_S2_STATIC_LIN/spectre/schematic/netlist/netlist")
design(	 "DAY3" "TRANS_S2_STATIC_LIN" "schematic")
createNetlist()

resultsDir( "/home/saul/Sim/TRANS_S2_STATIC_LIN/spectre/schematic" )


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
analysis('dc ?saveOppoint t  ?param "IS"  ?start "-10u"  
		?stop "10u"  ?step "100n"  )
desVar(	  "IDS" 100u	)
desVar(	  "IS" 0	)
desVar(	  "L" 1u	)
desVar(	  "NF" 10	)
desVar(	  "vds" 0.5	)
desVar(	  "vgs" 0.4792	)
desVar(	  "WF" 10u	)
envOption(
	'analysisOrder  list("dc") 
)
temp( 27 ) 
run()
selectResult( 'dc )

Vout = v("/OUT")

GainDC = deriv(Vout)

newWindow()
;addSubwindow
plot(Vout)
addSubwindowTitle("Output Voltage")

addSubwindow
plot(GainDC)
addSubwindowTitle("DC Gain")

;Estimation of Static Nonlinearity
Amplitude = 2u

G0 = value(GainDC 0)
EP = (G0-value(GainDC Amplitude))/G0
EN = (G0-value(GainDC -Amplitude))/G0

D2 = abs((EP-EN)/8)
D3 = abs((EP+EN)/24)

IM2 = abs((EP-EN)/4)
IM3 = abs((EP+EN)/8)

IM2_dB = dB20(IM2)
IM3_dB = dB20(IM3)

D2_dB = dB20(D2)
D3_dB = dB20(D3)

printf("*********************************")
printf("\nStatic nonlinearity results\n")
printf("IM2 = %4.2f dB\n" IM2_dB)
printf("IM3 = %4.2f dB\n" IM3_dB)
printf("D2 = %4.2f dB\n" D2_dB)
printf("D3 = %4.2f dB\n" D3_dB)

printf("*********************************")

