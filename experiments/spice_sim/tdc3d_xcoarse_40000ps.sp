* XCOARSE delay-line TDC: delta_t=40000ps, 4x dlyd_4/tap
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
Vstop STOP_IN 0 PULSE(0 5 50.0n 0.1n 0.1n 500n 1000n)

Xs_0_0 START_IN xcoarse_s0_0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_0_1 xcoarse_s0_0 xcoarse_s0_1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_0_2 xcoarse_s0_1 xcoarse_s0_2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_0_3 xcoarse_s0_2 xcoarse_tap_s0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_1_0 xcoarse_tap_s0 xcoarse_s1_0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_1_1 xcoarse_s1_0 xcoarse_s1_1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_1_2 xcoarse_s1_1 xcoarse_s1_2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_1_3 xcoarse_s1_2 xcoarse_tap_s1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_2_0 xcoarse_tap_s1 xcoarse_s2_0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_2_1 xcoarse_s2_0 xcoarse_s2_1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_2_2 xcoarse_s2_1 xcoarse_s2_2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_2_3 xcoarse_s2_2 xcoarse_tap_s2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_3_0 xcoarse_tap_s2 xcoarse_s3_0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_3_1 xcoarse_s3_0 xcoarse_s3_1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_3_2 xcoarse_s3_1 xcoarse_s3_2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_3_3 xcoarse_s3_2 xcoarse_tap_s3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_4_0 xcoarse_tap_s3 xcoarse_s4_0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_4_1 xcoarse_s4_0 xcoarse_s4_1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_4_2 xcoarse_s4_1 xcoarse_s4_2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_4_3 xcoarse_s4_2 xcoarse_tap_s4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_5_0 xcoarse_tap_s4 xcoarse_s5_0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_5_1 xcoarse_s5_0 xcoarse_s5_1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_5_2 xcoarse_s5_1 xcoarse_s5_2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_5_3 xcoarse_s5_2 xcoarse_tap_s5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_6_0 xcoarse_tap_s5 xcoarse_s6_0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_6_1 xcoarse_s6_0 xcoarse_s6_1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_6_2 xcoarse_s6_1 xcoarse_s6_2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_6_3 xcoarse_s6_2 xcoarse_tap_s6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_7_0 xcoarse_tap_s6 xcoarse_s7_0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_7_1 xcoarse_s7_0 xcoarse_s7_1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_7_2 xcoarse_s7_1 xcoarse_s7_2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_7_3 xcoarse_s7_2 xcoarse_tap_s7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4

Xdff_0 STOP_IN RN xcoarse_tap_s0 xcoarse_q0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_1 STOP_IN RN xcoarse_tap_s1 xcoarse_q1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_2 STOP_IN RN xcoarse_tap_s2 xcoarse_q2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_3 STOP_IN RN xcoarse_tap_s3 xcoarse_q3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_4 STOP_IN RN xcoarse_tap_s4 xcoarse_q4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_5 STOP_IN RN xcoarse_tap_s5 xcoarse_q5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_6 STOP_IN RN xcoarse_tap_s6 xcoarse_q6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_7 STOP_IN RN xcoarse_tap_s7 xcoarse_q7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1

.ic v(START_IN)=0 v(STOP_IN)=0 v(RN)=0
.options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25
.control
tran 0.1ns 54ns uic
meas tran xcoarse_q0_val FIND v(xcoarse_q0) AT=51n
meas tran xcoarse_q1_val FIND v(xcoarse_q1) AT=51n
meas tran xcoarse_q2_val FIND v(xcoarse_q2) AT=51n
meas tran xcoarse_q3_val FIND v(xcoarse_q3) AT=51n
meas tran xcoarse_q4_val FIND v(xcoarse_q4) AT=51n
meas tran xcoarse_q5_val FIND v(xcoarse_q5) AT=51n
meas tran xcoarse_q6_val FIND v(xcoarse_q6) AT=51n
meas tran xcoarse_q7_val FIND v(xcoarse_q7) AT=51n
echo "RESULT xcoarse_q0=$&xcoarse_q0_val xcoarse_q1=$&xcoarse_q1_val xcoarse_q2=$&xcoarse_q2_val xcoarse_q3=$&xcoarse_q3_val xcoarse_q4=$&xcoarse_q4_val xcoarse_q5=$&xcoarse_q5_val xcoarse_q6=$&xcoarse_q6_val xcoarse_q7=$&xcoarse_q7_val"
.endc
.end