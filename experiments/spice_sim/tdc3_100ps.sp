* 3-Level Vernier TDC: delta_t=100ps
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
Vstop STOP_IN 0 PULSE(0 5 10.1n 0.1n 0.1n 100n 200n)

Xfine_s_0_0 START_IN fine_s0_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_0_1 fine_s0_b fine_start_s0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_1_0 fine_start_s0 fine_s1_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_1_1 fine_s1_b fine_start_s1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_2_0 fine_start_s1 fine_s2_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_2_1 fine_s2_b fine_start_s2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_3_0 fine_start_s2 fine_s3_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_3_1 fine_s3_b fine_start_s3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_4_0 fine_start_s3 fine_s4_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_4_1 fine_s4_b fine_start_s4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_5_0 fine_start_s4 fine_s5_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_5_1 fine_s5_b fine_start_s5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_6_0 fine_start_s5 fine_s6_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_6_1 fine_s6_b fine_start_s6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_7_0 fine_start_s6 fine_s7_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_7_1 fine_s7_b fine_start_s7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_8_0 fine_start_s7 fine_s8_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_8_1 fine_s8_b fine_start_s8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_9_0 fine_start_s8 fine_s9_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_9_1 fine_s9_b fine_start_s9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_10_0 fine_start_s9 fine_s10_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_10_1 fine_s10_b fine_start_s10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_11_0 fine_start_s10 fine_s11_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_11_1 fine_s11_b fine_start_s11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_12_0 fine_start_s11 fine_s12_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_12_1 fine_s12_b fine_start_s12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_13_0 fine_start_s12 fine_s13_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_13_1 fine_s13_b fine_start_s13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_14_0 fine_start_s13 fine_s14_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_14_1 fine_s14_b fine_start_s14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_15_0 fine_start_s14 fine_s15_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_s_15_1 fine_s15_b fine_start_s15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xfine_p_0_0 STOP_IN fine_p0_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_0_1 fine_p0_b fine_stop_s0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_1_0 fine_stop_s0 fine_p1_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_1_1 fine_p1_b fine_stop_s1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_2_0 fine_stop_s1 fine_p2_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_2_1 fine_p2_b fine_stop_s2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_3_0 fine_stop_s2 fine_p3_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_3_1 fine_p3_b fine_stop_s3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_4_0 fine_stop_s3 fine_p4_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_4_1 fine_p4_b fine_stop_s4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_5_0 fine_stop_s4 fine_p5_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_5_1 fine_p5_b fine_stop_s5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_6_0 fine_stop_s5 fine_p6_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_6_1 fine_p6_b fine_stop_s6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_7_0 fine_stop_s6 fine_p7_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_7_1 fine_p7_b fine_stop_s7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_8_0 fine_stop_s7 fine_p8_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_8_1 fine_p8_b fine_stop_s8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_9_0 fine_stop_s8 fine_p9_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_9_1 fine_p9_b fine_stop_s9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_10_0 fine_stop_s9 fine_p10_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_10_1 fine_p10_b fine_stop_s10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_11_0 fine_stop_s10 fine_p11_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_11_1 fine_p11_b fine_stop_s11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_12_0 fine_stop_s11 fine_p12_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_12_1 fine_p12_b fine_stop_s12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_13_0 fine_stop_s12 fine_p13_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_13_1 fine_p13_b fine_stop_s13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_14_0 fine_stop_s13 fine_p14_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_14_1 fine_p14_b fine_stop_s14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_15_0 fine_stop_s14 fine_p15_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_p_15_1 fine_p15_b fine_stop_s15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xfine_dff_0 fine_stop_s0 RN fine_start_s0 fine_q0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xfine_dff_1 fine_stop_s1 RN fine_start_s1 fine_q1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xfine_dff_2 fine_stop_s2 RN fine_start_s2 fine_q2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xfine_dff_3 fine_stop_s3 RN fine_start_s3 fine_q3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xfine_dff_4 fine_stop_s4 RN fine_start_s4 fine_q4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xfine_dff_5 fine_stop_s5 RN fine_start_s5 fine_q5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xfine_dff_6 fine_stop_s6 RN fine_start_s6 fine_q6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xfine_dff_7 fine_stop_s7 RN fine_start_s7 fine_q7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xfine_dff_8 fine_stop_s8 RN fine_start_s8 fine_q8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xfine_dff_9 fine_stop_s9 RN fine_start_s9 fine_q9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xfine_dff_10 fine_stop_s10 RN fine_start_s10 fine_q10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xfine_dff_11 fine_stop_s11 RN fine_start_s11 fine_q11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xfine_dff_12 fine_stop_s12 RN fine_start_s12 fine_q12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xfine_dff_13 fine_stop_s13 RN fine_start_s13 fine_q13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xfine_dff_14 fine_stop_s14 RN fine_start_s14 fine_q14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xfine_dff_15 fine_stop_s15 RN fine_start_s15 fine_q15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xcoarse_s_0_0 START_IN coarse_s0_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_0_1 coarse_s0_b coarse_start_s0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_1_0 coarse_start_s0 coarse_s1_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_1_1 coarse_s1_b coarse_start_s1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_2_0 coarse_start_s1 coarse_s2_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_2_1 coarse_s2_b coarse_start_s2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_3_0 coarse_start_s2 coarse_s3_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_3_1 coarse_s3_b coarse_start_s3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_4_0 coarse_start_s3 coarse_s4_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_4_1 coarse_s4_b coarse_start_s4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_5_0 coarse_start_s4 coarse_s5_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_5_1 coarse_s5_b coarse_start_s5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_6_0 coarse_start_s5 coarse_s6_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_6_1 coarse_s6_b coarse_start_s6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_7_0 coarse_start_s6 coarse_s7_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_7_1 coarse_s7_b coarse_start_s7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_8_0 coarse_start_s7 coarse_s8_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_8_1 coarse_s8_b coarse_start_s8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_9_0 coarse_start_s8 coarse_s9_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_9_1 coarse_s9_b coarse_start_s9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_10_0 coarse_start_s9 coarse_s10_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_10_1 coarse_s10_b coarse_start_s10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_11_0 coarse_start_s10 coarse_s11_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_11_1 coarse_s11_b coarse_start_s11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_12_0 coarse_start_s11 coarse_s12_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_12_1 coarse_s12_b coarse_start_s12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_13_0 coarse_start_s12 coarse_s13_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_13_1 coarse_s13_b coarse_start_s13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_14_0 coarse_start_s13 coarse_s14_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_14_1 coarse_s14_b coarse_start_s14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_15_0 coarse_start_s14 coarse_s15_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_s_15_1 coarse_s15_b coarse_start_s15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xcoarse_p_0_0 STOP_IN coarse_p0_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_0_1 coarse_p0_b coarse_stop_s0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_1_0 coarse_stop_s0 coarse_p1_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_1_1 coarse_p1_b coarse_stop_s1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_2_0 coarse_stop_s1 coarse_p2_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_2_1 coarse_p2_b coarse_stop_s2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_3_0 coarse_stop_s2 coarse_p3_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_3_1 coarse_p3_b coarse_stop_s3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_4_0 coarse_stop_s3 coarse_p4_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_4_1 coarse_p4_b coarse_stop_s4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_5_0 coarse_stop_s4 coarse_p5_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_5_1 coarse_p5_b coarse_stop_s5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_6_0 coarse_stop_s5 coarse_p6_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_6_1 coarse_p6_b coarse_stop_s6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_7_0 coarse_stop_s6 coarse_p7_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_7_1 coarse_p7_b coarse_stop_s7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_8_0 coarse_stop_s7 coarse_p8_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_8_1 coarse_p8_b coarse_stop_s8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_9_0 coarse_stop_s8 coarse_p9_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_9_1 coarse_p9_b coarse_stop_s9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_10_0 coarse_stop_s9 coarse_p10_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_10_1 coarse_p10_b coarse_stop_s10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_11_0 coarse_stop_s10 coarse_p11_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_11_1 coarse_p11_b coarse_stop_s11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_12_0 coarse_stop_s11 coarse_p12_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_12_1 coarse_p12_b coarse_stop_s12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_13_0 coarse_stop_s12 coarse_p13_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_13_1 coarse_p13_b coarse_stop_s13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_14_0 coarse_stop_s13 coarse_p14_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_14_1 coarse_p14_b coarse_stop_s14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_15_0 coarse_stop_s14 coarse_p15_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_p_15_1 coarse_p15_b coarse_stop_s15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xcoarse_dff_0 coarse_stop_s0 RN coarse_start_s0 coarse_q0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xcoarse_dff_1 coarse_stop_s1 RN coarse_start_s1 coarse_q1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xcoarse_dff_2 coarse_stop_s2 RN coarse_start_s2 coarse_q2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xcoarse_dff_3 coarse_stop_s3 RN coarse_start_s3 coarse_q3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xcoarse_dff_4 coarse_stop_s4 RN coarse_start_s4 coarse_q4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xcoarse_dff_5 coarse_stop_s5 RN coarse_start_s5 coarse_q5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xcoarse_dff_6 coarse_stop_s6 RN coarse_start_s6 coarse_q6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xcoarse_dff_7 coarse_stop_s7 RN coarse_start_s7 coarse_q7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xcoarse_dff_8 coarse_stop_s8 RN coarse_start_s8 coarse_q8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xcoarse_dff_9 coarse_stop_s9 RN coarse_start_s9 coarse_q9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xcoarse_dff_10 coarse_stop_s10 RN coarse_start_s10 coarse_q10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xcoarse_dff_11 coarse_stop_s11 RN coarse_start_s11 coarse_q11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xcoarse_dff_12 coarse_stop_s12 RN coarse_start_s12 coarse_q12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xcoarse_dff_13 coarse_stop_s13 RN coarse_start_s13 coarse_q13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xcoarse_dff_14 coarse_stop_s14 RN coarse_start_s14 coarse_q14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xcoarse_dff_15 coarse_stop_s15 RN coarse_start_s15 coarse_q15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xxcoarse_s_0_0 START_IN xcoarse_s0_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_0_1 xcoarse_s0_b xcoarse_s0_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_0_2 xcoarse_s0_c xcoarse_s0_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_0_3 xcoarse_s0_d xcoarse_start_s0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_1_0 xcoarse_start_s0 xcoarse_s1_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_1_1 xcoarse_s1_b xcoarse_s1_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_1_2 xcoarse_s1_c xcoarse_s1_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_1_3 xcoarse_s1_d xcoarse_start_s1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_2_0 xcoarse_start_s1 xcoarse_s2_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_2_1 xcoarse_s2_b xcoarse_s2_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_2_2 xcoarse_s2_c xcoarse_s2_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_2_3 xcoarse_s2_d xcoarse_start_s2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_3_0 xcoarse_start_s2 xcoarse_s3_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_3_1 xcoarse_s3_b xcoarse_s3_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_3_2 xcoarse_s3_c xcoarse_s3_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_3_3 xcoarse_s3_d xcoarse_start_s3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_4_0 xcoarse_start_s3 xcoarse_s4_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_4_1 xcoarse_s4_b xcoarse_s4_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_4_2 xcoarse_s4_c xcoarse_s4_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_4_3 xcoarse_s4_d xcoarse_start_s4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_5_0 xcoarse_start_s4 xcoarse_s5_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_5_1 xcoarse_s5_b xcoarse_s5_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_5_2 xcoarse_s5_c xcoarse_s5_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_5_3 xcoarse_s5_d xcoarse_start_s5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_6_0 xcoarse_start_s5 xcoarse_s6_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_6_1 xcoarse_s6_b xcoarse_s6_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_6_2 xcoarse_s6_c xcoarse_s6_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_6_3 xcoarse_s6_d xcoarse_start_s6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_7_0 xcoarse_start_s6 xcoarse_s7_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_7_1 xcoarse_s7_b xcoarse_s7_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_7_2 xcoarse_s7_c xcoarse_s7_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_7_3 xcoarse_s7_d xcoarse_start_s7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_8_0 xcoarse_start_s7 xcoarse_s8_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_8_1 xcoarse_s8_b xcoarse_s8_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_8_2 xcoarse_s8_c xcoarse_s8_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_8_3 xcoarse_s8_d xcoarse_start_s8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_9_0 xcoarse_start_s8 xcoarse_s9_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_9_1 xcoarse_s9_b xcoarse_s9_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_9_2 xcoarse_s9_c xcoarse_s9_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_9_3 xcoarse_s9_d xcoarse_start_s9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_10_0 xcoarse_start_s9 xcoarse_s10_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_10_1 xcoarse_s10_b xcoarse_s10_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_10_2 xcoarse_s10_c xcoarse_s10_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_10_3 xcoarse_s10_d xcoarse_start_s10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_11_0 xcoarse_start_s10 xcoarse_s11_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_11_1 xcoarse_s11_b xcoarse_s11_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_11_2 xcoarse_s11_c xcoarse_s11_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_11_3 xcoarse_s11_d xcoarse_start_s11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_12_0 xcoarse_start_s11 xcoarse_s12_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_12_1 xcoarse_s12_b xcoarse_s12_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_12_2 xcoarse_s12_c xcoarse_s12_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_12_3 xcoarse_s12_d xcoarse_start_s12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_13_0 xcoarse_start_s12 xcoarse_s13_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_13_1 xcoarse_s13_b xcoarse_s13_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_13_2 xcoarse_s13_c xcoarse_s13_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_13_3 xcoarse_s13_d xcoarse_start_s13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_14_0 xcoarse_start_s13 xcoarse_s14_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_14_1 xcoarse_s14_b xcoarse_s14_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_14_2 xcoarse_s14_c xcoarse_s14_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_14_3 xcoarse_s14_d xcoarse_start_s14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_15_0 xcoarse_start_s14 xcoarse_s15_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_15_1 xcoarse_s15_b xcoarse_s15_c VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_15_2 xcoarse_s15_c xcoarse_s15_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_s_15_3 xcoarse_s15_d xcoarse_start_s15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xxcoarse_p_0_0 STOP_IN xcoarse_p0_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_0_1 xcoarse_p0_b xcoarse_stop_s0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_1_0 xcoarse_stop_s0 xcoarse_p1_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_1_1 xcoarse_p1_b xcoarse_stop_s1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_2_0 xcoarse_stop_s1 xcoarse_p2_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_2_1 xcoarse_p2_b xcoarse_stop_s2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_3_0 xcoarse_stop_s2 xcoarse_p3_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_3_1 xcoarse_p3_b xcoarse_stop_s3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_4_0 xcoarse_stop_s3 xcoarse_p4_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_4_1 xcoarse_p4_b xcoarse_stop_s4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_5_0 xcoarse_stop_s4 xcoarse_p5_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_5_1 xcoarse_p5_b xcoarse_stop_s5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_6_0 xcoarse_stop_s5 xcoarse_p6_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_6_1 xcoarse_p6_b xcoarse_stop_s6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_7_0 xcoarse_stop_s6 xcoarse_p7_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_7_1 xcoarse_p7_b xcoarse_stop_s7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_8_0 xcoarse_stop_s7 xcoarse_p8_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_8_1 xcoarse_p8_b xcoarse_stop_s8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_9_0 xcoarse_stop_s8 xcoarse_p9_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_9_1 xcoarse_p9_b xcoarse_stop_s9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_10_0 xcoarse_stop_s9 xcoarse_p10_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_10_1 xcoarse_p10_b xcoarse_stop_s10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_11_0 xcoarse_stop_s10 xcoarse_p11_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_11_1 xcoarse_p11_b xcoarse_stop_s11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_12_0 xcoarse_stop_s11 xcoarse_p12_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_12_1 xcoarse_p12_b xcoarse_stop_s12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_13_0 xcoarse_stop_s12 xcoarse_p13_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_13_1 xcoarse_p13_b xcoarse_stop_s13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_14_0 xcoarse_stop_s13 xcoarse_p14_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_14_1 xcoarse_p14_b xcoarse_stop_s14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_15_0 xcoarse_stop_s14 xcoarse_p15_b VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_p_15_1 xcoarse_p15_b xcoarse_stop_s15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_16
Xxcoarse_dff_0 xcoarse_stop_s0 RN xcoarse_start_s0 xcoarse_q0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xxcoarse_dff_1 xcoarse_stop_s1 RN xcoarse_start_s1 xcoarse_q1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xxcoarse_dff_2 xcoarse_stop_s2 RN xcoarse_start_s2 xcoarse_q2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xxcoarse_dff_3 xcoarse_stop_s3 RN xcoarse_start_s3 xcoarse_q3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xxcoarse_dff_4 xcoarse_stop_s4 RN xcoarse_start_s4 xcoarse_q4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xxcoarse_dff_5 xcoarse_stop_s5 RN xcoarse_start_s5 xcoarse_q5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xxcoarse_dff_6 xcoarse_stop_s6 RN xcoarse_start_s6 xcoarse_q6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xxcoarse_dff_7 xcoarse_stop_s7 RN xcoarse_start_s7 xcoarse_q7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xxcoarse_dff_8 xcoarse_stop_s8 RN xcoarse_start_s8 xcoarse_q8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xxcoarse_dff_9 xcoarse_stop_s9 RN xcoarse_start_s9 xcoarse_q9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xxcoarse_dff_10 xcoarse_stop_s10 RN xcoarse_start_s10 xcoarse_q10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xxcoarse_dff_11 xcoarse_stop_s11 RN xcoarse_start_s11 xcoarse_q11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xxcoarse_dff_12 xcoarse_stop_s12 RN xcoarse_start_s12 xcoarse_q12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xxcoarse_dff_13 xcoarse_stop_s13 RN xcoarse_start_s13 xcoarse_q13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xxcoarse_dff_14 xcoarse_stop_s14 RN xcoarse_start_s14 xcoarse_q14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xxcoarse_dff_15 xcoarse_stop_s15 RN xcoarse_start_s15 xcoarse_q15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1

