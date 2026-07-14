* XCOARSE TDC: delta_t=375ps
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
Vstop STOP_IN 0 PULSE(0 5 10.375n 0.1n 0.1n 100n 200n)

Xs_0_0 START_IN xcoarse_s0_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_0_1 xcoarse_s0_b xcoarse_s0_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_0_2 xcoarse_s0_c xcoarse_s0_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_0_3 xcoarse_s0_d xcoarse_start_s0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_0 xcoarse_start_s0 xcoarse_s1_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_1 xcoarse_s1_b xcoarse_s1_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_2 xcoarse_s1_c xcoarse_s1_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_3 xcoarse_s1_d xcoarse_start_s1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_0 xcoarse_start_s1 xcoarse_s2_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_1 xcoarse_s2_b xcoarse_s2_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_2 xcoarse_s2_c xcoarse_s2_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_3 xcoarse_s2_d xcoarse_start_s2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_0 xcoarse_start_s2 xcoarse_s3_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_1 xcoarse_s3_b xcoarse_s3_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_2 xcoarse_s3_c xcoarse_s3_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_3 xcoarse_s3_d xcoarse_start_s3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_0 xcoarse_start_s3 xcoarse_s4_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_1 xcoarse_s4_b xcoarse_s4_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_2 xcoarse_s4_c xcoarse_s4_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_3 xcoarse_s4_d xcoarse_start_s4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_0 xcoarse_start_s4 xcoarse_s5_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_1 xcoarse_s5_b xcoarse_s5_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_2 xcoarse_s5_c xcoarse_s5_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_3 xcoarse_s5_d xcoarse_start_s5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_0 xcoarse_start_s5 xcoarse_s6_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_1 xcoarse_s6_b xcoarse_s6_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_2 xcoarse_s6_c xcoarse_s6_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_3 xcoarse_s6_d xcoarse_start_s6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_0 xcoarse_start_s6 xcoarse_s7_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_1 xcoarse_s7_b xcoarse_s7_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_2 xcoarse_s7_c xcoarse_s7_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_3 xcoarse_s7_d xcoarse_start_s7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_0 xcoarse_start_s7 xcoarse_s8_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_1 xcoarse_s8_b xcoarse_s8_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_2 xcoarse_s8_c xcoarse_s8_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_3 xcoarse_s8_d xcoarse_start_s8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_0 xcoarse_start_s8 xcoarse_s9_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_1 xcoarse_s9_b xcoarse_s9_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_2 xcoarse_s9_c xcoarse_s9_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_3 xcoarse_s9_d xcoarse_start_s9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_0 xcoarse_start_s9 xcoarse_s10_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_1 xcoarse_s10_b xcoarse_s10_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_2 xcoarse_s10_c xcoarse_s10_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_3 xcoarse_s10_d xcoarse_start_s10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_0 xcoarse_start_s10 xcoarse_s11_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_1 xcoarse_s11_b xcoarse_s11_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_2 xcoarse_s11_c xcoarse_s11_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_3 xcoarse_s11_d xcoarse_start_s11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_0 xcoarse_start_s11 xcoarse_s12_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_1 xcoarse_s12_b xcoarse_s12_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_2 xcoarse_s12_c xcoarse_s12_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_3 xcoarse_s12_d xcoarse_start_s12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_0 xcoarse_start_s12 xcoarse_s13_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_1 xcoarse_s13_b xcoarse_s13_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_2 xcoarse_s13_c xcoarse_s13_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_3 xcoarse_s13_d xcoarse_start_s13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_0 xcoarse_start_s13 xcoarse_s14_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_1 xcoarse_s14_b xcoarse_s14_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_2 xcoarse_s14_c xcoarse_s14_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_3 xcoarse_s14_d xcoarse_start_s14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_0 xcoarse_start_s14 xcoarse_s15_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_1 xcoarse_s15_b xcoarse_s15_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_2 xcoarse_s15_c xcoarse_s15_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_3 xcoarse_s15_d xcoarse_start_s15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xp_0_0 STOP_IN xcoarse_p0_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_0_1 xcoarse_p0_b xcoarse_stop_s0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_1_0 xcoarse_stop_s0 xcoarse_p1_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_1_1 xcoarse_p1_b xcoarse_stop_s1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_2_0 xcoarse_stop_s1 xcoarse_p2_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_2_1 xcoarse_p2_b xcoarse_stop_s2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_3_0 xcoarse_stop_s2 xcoarse_p3_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_3_1 xcoarse_p3_b xcoarse_stop_s3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_4_0 xcoarse_stop_s3 xcoarse_p4_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_4_1 xcoarse_p4_b xcoarse_stop_s4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_5_0 xcoarse_stop_s4 xcoarse_p5_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_5_1 xcoarse_p5_b xcoarse_stop_s5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_6_0 xcoarse_stop_s5 xcoarse_p6_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_6_1 xcoarse_p6_b xcoarse_stop_s6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_7_0 xcoarse_stop_s6 xcoarse_p7_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_7_1 xcoarse_p7_b xcoarse_stop_s7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_8_0 xcoarse_stop_s7 xcoarse_p8_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_8_1 xcoarse_p8_b xcoarse_stop_s8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_9_0 xcoarse_stop_s8 xcoarse_p9_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_9_1 xcoarse_p9_b xcoarse_stop_s9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_10_0 xcoarse_stop_s9 xcoarse_p10_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_10_1 xcoarse_p10_b xcoarse_stop_s10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_11_0 xcoarse_stop_s10 xcoarse_p11_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_11_1 xcoarse_p11_b xcoarse_stop_s11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_12_0 xcoarse_stop_s11 xcoarse_p12_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_12_1 xcoarse_p12_b xcoarse_stop_s12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_13_0 xcoarse_stop_s12 xcoarse_p13_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_13_1 xcoarse_p13_b xcoarse_stop_s13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_14_0 xcoarse_stop_s13 xcoarse_p14_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_14_1 xcoarse_p14_b xcoarse_stop_s14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_15_0 xcoarse_stop_s14 xcoarse_p15_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xp_15_1 xcoarse_p15_b xcoarse_stop_s15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xdff_0 xcoarse_stop_s0 RN xcoarse_start_s0 xcoarse_q0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_1 xcoarse_stop_s1 RN xcoarse_start_s1 xcoarse_q1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_2 xcoarse_stop_s2 RN xcoarse_start_s2 xcoarse_q2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_3 xcoarse_stop_s3 RN xcoarse_start_s3 xcoarse_q3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_4 xcoarse_stop_s4 RN xcoarse_start_s4 xcoarse_q4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_5 xcoarse_stop_s5 RN xcoarse_start_s5 xcoarse_q5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_6 xcoarse_stop_s6 RN xcoarse_start_s6 xcoarse_q6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_7 xcoarse_stop_s7 RN xcoarse_start_s7 xcoarse_q7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_8 xcoarse_stop_s8 RN xcoarse_start_s8 xcoarse_q8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_9 xcoarse_stop_s9 RN xcoarse_start_s9 xcoarse_q9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_10 xcoarse_stop_s10 RN xcoarse_start_s10 xcoarse_q10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_11 xcoarse_stop_s11 RN xcoarse_start_s11 xcoarse_q11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_12 xcoarse_stop_s12 RN xcoarse_start_s12 xcoarse_q12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_13 xcoarse_stop_s13 RN xcoarse_start_s13 xcoarse_q13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_14 xcoarse_stop_s14 RN xcoarse_start_s14 xcoarse_q14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_15 xcoarse_stop_s15 RN xcoarse_start_s15 xcoarse_q15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1

