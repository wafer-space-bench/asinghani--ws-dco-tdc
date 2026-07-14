* COARSE delay-line TDC: delta_t=9500ps, 1x dlyd_4/tap
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
Vstop STOP_IN 0 PULSE(0 5 19.5n 0.1n 0.1n 500n 1000n)

Xs_0_0 START_IN coarse_tap_s0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_1_0 coarse_tap_s0 coarse_tap_s1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_2_0 coarse_tap_s1 coarse_tap_s2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_3_0 coarse_tap_s2 coarse_tap_s3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_4_0 coarse_tap_s3 coarse_tap_s4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_5_0 coarse_tap_s4 coarse_tap_s5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_6_0 coarse_tap_s5 coarse_tap_s6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_7_0 coarse_tap_s6 coarse_tap_s7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_8_0 coarse_tap_s7 coarse_tap_s8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_9_0 coarse_tap_s8 coarse_tap_s9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_10_0 coarse_tap_s9 coarse_tap_s10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_11_0 coarse_tap_s10 coarse_tap_s11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_12_0 coarse_tap_s11 coarse_tap_s12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_13_0 coarse_tap_s12 coarse_tap_s13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_14_0 coarse_tap_s13 coarse_tap_s14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs_15_0 coarse_tap_s14 coarse_tap_s15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4

Xdff_0 STOP_IN RN coarse_tap_s0 coarse_q0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_1 STOP_IN RN coarse_tap_s1 coarse_q1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_2 STOP_IN RN coarse_tap_s2 coarse_q2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_3 STOP_IN RN coarse_tap_s3 coarse_q3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_4 STOP_IN RN coarse_tap_s4 coarse_q4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_5 STOP_IN RN coarse_tap_s5 coarse_q5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_6 STOP_IN RN coarse_tap_s6 coarse_q6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_7 STOP_IN RN coarse_tap_s7 coarse_q7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_8 STOP_IN RN coarse_tap_s8 coarse_q8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_9 STOP_IN RN coarse_tap_s9 coarse_q9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_10 STOP_IN RN coarse_tap_s10 coarse_q10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_11 STOP_IN RN coarse_tap_s11 coarse_q11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_12 STOP_IN RN coarse_tap_s12 coarse_q12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_13 STOP_IN RN coarse_tap_s13 coarse_q13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_14 STOP_IN RN coarse_tap_s14 coarse_q14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_15 STOP_IN RN coarse_tap_s15 coarse_q15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1

.ic v(START_IN)=0 v(STOP_IN)=0 v(RN)=0
.options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25
.control
tran 0.1ns 35ns uic
meas tran coarse_q0_val FIND v(coarse_q0) AT=32n
meas tran coarse_q1_val FIND v(coarse_q1) AT=32n
meas tran coarse_q2_val FIND v(coarse_q2) AT=32n
meas tran coarse_q3_val FIND v(coarse_q3) AT=32n
meas tran coarse_q4_val FIND v(coarse_q4) AT=32n
meas tran coarse_q5_val FIND v(coarse_q5) AT=32n
meas tran coarse_q6_val FIND v(coarse_q6) AT=32n
meas tran coarse_q7_val FIND v(coarse_q7) AT=32n
meas tran coarse_q8_val FIND v(coarse_q8) AT=32n
meas tran coarse_q9_val FIND v(coarse_q9) AT=32n
meas tran coarse_q10_val FIND v(coarse_q10) AT=32n
meas tran coarse_q11_val FIND v(coarse_q11) AT=32n
meas tran coarse_q12_val FIND v(coarse_q12) AT=32n
meas tran coarse_q13_val FIND v(coarse_q13) AT=32n
meas tran coarse_q14_val FIND v(coarse_q14) AT=32n
meas tran coarse_q15_val FIND v(coarse_q15) AT=32n
echo "RESULT coarse_q0=$&coarse_q0_val coarse_q1=$&coarse_q1_val coarse_q2=$&coarse_q2_val coarse_q3=$&coarse_q3_val coarse_q4=$&coarse_q4_val coarse_q5=$&coarse_q5_val coarse_q6=$&coarse_q6_val coarse_q7=$&coarse_q7_val coarse_q8=$&coarse_q8_val coarse_q9=$&coarse_q9_val coarse_q10=$&coarse_q10_val coarse_q11=$&coarse_q11_val coarse_q12=$&coarse_q12_val coarse_q13=$&coarse_q13_val coarse_q14=$&coarse_q14_val coarse_q15=$&coarse_q15_val"
.endc
.end