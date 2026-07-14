* COARSE TDC: delta_t=175ps
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

Vrn RN 0 PULSE(0 5 5n 0.1n 0.1n 100n 200n)
Vstart START_IN 0 PULSE(0 5 10n 0.1n 0.1n 100n 200n)
Vstop STOP_IN 0 PULSE(0 5 10.175n 0.1n 0.1n 100n 200n)

Xs_0_0 START_IN coarse_s0_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_0_1 coarse_s0_b coarse_start_s0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_0 coarse_start_s0 coarse_s1_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_1 coarse_s1_b coarse_start_s1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_0 coarse_start_s1 coarse_s2_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_1 coarse_s2_b coarse_start_s2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_0 coarse_start_s2 coarse_s3_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_1 coarse_s3_b coarse_start_s3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_0 coarse_start_s3 coarse_s4_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_1 coarse_s4_b coarse_start_s4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_0 coarse_start_s4 coarse_s5_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_1 coarse_s5_b coarse_start_s5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_0 coarse_start_s5 coarse_s6_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_1 coarse_s6_b coarse_start_s6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_0 coarse_start_s6 coarse_s7_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_1 coarse_s7_b coarse_start_s7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_0 coarse_start_s7 coarse_s8_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_1 coarse_s8_b coarse_start_s8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_0 coarse_start_s8 coarse_s9_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_1 coarse_s9_b coarse_start_s9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_0 coarse_start_s9 coarse_s10_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_1 coarse_s10_b coarse_start_s10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_0 coarse_start_s10 coarse_s11_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_1 coarse_s11_b coarse_start_s11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_0 coarse_start_s11 coarse_s12_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_1 coarse_s12_b coarse_start_s12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_0 coarse_start_s12 coarse_s13_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_1 coarse_s13_b coarse_start_s13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_0 coarse_start_s13 coarse_s14_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_1 coarse_s14_b coarse_start_s14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_0 coarse_start_s14 coarse_s15_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_1 coarse_s15_b coarse_start_s15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xp_0_0 STOP_IN coarse_p0_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_0_1 coarse_p0_b coarse_stop_s0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_1_0 coarse_stop_s0 coarse_p1_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_1_1 coarse_p1_b coarse_stop_s1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_2_0 coarse_stop_s1 coarse_p2_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_2_1 coarse_p2_b coarse_stop_s2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_3_0 coarse_stop_s2 coarse_p3_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_3_1 coarse_p3_b coarse_stop_s3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_4_0 coarse_stop_s3 coarse_p4_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_4_1 coarse_p4_b coarse_stop_s4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_5_0 coarse_stop_s4 coarse_p5_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_5_1 coarse_p5_b coarse_stop_s5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_6_0 coarse_stop_s5 coarse_p6_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_6_1 coarse_p6_b coarse_stop_s6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_7_0 coarse_stop_s6 coarse_p7_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_7_1 coarse_p7_b coarse_stop_s7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_8_0 coarse_stop_s7 coarse_p8_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_8_1 coarse_p8_b coarse_stop_s8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_9_0 coarse_stop_s8 coarse_p9_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_9_1 coarse_p9_b coarse_stop_s9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_10_0 coarse_stop_s9 coarse_p10_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_10_1 coarse_p10_b coarse_stop_s10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_11_0 coarse_stop_s10 coarse_p11_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_11_1 coarse_p11_b coarse_stop_s11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_12_0 coarse_stop_s11 coarse_p12_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_12_1 coarse_p12_b coarse_stop_s12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_13_0 coarse_stop_s12 coarse_p13_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_13_1 coarse_p13_b coarse_stop_s13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_14_0 coarse_stop_s13 coarse_p14_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_14_1 coarse_p14_b coarse_stop_s14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_15_0 coarse_stop_s14 coarse_p15_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_15_1 coarse_p15_b coarse_stop_s15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xdff_0 coarse_stop_s0 RN coarse_start_s0 coarse_q0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_1 coarse_stop_s1 RN coarse_start_s1 coarse_q1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_2 coarse_stop_s2 RN coarse_start_s2 coarse_q2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_3 coarse_stop_s3 RN coarse_start_s3 coarse_q3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_4 coarse_stop_s4 RN coarse_start_s4 coarse_q4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_5 coarse_stop_s5 RN coarse_start_s5 coarse_q5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_6 coarse_stop_s6 RN coarse_start_s6 coarse_q6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_7 coarse_stop_s7 RN coarse_start_s7 coarse_q7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_8 coarse_stop_s8 RN coarse_start_s8 coarse_q8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_9 coarse_stop_s9 RN coarse_start_s9 coarse_q9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_10 coarse_stop_s10 RN coarse_start_s10 coarse_q10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_11 coarse_stop_s11 RN coarse_start_s11 coarse_q11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_12 coarse_stop_s12 RN coarse_start_s12 coarse_q12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_13 coarse_stop_s13 RN coarse_start_s13 coarse_q13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_14 coarse_stop_s14 RN coarse_start_s14 coarse_q14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_15 coarse_stop_s15 RN coarse_start_s15 coarse_q15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1

.ic v(START_IN)=0 v(STOP_IN)=0 v(RN)=0
.options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25
.control
tran 0.05ns 20ns uic
meas tran coarse_q0_val FIND v(coarse_q0) AT=18n
meas tran coarse_q1_val FIND v(coarse_q1) AT=18n
meas tran coarse_q2_val FIND v(coarse_q2) AT=18n
meas tran coarse_q3_val FIND v(coarse_q3) AT=18n
meas tran coarse_q4_val FIND v(coarse_q4) AT=18n
meas tran coarse_q5_val FIND v(coarse_q5) AT=18n
meas tran coarse_q6_val FIND v(coarse_q6) AT=18n
meas tran coarse_q7_val FIND v(coarse_q7) AT=18n
meas tran coarse_q8_val FIND v(coarse_q8) AT=18n
meas tran coarse_q9_val FIND v(coarse_q9) AT=18n
meas tran coarse_q10_val FIND v(coarse_q10) AT=18n
meas tran coarse_q11_val FIND v(coarse_q11) AT=18n
meas tran coarse_q12_val FIND v(coarse_q12) AT=18n
meas tran coarse_q13_val FIND v(coarse_q13) AT=18n
meas tran coarse_q14_val FIND v(coarse_q14) AT=18n
meas tran coarse_q15_val FIND v(coarse_q15) AT=18n
echo "RESULT coarse_q0=$&coarse_q0_val coarse_q1=$&coarse_q1_val coarse_q2=$&coarse_q2_val coarse_q3=$&coarse_q3_val coarse_q4=$&coarse_q4_val coarse_q5=$&coarse_q5_val coarse_q6=$&coarse_q6_val coarse_q7=$&coarse_q7_val coarse_q8=$&coarse_q8_val coarse_q9=$&coarse_q9_val coarse_q10=$&coarse_q10_val coarse_q11=$&coarse_q11_val coarse_q12=$&coarse_q12_val coarse_q13=$&coarse_q13_val coarse_q14=$&coarse_q14_val coarse_q15=$&coarse_q15_val"
.endc
.end