.ic v(START_IN)=0 v(STOP_IN)=0 v(RN)=0
.options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25
.control
tran 0.05ns 20ns uic
meas tran xcoarse_q0_val FIND v(xcoarse_q0) AT=18n
meas tran xcoarse_q1_val FIND v(xcoarse_q1) AT=18n
meas tran xcoarse_q2_val FIND v(xcoarse_q2) AT=18n
meas tran xcoarse_q3_val FIND v(xcoarse_q3) AT=18n
meas tran xcoarse_q4_val FIND v(xcoarse_q4) AT=18n
meas tran xcoarse_q5_val FIND v(xcoarse_q5) AT=18n
meas tran xcoarse_q6_val FIND v(xcoarse_q6) AT=18n
meas tran xcoarse_q7_val FIND v(xcoarse_q7) AT=18n
meas tran xcoarse_q8_val FIND v(xcoarse_q8) AT=18n
meas tran xcoarse_q9_val FIND v(xcoarse_q9) AT=18n
meas tran xcoarse_q10_val FIND v(xcoarse_q10) AT=18n
meas tran xcoarse_q11_val FIND v(xcoarse_q11) AT=18n
meas tran xcoarse_q12_val FIND v(xcoarse_q12) AT=18n
meas tran xcoarse_q13_val FIND v(xcoarse_q13) AT=18n
meas tran xcoarse_q14_val FIND v(xcoarse_q14) AT=18n
meas tran xcoarse_q15_val FIND v(xcoarse_q15) AT=18n
echo "RESULT xcoarse_q0=$&xcoarse_q0_val xcoarse_q1=$&xcoarse_q1_val xcoarse_q2=$&xcoarse_q2_val xcoarse_q3=$&xcoarse_q3_val xcoarse_q4=$&xcoarse_q4_val xcoarse_q5=$&xcoarse_q5_val xcoarse_q6=$&xcoarse_q6_val xcoarse_q7=$&xcoarse_q7_val xcoarse_q8=$&xcoarse_q8_val xcoarse_q9=$&xcoarse_q9_val xcoarse_q10=$&xcoarse_q10_val xcoarse_q11=$&xcoarse_q11_val xcoarse_q12=$&xcoarse_q12_val xcoarse_q13=$&xcoarse_q13_val xcoarse_q14=$&xcoarse_q14_val xcoarse_q15=$&xcoarse_q15_val"
.endc
.end