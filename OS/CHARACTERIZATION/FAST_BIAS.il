simulator( 'spectre )
;design(	 "/home/saul/projects/test_xfab1/Sim/FAST_BIAS/spectre/schematic/netlist/netlist")
design( "CHARACTERIZATION" "FAST_BIAS" "schematic")
createNetlist
resultsDir( "/home/saul/projects/test_xfab1/Sim/FAST_BIAS/spectre/schematic" )

load("OS/CHARACTERIZATION/global.il")

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

desVar(	  "WF1" WF1	)
desVar(	  "L1" L1	)
desVar(	  "NF1" NF1	)
desVar(	  "IDS1" IDS1	)
desVar(	  "VDS1" VDS1	)

desVar(	  "WF2" WF2	)
desVar(	  "L2" L2	)
desVar(	  "NF2" NF2	)
desVar(	  "IDS2" IDS2	)
desVar(	  "VDS2" VDS2	)

desVar(	  "WF3" WF3	)
desVar(	  "L3" L3	)
desVar(	  "NF3" NF3	)
desVar(	  "IDS3" IDS3	)
desVar(	  "VDS3" VDS3	)

desVar(	  "WF4" WF4	)
desVar(	  "L4" L4	)
desVar(	  "NF4" NF4	)
desVar(	  "IDS4" IDS4	)
desVar(	  "VDS4" VDS4	)

desVar(	  "WF5" WF5	)
desVar(	  "L5" L5	)
desVar(	  "NF5" NF5	)
desVar(	  "IDS5" IDS5	)
desVar(	  "VDS5" VDS5	)

desVar(	  "WF6" WF6	)
desVar(	  "L6" L6	)
desVar(	  "NF6" NF6	)
desVar(	  "IDS6" IDS6	)
desVar(	  "VDS6" VDS6	)

envOption(
	'analysisOrder  list("dc") 
)
temp( 27 ) 
run()


selectResults('dcOpInfo)

gm1 = getData("I0.M0.m1")->gm
rds1 = 1/getData("I0.M0.m1")->gds
cgd1 = 1e15*mag(getData("I0.M0.m1")->cgd)
cgs1 = 1e15*mag(getData("I0.M0.m1")->cgs)
cds1 = 1e15*mag(getData("I0.M0.m1")->cds)
cdb1 = 1e15*mag(getData("I0.M0.m1")->cdb)
vgs1 = getData("I0.M0.m1")->vgs
G1 = gm1*rds1
gm_id1 = gm1/IDS1
Ft1 = gm1/(2*3.1415927*(cgs1+cgd1))*1e15/1e6 ;Ft in MHz

gm2 = getData("I1.M0.m1")->gm
rds2 = 1/getData("I1.M0.m1")->gds
cgd2 = 1e15*mag(getData("I1.M0.m1")->cgd)
cgs2 = 1e15*mag(getData("I1.M0.m1")->cgs)
cds2 = 1e15*mag(getData("I1.M0.m1")->cds)
cdb2 = 1e15*mag(getData("I1.M0.m1")->cdb)
vgs2 = getData("I1.M0.m1")->vgs
G2 = gm2*rds2
gm_id2 = gm2/IDS2
Ft2 = gm2/(2*3.1415927*(cgs2+cgd2))*1e15/1e6 ;Ft in MHz

gm3 = getData("I2.M0.m1")->gm
rds3 = 1/getData("I2.M0.m1")->gds
cgd3 = 1e15*mag(getData("I2.M0.m1")->cgd)
cgs3 = 1e15*mag(getData("I2.M0.m1")->cgs)
cds3 = 1e15*mag(getData("I2.M0.m1")->cds)
cdb3 = 1e15*mag(getData("I2.M0.m1")->cdb)
vgs3 = getData("I2.M0.m1")->vgs
G3 = gm3*rds3
gm_id3 = gm3/IDS3
Ft3 = gm3/(2*3.1415927*(cgs3+cgd3))*1e15/1e6 ;Ft in MHz

gm4 = getData("I3.M0.m1")->gm
rds4 = 1/getData("I3.M0.m1")->gds
cgd4 = 1e15*mag(getData("I3.M0.m1")->cgd)
cgs4 = 1e15*mag(getData("I3.M0.m1")->cgs)
cds4 = 1e15*mag(getData("I3.M0.m1")->cds)
cdb4 = 1e15*mag(getData("I3.M0.m1")->cdb)
vgs4 = getData("I3.M0.m1")->vgs
G4 = gm4*rds4
gm_id4 = gm4/IDS4
Ft4 = gm4/(2*3.1415927*(cgs4+cgd4))*1e15/1e6 ;Ft in MHz

gm5 = getData("I4.M0.m1")->gm
rds5 = 1/getData("I4.M0.m1")->gds
cgd5 = 1e15*mag(getData("I4.M0.m1")->cgd)
cgs5 = 1e15*mag(getData("I4.M0.m1")->cgs)
cds5 = 1e15*mag(getData("I4.M0.m1")->cds)
cdb5 = 1e15*mag(getData("I4.M0.m1")->cdb)
vgs5 = getData("I4.M0.m1")->vgs
G5 = gm5*rds5
gm_id5 = gm5/IDS5
Ft5 = gm5/(2*3.1415927*(cgs5+cgd5))*1e15/1e6 ;Ft in MHz

gm6 = getData("I5.M0.m1")->gm
rds6 = 1/getData("I5.M0.m1")->gds
cgd6 = 1e15*mag(getData("I5.M0.m1")->cgd)
cgs6 = 1e15*mag(getData("I5.M0.m1")->cgs)
cds6 = 1e15*mag(getData("I5.M0.m1")->cds)
cdb6 = 1e15*mag(getData("I5.M0.m1")->cdb)
vgs6 = getData("I5.M0.m1")->vgs
G6 = gm6*rds6
gm_id6 = gm6/IDS6
Ft6 = gm6/(2*3.1415927*(cgs6+cgd6))*1e15/1e6 ;Ft in MHz

;****** Printing Results on the CIW log ********

printf("\n\n\n***********************\n")
printf("* FAST BIASING RESULTS *  \n")
printf("***********************\n\n")

printf("NMOS1: W1_tot = %4.2fum  L1 = %4.2fum  IDS1 = %4.4fmA  VDS1 = %4.2fV\n" 1e6*(WF1*NF1) 1e6*L1 1e3*IDS1 VDS1)
printf("  gm1 = %4.3fm\n  rds1 = %4.2f\n  cgs1 = %4.2ff\n  cgd1 = %4.2ff\n  cds1 = %4.2ff\n  cdb1 = %4.2ff\n  vgs1 = %5.4f\n  Gain1 = %4.2f\n" 1e3*gm1 rds1 cgs1 cgd1 cds1 cdb1 vgs1 G1)
printf("  gm_id1 = %4.2f\n  Ft1 = %4.2f MHz \n\n" gm_id1 Ft1)

printf("NMOS2: W2_tot = %4.2fum  L2 = %4.2fum  IDS2 = %4.4fmA  VDS2 = %4.2fV\n" 1e6*(WF2*NF2) 1e6*L2 1e3*IDS2 VDS2)
printf("  gm2 = %4.3fm\n  rds2 = %4.2f\n  cgs2 = %4.2ff\n  cgd2 = %4.2ff\n  cds2 = %4.2ff\n  cdb2 = %4.2ff\n  vgs2 = %5.4f\n  Gain2 = %4.2f\n" 1e3*gm2 rds2 cgs2 cgd2 cds2 cdb2 vgs2 G2)
printf("  gm_id2 = %4.2f\n  Ft2 = %4.2f MHz \n\n" gm_id2 Ft2)

printf("NMOS3: W3_tot = %4.2fum  L3 = %4.2fum  IDS3 = %4.4fmA  VDS3 = %4.2fV\n" 1e6*(WF3*NF3) 1e6*L3 1e3*IDS3 VDS3)
printf("  gm3 = %4.3fm\n  rds3 = %4.2f\n  cgs3 = %4.2ff\n  cgd3 = %4.2ff\n  cds3 = %4.2ff\n  cdb3 = %4.2ff\n  vgs3 = %5.4f\n  Gain3 = %4.2f\n" 1e3*gm3 rds3 cgs3 cgd3 cds3 cdb3 vgs3 G3)
printf("  gm_id3 = %4.2f\n  Ft3 = %4.2f MHz \n\n" gm_id3 Ft3)

printf("PMOS1: W4_tot = %4.2fum  L4 = %4.2fum  IDS4 = %4.4fmA  VDS4 = %4.2fV\n" 1e6*(WF4*NF4) 1e6*L4 1e3*IDS4 VDS4)
printf("  gm4 = %4.3fm\n  rds4 = %4.2f\n  cgs4 = %4.2ff\n  cgd4 = %4.2ff\n  cds4 = %4.2ff\n  cdb4 = %4.2ff\n  vgs4 = %5.4f\n  Gain4 = %4.2f\n" 1e3*gm4 rds4 cgs4 cgd4 cds4 cdb4 vgs4 G4)
printf("  gm_id4 = %4.2f\n  Ft4 = %4.2f MHz \n\n" gm_id4 Ft4)

printf("PMOS2: W5_tot = %4.2fum  L5 = %4.2fum  IDS5 = %4.4fmA  VDS5 = %4.2fV\n" 1e6*(WF5*NF5) 1e6*L5 1e3*IDS5 VDS5)
printf("  gm5 = %4.3fm\n  rds5 = %4.2f\n  cgs5 = %4.2ff\n  cgd5 = %4.2ff\n  cds5 = %4.2ff\n  cdb5 = %4.2ff\n  vgs5 = %5.4f\n  Gain5 = %4.2f\n" 1e3*gm5 rds5 cgs5 cgd5 cds5 cdb5 vgs5 G5)
printf("  gm_id5 = %4.2f\n  Ft5 = %4.2f MHz \n\n" gm_id5 Ft5)

printf("PMOS3: W6_tot = %4.2fum  L6 = %4.2fum  IDS6 = %4.4fmA  VDS6 = %4.2fV\n" 1e6*(WF6*NF6) 1e6*L6 1e3*IDS6 VDS6)
printf("  gm6 = %4.3fm\n  rds6 = %4.2f\n  cgs6 = %4.2ff\n  cgd6 = %4.2ff\n  cds6 = %4.2ff\n  cdb6 = %4.2ff\n  vgs6 = %5.4f\n  Gain6 = %4.2f\n" 1e3*gm6 rds6 cgs6 cgd6 cds6 cdb6 vgs6 G6)
printf("  gm_id6 = %4.2f\n  Ft6 = %4.2f MHz \n\n" gm_id6 Ft6)
