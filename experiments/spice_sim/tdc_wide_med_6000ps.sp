* MED delay-line TDC: delta_t=6000ps, 20 inv/tap, 16 taps
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
Vstop STOP_IN 0 PULSE(0 5 16.0n 0.1n 0.1n 500n 1000n)

Xs_0_0 START_IN med_s0_0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_0_1 med_s0_0 med_s0_1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_0_2 med_s0_1 med_s0_2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_0_3 med_s0_2 med_s0_3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_0_4 med_s0_3 med_s0_4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_0_5 med_s0_4 med_s0_5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_0_6 med_s0_5 med_s0_6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_0_7 med_s0_6 med_s0_7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_0_8 med_s0_7 med_s0_8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_0_9 med_s0_8 med_s0_9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_0_10 med_s0_9 med_s0_10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_0_11 med_s0_10 med_s0_11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_0_12 med_s0_11 med_s0_12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_0_13 med_s0_12 med_s0_13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_0_14 med_s0_13 med_s0_14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_0_15 med_s0_14 med_s0_15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_0_16 med_s0_15 med_s0_16 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_0_17 med_s0_16 med_s0_17 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_0_18 med_s0_17 med_s0_18 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_0_19 med_s0_18 med_tap_s0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_0 med_tap_s0 med_s1_0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_1 med_s1_0 med_s1_1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_2 med_s1_1 med_s1_2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_3 med_s1_2 med_s1_3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_4 med_s1_3 med_s1_4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_5 med_s1_4 med_s1_5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_6 med_s1_5 med_s1_6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_7 med_s1_6 med_s1_7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_8 med_s1_7 med_s1_8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_9 med_s1_8 med_s1_9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_10 med_s1_9 med_s1_10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_11 med_s1_10 med_s1_11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_12 med_s1_11 med_s1_12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_13 med_s1_12 med_s1_13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_14 med_s1_13 med_s1_14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_15 med_s1_14 med_s1_15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_16 med_s1_15 med_s1_16 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_17 med_s1_16 med_s1_17 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_18 med_s1_17 med_s1_18 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_1_19 med_s1_18 med_tap_s1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_0 med_tap_s1 med_s2_0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_1 med_s2_0 med_s2_1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_2 med_s2_1 med_s2_2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_3 med_s2_2 med_s2_3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_4 med_s2_3 med_s2_4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_5 med_s2_4 med_s2_5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_6 med_s2_5 med_s2_6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_7 med_s2_6 med_s2_7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_8 med_s2_7 med_s2_8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_9 med_s2_8 med_s2_9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_10 med_s2_9 med_s2_10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_11 med_s2_10 med_s2_11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_12 med_s2_11 med_s2_12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_13 med_s2_12 med_s2_13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_14 med_s2_13 med_s2_14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_15 med_s2_14 med_s2_15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_16 med_s2_15 med_s2_16 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_17 med_s2_16 med_s2_17 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_18 med_s2_17 med_s2_18 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_2_19 med_s2_18 med_tap_s2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_0 med_tap_s2 med_s3_0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_1 med_s3_0 med_s3_1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_2 med_s3_1 med_s3_2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_3 med_s3_2 med_s3_3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_4 med_s3_3 med_s3_4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_5 med_s3_4 med_s3_5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_6 med_s3_5 med_s3_6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_7 med_s3_6 med_s3_7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_8 med_s3_7 med_s3_8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_9 med_s3_8 med_s3_9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_10 med_s3_9 med_s3_10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_11 med_s3_10 med_s3_11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_12 med_s3_11 med_s3_12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_13 med_s3_12 med_s3_13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_14 med_s3_13 med_s3_14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_15 med_s3_14 med_s3_15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_16 med_s3_15 med_s3_16 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_17 med_s3_16 med_s3_17 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_18 med_s3_17 med_s3_18 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_3_19 med_s3_18 med_tap_s3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_0 med_tap_s3 med_s4_0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_1 med_s4_0 med_s4_1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_2 med_s4_1 med_s4_2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_3 med_s4_2 med_s4_3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_4 med_s4_3 med_s4_4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_5 med_s4_4 med_s4_5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_6 med_s4_5 med_s4_6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_7 med_s4_6 med_s4_7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_8 med_s4_7 med_s4_8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_9 med_s4_8 med_s4_9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_10 med_s4_9 med_s4_10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_11 med_s4_10 med_s4_11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_12 med_s4_11 med_s4_12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_13 med_s4_12 med_s4_13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_14 med_s4_13 med_s4_14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_15 med_s4_14 med_s4_15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_16 med_s4_15 med_s4_16 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_17 med_s4_16 med_s4_17 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_18 med_s4_17 med_s4_18 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_4_19 med_s4_18 med_tap_s4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_0 med_tap_s4 med_s5_0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_1 med_s5_0 med_s5_1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_2 med_s5_1 med_s5_2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_3 med_s5_2 med_s5_3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_4 med_s5_3 med_s5_4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_5 med_s5_4 med_s5_5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_6 med_s5_5 med_s5_6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_7 med_s5_6 med_s5_7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_8 med_s5_7 med_s5_8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_9 med_s5_8 med_s5_9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_10 med_s5_9 med_s5_10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_11 med_s5_10 med_s5_11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_12 med_s5_11 med_s5_12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_13 med_s5_12 med_s5_13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_14 med_s5_13 med_s5_14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_15 med_s5_14 med_s5_15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_16 med_s5_15 med_s5_16 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_17 med_s5_16 med_s5_17 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_18 med_s5_17 med_s5_18 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_5_19 med_s5_18 med_tap_s5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_0 med_tap_s5 med_s6_0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_1 med_s6_0 med_s6_1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_2 med_s6_1 med_s6_2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_3 med_s6_2 med_s6_3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_4 med_s6_3 med_s6_4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_5 med_s6_4 med_s6_5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_6 med_s6_5 med_s6_6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_7 med_s6_6 med_s6_7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_8 med_s6_7 med_s6_8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_9 med_s6_8 med_s6_9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_10 med_s6_9 med_s6_10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_11 med_s6_10 med_s6_11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_12 med_s6_11 med_s6_12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_13 med_s6_12 med_s6_13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_14 med_s6_13 med_s6_14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_15 med_s6_14 med_s6_15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_16 med_s6_15 med_s6_16 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_17 med_s6_16 med_s6_17 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_18 med_s6_17 med_s6_18 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_6_19 med_s6_18 med_tap_s6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_0 med_tap_s6 med_s7_0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_1 med_s7_0 med_s7_1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_2 med_s7_1 med_s7_2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_3 med_s7_2 med_s7_3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_4 med_s7_3 med_s7_4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_5 med_s7_4 med_s7_5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_6 med_s7_5 med_s7_6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_7 med_s7_6 med_s7_7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_8 med_s7_7 med_s7_8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_9 med_s7_8 med_s7_9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_10 med_s7_9 med_s7_10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_11 med_s7_10 med_s7_11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_12 med_s7_11 med_s7_12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_13 med_s7_12 med_s7_13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_14 med_s7_13 med_s7_14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_15 med_s7_14 med_s7_15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_16 med_s7_15 med_s7_16 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_17 med_s7_16 med_s7_17 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_18 med_s7_17 med_s7_18 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_7_19 med_s7_18 med_tap_s7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_0 med_tap_s7 med_s8_0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_1 med_s8_0 med_s8_1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_2 med_s8_1 med_s8_2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_3 med_s8_2 med_s8_3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_4 med_s8_3 med_s8_4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_5 med_s8_4 med_s8_5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_6 med_s8_5 med_s8_6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_7 med_s8_6 med_s8_7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_8 med_s8_7 med_s8_8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_9 med_s8_8 med_s8_9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_10 med_s8_9 med_s8_10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_11 med_s8_10 med_s8_11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_12 med_s8_11 med_s8_12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_13 med_s8_12 med_s8_13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_14 med_s8_13 med_s8_14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_15 med_s8_14 med_s8_15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_16 med_s8_15 med_s8_16 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_17 med_s8_16 med_s8_17 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_18 med_s8_17 med_s8_18 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_8_19 med_s8_18 med_tap_s8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_0 med_tap_s8 med_s9_0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_1 med_s9_0 med_s9_1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_2 med_s9_1 med_s9_2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_3 med_s9_2 med_s9_3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_4 med_s9_3 med_s9_4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_5 med_s9_4 med_s9_5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_6 med_s9_5 med_s9_6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_7 med_s9_6 med_s9_7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_8 med_s9_7 med_s9_8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_9 med_s9_8 med_s9_9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_10 med_s9_9 med_s9_10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_11 med_s9_10 med_s9_11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_12 med_s9_11 med_s9_12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_13 med_s9_12 med_s9_13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_14 med_s9_13 med_s9_14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_15 med_s9_14 med_s9_15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_16 med_s9_15 med_s9_16 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_17 med_s9_16 med_s9_17 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_18 med_s9_17 med_s9_18 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_9_19 med_s9_18 med_tap_s9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_0 med_tap_s9 med_s10_0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_1 med_s10_0 med_s10_1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_2 med_s10_1 med_s10_2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_3 med_s10_2 med_s10_3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_4 med_s10_3 med_s10_4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_5 med_s10_4 med_s10_5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_6 med_s10_5 med_s10_6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_7 med_s10_6 med_s10_7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_8 med_s10_7 med_s10_8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_9 med_s10_8 med_s10_9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_10 med_s10_9 med_s10_10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_11 med_s10_10 med_s10_11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_12 med_s10_11 med_s10_12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_13 med_s10_12 med_s10_13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_14 med_s10_13 med_s10_14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_15 med_s10_14 med_s10_15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_16 med_s10_15 med_s10_16 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_17 med_s10_16 med_s10_17 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_18 med_s10_17 med_s10_18 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_10_19 med_s10_18 med_tap_s10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_0 med_tap_s10 med_s11_0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_1 med_s11_0 med_s11_1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_2 med_s11_1 med_s11_2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_3 med_s11_2 med_s11_3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_4 med_s11_3 med_s11_4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_5 med_s11_4 med_s11_5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_6 med_s11_5 med_s11_6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_7 med_s11_6 med_s11_7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_8 med_s11_7 med_s11_8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_9 med_s11_8 med_s11_9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_10 med_s11_9 med_s11_10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_11 med_s11_10 med_s11_11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_12 med_s11_11 med_s11_12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_13 med_s11_12 med_s11_13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_14 med_s11_13 med_s11_14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_15 med_s11_14 med_s11_15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_16 med_s11_15 med_s11_16 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_17 med_s11_16 med_s11_17 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_18 med_s11_17 med_s11_18 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_11_19 med_s11_18 med_tap_s11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_0 med_tap_s11 med_s12_0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_1 med_s12_0 med_s12_1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_2 med_s12_1 med_s12_2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_3 med_s12_2 med_s12_3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_4 med_s12_3 med_s12_4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_5 med_s12_4 med_s12_5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_6 med_s12_5 med_s12_6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_7 med_s12_6 med_s12_7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_8 med_s12_7 med_s12_8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_9 med_s12_8 med_s12_9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_10 med_s12_9 med_s12_10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_11 med_s12_10 med_s12_11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_12 med_s12_11 med_s12_12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_13 med_s12_12 med_s12_13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_14 med_s12_13 med_s12_14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_15 med_s12_14 med_s12_15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_16 med_s12_15 med_s12_16 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_17 med_s12_16 med_s12_17 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_18 med_s12_17 med_s12_18 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_12_19 med_s12_18 med_tap_s12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_0 med_tap_s12 med_s13_0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_1 med_s13_0 med_s13_1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_2 med_s13_1 med_s13_2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_3 med_s13_2 med_s13_3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_4 med_s13_3 med_s13_4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_5 med_s13_4 med_s13_5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_6 med_s13_5 med_s13_6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_7 med_s13_6 med_s13_7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_8 med_s13_7 med_s13_8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_9 med_s13_8 med_s13_9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_10 med_s13_9 med_s13_10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_11 med_s13_10 med_s13_11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_12 med_s13_11 med_s13_12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_13 med_s13_12 med_s13_13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_14 med_s13_13 med_s13_14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_15 med_s13_14 med_s13_15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_16 med_s13_15 med_s13_16 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_17 med_s13_16 med_s13_17 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_18 med_s13_17 med_s13_18 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_13_19 med_s13_18 med_tap_s13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_0 med_tap_s13 med_s14_0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_1 med_s14_0 med_s14_1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_2 med_s14_1 med_s14_2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_3 med_s14_2 med_s14_3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_4 med_s14_3 med_s14_4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_5 med_s14_4 med_s14_5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_6 med_s14_5 med_s14_6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_7 med_s14_6 med_s14_7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_8 med_s14_7 med_s14_8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_9 med_s14_8 med_s14_9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_10 med_s14_9 med_s14_10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_11 med_s14_10 med_s14_11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_12 med_s14_11 med_s14_12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_13 med_s14_12 med_s14_13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_14 med_s14_13 med_s14_14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_15 med_s14_14 med_s14_15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_16 med_s14_15 med_s14_16 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_17 med_s14_16 med_s14_17 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_18 med_s14_17 med_s14_18 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_14_19 med_s14_18 med_tap_s14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_0 med_tap_s14 med_s15_0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_1 med_s15_0 med_s15_1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_2 med_s15_1 med_s15_2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_3 med_s15_2 med_s15_3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_4 med_s15_3 med_s15_4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_5 med_s15_4 med_s15_5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_6 med_s15_5 med_s15_6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_7 med_s15_6 med_s15_7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_8 med_s15_7 med_s15_8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_9 med_s15_8 med_s15_9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_10 med_s15_9 med_s15_10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_11 med_s15_10 med_s15_11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_12 med_s15_11 med_s15_12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_13 med_s15_12 med_s15_13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_14 med_s15_13 med_s15_14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_15 med_s15_14 med_s15_15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_16 med_s15_15 med_s15_16 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_17 med_s15_16 med_s15_17 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_18 med_s15_17 med_s15_18 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs_15_19 med_s15_18 med_tap_s15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1

