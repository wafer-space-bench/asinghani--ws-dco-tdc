* FINE Vernier TDC: delta_t=200ps
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
Vrn RN 0 PULSE(0 5 5n 0.1n 0.1n 500n 1000n)
Vstart START_IN 0 PULSE(0 5 10n 0.1n 0.1n 500n 1000n)
Vstop STOP_IN 0 PULSE(0 5 10.2n 0.1n 0.1n 500n 1000n)

Xs_0a START_IN fine_s0m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_0b fine_s0m fine_start_s0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1a fine_start_s0 fine_s1m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1b fine_s1m fine_start_s1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2a fine_start_s1 fine_s2m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2b fine_s2m fine_start_s2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3a fine_start_s2 fine_s3m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3b fine_s3m fine_start_s3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4a fine_start_s3 fine_s4m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4b fine_s4m fine_start_s4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5a fine_start_s4 fine_s5m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5b fine_s5m fine_start_s5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6a fine_start_s5 fine_s6m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6b fine_s6m fine_start_s6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7a fine_start_s6 fine_s7m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7b fine_s7m fine_start_s7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8a fine_start_s7 fine_s8m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8b fine_s8m fine_start_s8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9a fine_start_s8 fine_s9m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9b fine_s9m fine_start_s9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10a fine_start_s9 fine_s10m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10b fine_s10m fine_start_s10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11a fine_start_s10 fine_s11m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11b fine_s11m fine_start_s11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12a fine_start_s11 fine_s12m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12b fine_s12m fine_start_s12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13a fine_start_s12 fine_s13m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13b fine_s13m fine_start_s13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14a fine_start_s13 fine_s14m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14b fine_s14m fine_start_s14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15a fine_start_s14 fine_s15m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15b fine_s15m fine_start_s15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xp_0a STOP_IN fine_p0m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_0b fine_p0m fine_stop_s0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_1a fine_stop_s0 fine_p1m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_1b fine_p1m fine_stop_s1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_2a fine_stop_s1 fine_p2m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_2b fine_p2m fine_stop_s2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_3a fine_stop_s2 fine_p3m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_3b fine_p3m fine_stop_s3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_4a fine_stop_s3 fine_p4m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_4b fine_p4m fine_stop_s4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_5a fine_stop_s4 fine_p5m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_5b fine_p5m fine_stop_s5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_6a fine_stop_s5 fine_p6m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_6b fine_p6m fine_stop_s6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_7a fine_stop_s6 fine_p7m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_7b fine_p7m fine_stop_s7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_8a fine_stop_s7 fine_p8m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_8b fine_p8m fine_stop_s8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_9a fine_stop_s8 fine_p9m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_9b fine_p9m fine_stop_s9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_10a fine_stop_s9 fine_p10m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_10b fine_p10m fine_stop_s10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_11a fine_stop_s10 fine_p11m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_11b fine_p11m fine_stop_s11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_12a fine_stop_s11 fine_p12m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_12b fine_p12m fine_stop_s12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_13a fine_stop_s12 fine_p13m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_13b fine_p13m fine_stop_s13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_14a fine_stop_s13 fine_p14m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_14b fine_p14m fine_stop_s14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_15a fine_stop_s14 fine_p15m VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
Xp_15b fine_p15m fine_stop_s15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4
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
tran 0.01ns 20ns uic
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