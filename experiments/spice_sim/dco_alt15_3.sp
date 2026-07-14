* Ring 15 stages ALT, code=3 (en=4/33)
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
Ven enable 0 5.0
VEN_on EN_on 0 5.0
VEN_off EN_off 0 0

Xnand enable ring_out ring0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__nand2_1
Xs0 VDD ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_0 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_1 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_2 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_3 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_4 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_5 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_6 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_7 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_8 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_9 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_10 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_11 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_12 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_13 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_14 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_15 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_16 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_17 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_18 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_19 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_20 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_21 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_22 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_23 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_24 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_25 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_26 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_27 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_28 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_29 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_30 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_31 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_32 EN_off r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2 VDD r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_0 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_1 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_2 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_3 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_4 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_5 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_6 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_7 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_8 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_9 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_10 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_11 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_12 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_13 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_14 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_15 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_16 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_17 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_18 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_19 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_20 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_21 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_22 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_23 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_24 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_25 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_26 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_27 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_28 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_29 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_30 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_31 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_32 EN_off r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs4 VDD r4 r5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_0 EN_on r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_1 EN_on r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_2 EN_on r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_3 EN_on r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_4 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_5 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_6 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_7 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_8 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_9 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_10 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_11 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_12 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_13 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_14 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_15 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_16 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_17 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_18 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_19 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_20 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_21 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_22 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_23 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_24 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_25 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_26 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_27 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_28 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_29 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_30 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_31 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_32 EN_off r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs6 VDD r6 r7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_0 EN_on r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_1 EN_on r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_2 EN_on r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_3 EN_on r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_4 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_5 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_6 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_7 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_8 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_9 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_10 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_11 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_12 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_13 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_14 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_15 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_16 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_17 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_18 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_19 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_20 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_21 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_22 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_23 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_24 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_25 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_26 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_27 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_28 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_29 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_30 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_31 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7_32 EN_off r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs8 VDD r8 r9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs9 VDD r9 r10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs10 VDD r10 r11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs11 VDD r11 r12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs12 VDD r12 r13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs13 VDD r13 ring_out VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
.ic v(ring_out)=0V
.options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25
.control
tran 0.1ns 120ns uic
meas tran t_period trig v(ring_out) val=2.5 rise=3 targ v(ring_out) val=2.5 rise=4
let f_mhz = 1.0 / t_period / 1e6
echo "RESULT $&f_mhz"
.endc
.end