.ic v(START_IN)=0 v(STOP_IN)=0 v(RN)=0
.options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25
.control
tran 0.01ns 25ns uic
meas tran fine_q0_val FIND v(fine_q0) AT=20n
meas tran fine_q1_val FIND v(fine_q1) AT=20n
meas tran fine_q2_val FIND v(fine_q2) AT=20n
meas tran fine_q3_val FIND v(fine_q3) AT=20n
meas tran fine_q4_val FIND v(fine_q4) AT=20n
meas tran fine_q5_val FIND v(fine_q5) AT=20n
meas tran fine_q6_val FIND v(fine_q6) AT=20n
meas tran fine_q7_val FIND v(fine_q7) AT=20n
meas tran fine_q8_val FIND v(fine_q8) AT=20n
meas tran fine_q9_val FIND v(fine_q9) AT=20n
meas tran fine_q10_val FIND v(fine_q10) AT=20n
meas tran fine_q11_val FIND v(fine_q11) AT=20n
meas tran fine_q12_val FIND v(fine_q12) AT=20n
meas tran fine_q13_val FIND v(fine_q13) AT=20n
meas tran fine_q14_val FIND v(fine_q14) AT=20n
meas tran fine_q15_val FIND v(fine_q15) AT=20n
meas tran coarse_q0_val FIND v(coarse_q0) AT=20n
meas tran coarse_q1_val FIND v(coarse_q1) AT=20n
meas tran coarse_q2_val FIND v(coarse_q2) AT=20n
meas tran coarse_q3_val FIND v(coarse_q3) AT=20n
meas tran coarse_q4_val FIND v(coarse_q4) AT=20n
meas tran coarse_q5_val FIND v(coarse_q5) AT=20n
meas tran coarse_q6_val FIND v(coarse_q6) AT=20n
meas tran coarse_q7_val FIND v(coarse_q7) AT=20n
meas tran coarse_q8_val FIND v(coarse_q8) AT=20n
meas tran coarse_q9_val FIND v(coarse_q9) AT=20n
meas tran coarse_q10_val FIND v(coarse_q10) AT=20n
meas tran coarse_q11_val FIND v(coarse_q11) AT=20n
meas tran coarse_q12_val FIND v(coarse_q12) AT=20n
meas tran coarse_q13_val FIND v(coarse_q13) AT=20n
meas tran coarse_q14_val FIND v(coarse_q14) AT=20n
meas tran coarse_q15_val FIND v(coarse_q15) AT=20n
meas tran xcoarse_q0_val FIND v(xcoarse_q0) AT=20n
meas tran xcoarse_q1_val FIND v(xcoarse_q1) AT=20n
meas tran xcoarse_q2_val FIND v(xcoarse_q2) AT=20n
meas tran xcoarse_q3_val FIND v(xcoarse_q3) AT=20n
meas tran xcoarse_q4_val FIND v(xcoarse_q4) AT=20n
meas tran xcoarse_q5_val FIND v(xcoarse_q5) AT=20n
meas tran xcoarse_q6_val FIND v(xcoarse_q6) AT=20n
meas tran xcoarse_q7_val FIND v(xcoarse_q7) AT=20n
meas tran xcoarse_q8_val FIND v(xcoarse_q8) AT=20n
meas tran xcoarse_q9_val FIND v(xcoarse_q9) AT=20n
meas tran xcoarse_q10_val FIND v(xcoarse_q10) AT=20n
meas tran xcoarse_q11_val FIND v(xcoarse_q11) AT=20n
meas tran xcoarse_q12_val FIND v(xcoarse_q12) AT=20n
meas tran xcoarse_q13_val FIND v(xcoarse_q13) AT=20n
meas tran xcoarse_q14_val FIND v(xcoarse_q14) AT=20n
meas tran xcoarse_q15_val FIND v(xcoarse_q15) AT=20n
echo "RESULT fine_q0=$fine_q0_val fine_q1=$fine_q1_val fine_q2=$fine_q2_val fine_q3=$fine_q3_val fine_q4=$fine_q4_val fine_q5=$fine_q5_val fine_q6=$fine_q6_val fine_q7=$fine_q7_val fine_q8=$fine_q8_val fine_q9=$fine_q9_val fine_q10=$fine_q10_val fine_q11=$fine_q11_val fine_q12=$fine_q12_val fine_q13=$fine_q13_val fine_q14=$fine_q14_val fine_q15=$fine_q15_val coarse_q0=$coarse_q0_val coarse_q1=$coarse_q1_val coarse_q2=$coarse_q2_val coarse_q3=$coarse_q3_val coarse_q4=$coarse_q4_val coarse_q5=$coarse_q5_val coarse_q6=$coarse_q6_val coarse_q7=$coarse_q7_val coarse_q8=$coarse_q8_val coarse_q9=$coarse_q9_val coarse_q10=$coarse_q10_val coarse_q11=$coarse_q11_val coarse_q12=$coarse_q12_val coarse_q13=$coarse_q13_val coarse_q14=$coarse_q14_val coarse_q15=$coarse_q15_val xcoarse_q0=$xcoarse_q0_val xcoarse_q1=$xcoarse_q1_val xcoarse_q2=$xcoarse_q2_val xcoarse_q3=$xcoarse_q3_val xcoarse_q4=$xcoarse_q4_val xcoarse_q5=$xcoarse_q5_val xcoarse_q6=$xcoarse_q6_val xcoarse_q7=$xcoarse_q7_val xcoarse_q8=$xcoarse_q8_val xcoarse_q9=$xcoarse_q9_val xcoarse_q10=$xcoarse_q10_val xcoarse_q11=$xcoarse_q11_val xcoarse_q12=$xcoarse_q12_val xcoarse_q13=$xcoarse_q13_val xcoarse_q14=$xcoarse_q14_val xcoarse_q15=$xcoarse_q15_val"
.endc
.end