Xdff_0 STOP_IN RN med_tap_s0 med_q0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_1 STOP_IN RN med_tap_s1 med_q1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_2 STOP_IN RN med_tap_s2 med_q2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_3 STOP_IN RN med_tap_s3 med_q3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_4 STOP_IN RN med_tap_s4 med_q4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_5 STOP_IN RN med_tap_s5 med_q5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_6 STOP_IN RN med_tap_s6 med_q6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_7 STOP_IN RN med_tap_s7 med_q7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_8 STOP_IN RN med_tap_s8 med_q8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_9 STOP_IN RN med_tap_s9 med_q9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_10 STOP_IN RN med_tap_s10 med_q10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_11 STOP_IN RN med_tap_s11 med_q11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_12 STOP_IN RN med_tap_s12 med_q12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_13 STOP_IN RN med_tap_s13 med_q13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_14 STOP_IN RN med_tap_s14 med_q14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1
Xdff_15 STOP_IN RN med_tap_s15 med_q15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1

.ic v(START_IN)=0 v(STOP_IN)=0 v(RN)=0
.options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25
.control
tran 0.1ns 38ns uic
meas tran med_q0_val FIND v(med_q0) AT=33n
meas tran med_q1_val FIND v(med_q1) AT=33n
meas tran med_q2_val FIND v(med_q2) AT=33n
meas tran med_q3_val FIND v(med_q3) AT=33n
meas tran med_q4_val FIND v(med_q4) AT=33n
meas tran med_q5_val FIND v(med_q5) AT=33n
meas tran med_q6_val FIND v(med_q6) AT=33n
meas tran med_q7_val FIND v(med_q7) AT=33n
meas tran med_q8_val FIND v(med_q8) AT=33n
meas tran med_q9_val FIND v(med_q9) AT=33n
meas tran med_q10_val FIND v(med_q10) AT=33n
meas tran med_q11_val FIND v(med_q11) AT=33n
meas tran med_q12_val FIND v(med_q12) AT=33n
meas tran med_q13_val FIND v(med_q13) AT=33n
meas tran med_q14_val FIND v(med_q14) AT=33n
meas tran med_q15_val FIND v(med_q15) AT=33n
echo "RESULT med_q0=$&med_q0_val med_q1=$&med_q1_val med_q2=$&med_q2_val med_q3=$&med_q3_val med_q4=$&med_q4_val med_q5=$&med_q5_val med_q6=$&med_q6_val med_q7=$&med_q7_val med_q8=$&med_q8_val med_q9=$&med_q9_val med_q10=$&med_q10_val med_q11=$&med_q11_val med_q12=$&med_q12_val med_q13=$&med_q13_val med_q14=$&med_q14_val med_q15=$&med_q15_val"
.endc
.end