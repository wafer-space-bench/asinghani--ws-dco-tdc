* Vernier TDC: delta_t=1250ps
.param fnoicor=0
.param sw_stat_global=0
.param sw_stat_mismatch=0
.param mc_skew=3
.param res_mc_skew=3
.param cap_mc_skew=3
.include /home/anish/wafer_space_docker_based_starter_kit/pdk/gf180mcuD/libs.tech/ngspice/design.ngspice
.include /home/anish/wafer_space_docker_based_starter_kit/spice_sim/sm141064_typical.spice
.include /home/anish/wafer_space_docker_based_starter_kit/spice_sim/smbb000149_typical.spice
.include pdk/gf180mcuD/libs.ref/gf180mcu_fd_sc_mcu7t5v0/spice/gf180mcu_fd_sc_mcu7t5v0.spice

VDD_net VDD 0 5.0
VSS_net VSS 0 0

Vrn RN 0 PULSE(0 5 5n 0.1n 0.1n 20n 30n)
Vstart START_IN 0 PULSE(0 5 10n 0.1n 0.1n 10n 30n)
Vstop STOP_IN 0 PULSE(0 5 11.25n 0.1n 0.1n 10n 30n)

Xs_inv_0a START_IN s0m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_0b s0m start_s0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_1a start_s0 s1m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_1b s1m start_s1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_2a start_s1 s2m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_2b s2m start_s2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_3a start_s2 s3m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_3b s3m start_s3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_4a start_s3 s4m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_4b s4m start_s4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_5a start_s4 s5m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_5b s5m start_s5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_6a start_s5 s6m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_6b s6m start_s6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_7a start_s6 s7m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_7b s7m start_s7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_8a start_s7 s8m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_8b s8m start_s8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_9a start_s8 s9m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_9b s9m start_s9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_10a start_s9 s10m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_10b s10m start_s10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_11a start_s10 s11m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_11b s11m start_s11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_12a start_s11 s12m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_12b s12m start_s12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_13a start_s12 s13m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_13b s13m start_s13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_14a start_s13 s14m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_14b s14m start_s14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_15a start_s14 s15m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_inv_15b s15m start_s15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1

Xp_inv_0a STOP_IN p0m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_0b p0m stop_s0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_1a stop_s0 p1m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_1b p1m stop_s1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_2a stop_s1 p2m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_2b p2m stop_s2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_3a stop_s2 p3m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_3b p3m stop_s3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_4a stop_s3 p4m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_4b p4m stop_s4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_5a stop_s4 p5m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_5b p5m stop_s5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_6a stop_s5 p6m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_6b p6m stop_s6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_7a stop_s6 p7m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_7b p7m stop_s7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_8a stop_s7 p8m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_8b p8m stop_s8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_9a stop_s8 p9m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_9b p9m stop_s9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_10a stop_s9 p10m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_10b p10m stop_s10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_11a stop_s10 p11m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_11b p11m stop_s11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_12a stop_s11 p12m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_12b p12m stop_s12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_13a stop_s12 p13m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_13b p13m stop_s13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_14a stop_s13 p14m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_14b p14m stop_s14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_15a stop_s14 p15m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_inv_15b p15m stop_s15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4

Xdff_0 stop_s0 RN start_s0 q0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_1 stop_s1 RN start_s1 q1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_2 stop_s2 RN start_s2 q2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_3 stop_s3 RN start_s3 q3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_4 stop_s4 RN start_s4 q4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_5 stop_s5 RN start_s5 q5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_6 stop_s6 RN start_s6 q6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_7 stop_s7 RN start_s7 q7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_8 stop_s8 RN start_s8 q8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_9 stop_s9 RN start_s9 q9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_10 stop_s10 RN start_s10 q10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_11 stop_s11 RN start_s11 q11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_12 stop_s12 RN start_s12 q12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_13 stop_s13 RN start_s13 q13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_14 stop_s14 RN start_s14 q14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_15 stop_s15 RN start_s15 q15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1

.ic v(START_IN)=0 v(STOP_IN)=0 v(RN)=0
.options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25
.control
tran 0.01ns 25ns uic
meas tran q0_val FIND v(q0) AT=24.5n
meas tran q1_val FIND v(q1) AT=24.5n
meas tran q2_val FIND v(q2) AT=24.5n
meas tran q3_val FIND v(q3) AT=24.5n
meas tran q4_val FIND v(q4) AT=24.5n
meas tran q5_val FIND v(q5) AT=24.5n
meas tran q6_val FIND v(q6) AT=24.5n
meas tran q7_val FIND v(q7) AT=24.5n
meas tran q8_val FIND v(q8) AT=24.5n
meas tran q9_val FIND v(q9) AT=24.5n
meas tran q10_val FIND v(q10) AT=24.5n
meas tran q11_val FIND v(q11) AT=24.5n
meas tran q12_val FIND v(q12) AT=24.5n
meas tran q13_val FIND v(q13) AT=24.5n
meas tran q14_val FIND v(q14) AT=24.5n
meas tran q15_val FIND v(q15) AT=24.5n
echo "RESULT q0=$&q0_val q1=$&q1_val q2=$&q2_val q3=$&q3_val q4=$&q4_val q5=$&q5_val q6=$&q6_val q7=$&q7_val q8=$&q8_val q9=$&q9_val q10=$&q10_val q11=$&q11_val q12=$&q12_val q13=$&q13_val q14=$&q14_val q15=$&q15_val"
.endc
.end