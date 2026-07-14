* FINE TDC: delta_t=1200ps
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
Vstop STOP_IN 0 PULSE(0 5 11.2n 0.1n 0.1n 100n 200n)

Xs_0_0 START_IN fine_s0_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_0_1 fine_s0_b fine_start_s0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_0 fine_start_s0 fine_s1_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_1 fine_s1_b fine_start_s1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_0 fine_start_s1 fine_s2_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_1 fine_s2_b fine_start_s2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_0 fine_start_s2 fine_s3_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_1 fine_s3_b fine_start_s3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_0 fine_start_s3 fine_s4_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_1 fine_s4_b fine_start_s4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_0 fine_start_s4 fine_s5_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_1 fine_s5_b fine_start_s5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_0 fine_start_s5 fine_s6_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_1 fine_s6_b fine_start_s6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_0 fine_start_s6 fine_s7_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_1 fine_s7_b fine_start_s7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_0 fine_start_s7 fine_s8_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_1 fine_s8_b fine_start_s8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_0 fine_start_s8 fine_s9_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_1 fine_s9_b fine_start_s9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_0 fine_start_s9 fine_s10_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_1 fine_s10_b fine_start_s10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_0 fine_start_s10 fine_s11_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_1 fine_s11_b fine_start_s11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_0 fine_start_s11 fine_s12_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_1 fine_s12_b fine_start_s12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_0 fine_start_s12 fine_s13_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_1 fine_s13_b fine_start_s13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_0 fine_start_s13 fine_s14_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_1 fine_s14_b fine_start_s14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_0 fine_start_s14 fine_s15_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_1 fine_s15_b fine_start_s15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xp_0_0 STOP_IN fine_p0_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_0_1 fine_p0_b fine_stop_s0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_1_0 fine_stop_s0 fine_p1_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_1_1 fine_p1_b fine_stop_s1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_2_0 fine_stop_s1 fine_p2_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_2_1 fine_p2_b fine_stop_s2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_3_0 fine_stop_s2 fine_p3_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_3_1 fine_p3_b fine_stop_s3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_4_0 fine_stop_s3 fine_p4_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_4_1 fine_p4_b fine_stop_s4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_5_0 fine_stop_s4 fine_p5_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_5_1 fine_p5_b fine_stop_s5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_6_0 fine_stop_s5 fine_p6_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_6_1 fine_p6_b fine_stop_s6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_7_0 fine_stop_s6 fine_p7_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_7_1 fine_p7_b fine_stop_s7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_8_0 fine_stop_s7 fine_p8_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_8_1 fine_p8_b fine_stop_s8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_9_0 fine_stop_s8 fine_p9_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_9_1 fine_p9_b fine_stop_s9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_10_0 fine_stop_s9 fine_p10_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_10_1 fine_p10_b fine_stop_s10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_11_0 fine_stop_s10 fine_p11_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_11_1 fine_p11_b fine_stop_s11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_12_0 fine_stop_s11 fine_p12_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_12_1 fine_p12_b fine_stop_s12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_13_0 fine_stop_s12 fine_p13_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_13_1 fine_p13_b fine_stop_s13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_14_0 fine_stop_s13 fine_p14_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_14_1 fine_p14_b fine_stop_s14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_15_0 fine_stop_s14 fine_p15_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_15_1 fine_p15_b fine_stop_s15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xdff_0 fine_stop_s0 RN fine_start_s0 fine_q0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_1 fine_stop_s1 RN fine_start_s1 fine_q1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_2 fine_stop_s2 RN fine_start_s2 fine_q2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_3 fine_stop_s3 RN fine_start_s3 fine_q3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_4 fine_stop_s4 RN fine_start_s4 fine_q4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_5 fine_stop_s5 RN fine_start_s5 fine_q5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_6 fine_stop_s6 RN fine_start_s6 fine_q6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_7 fine_stop_s7 RN fine_start_s7 fine_q7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_8 fine_stop_s8 RN fine_start_s8 fine_q8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_9 fine_stop_s9 RN fine_start_s9 fine_q9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_10 fine_stop_s10 RN fine_start_s10 fine_q10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_11 fine_stop_s11 RN fine_start_s11 fine_q11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_12 fine_stop_s12 RN fine_start_s12 fine_q12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_13 fine_stop_s13 RN fine_start_s13 fine_q13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_14 fine_stop_s14 RN fine_start_s14 fine_q14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_15 fine_stop_s15 RN fine_start_s15 fine_q15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1

.ic v(START_IN)=0 v(STOP_IN)=0 v(RN)=0
.options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25
.control
tran 0.05ns 20ns uic
meas tran fine_q0_val FIND v(fine_q0) AT=18n
meas tran fine_q1_val FIND v(fine_q1) AT=18n
meas tran fine_q2_val FIND v(fine_q2) AT=18n
meas tran fine_q3_val FIND v(fine_q3) AT=18n
meas tran fine_q4_val FIND v(fine_q4) AT=18n
meas tran fine_q5_val FIND v(fine_q5) AT=18n
meas tran fine_q6_val FIND v(fine_q6) AT=18n
meas tran fine_q7_val FIND v(fine_q7) AT=18n
meas tran fine_q8_val FIND v(fine_q8) AT=18n
meas tran fine_q9_val FIND v(fine_q9) AT=18n
meas tran fine_q10_val FIND v(fine_q10) AT=18n
meas tran fine_q11_val FIND v(fine_q11) AT=18n
meas tran fine_q12_val FIND v(fine_q12) AT=18n
meas tran fine_q13_val FIND v(fine_q13) AT=18n
meas tran fine_q14_val FIND v(fine_q14) AT=18n
meas tran fine_q15_val FIND v(fine_q15) AT=18n
echo "RESULT fine_q0=$&fine_q0_val fine_q1=$&fine_q1_val fine_q2=$&fine_q2_val fine_q3=$&fine_q3_val fine_q4=$&fine_q4_val fine_q5=$&fine_q5_val fine_q6=$&fine_q6_val fine_q7=$&fine_q7_val fine_q8=$&fine_q8_val fine_q9=$&fine_q9_val fine_q10=$&fine_q10_val fine_q11=$&fine_q11_val fine_q12=$&fine_q12_val fine_q13=$&fine_q13_val fine_q14=$&fine_q14_val fine_q15=$&fine_q15_val"
.endc
.end