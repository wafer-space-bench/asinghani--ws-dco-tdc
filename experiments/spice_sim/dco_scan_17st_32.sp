* Ring 17 stages, code=32 (en=33/33), 4 tunable
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
Xs0_0 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_1 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_2 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_3 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_4 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_5 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_6 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_7 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_8 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_9 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_10 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_11 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_12 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_13 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_14 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_15 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_16 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_17 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_18 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_19 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_20 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_21 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_22 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_23 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_24 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_25 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_26 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_27 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_28 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_29 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_30 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_31 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_32 EN_on ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_0 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_1 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_2 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_3 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_4 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_5 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_6 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_7 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_8 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_9 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_10 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_11 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_12 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_13 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_14 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_15 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_16 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_17 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_18 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_19 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_20 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_21 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_22 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_23 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_24 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_25 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_26 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_27 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_28 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_29 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_30 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_31 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs1_32 EN_on r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_0 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_1 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_2 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_3 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_4 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_5 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_6 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_7 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_8 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_9 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_10 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_11 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_12 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_13 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_14 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_15 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_16 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_17 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_18 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_19 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_20 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_21 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_22 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_23 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_24 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_25 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_26 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_27 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_28 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_29 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_30 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_31 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_32 EN_on r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_0 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_1 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_2 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_3 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_4 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_5 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_6 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_7 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_8 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_9 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_10 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_11 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_12 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_13 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_14 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_15 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_16 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_17 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_18 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_19 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_20 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_21 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_22 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_23 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_24 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_25 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_26 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_27 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_28 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_29 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_30 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_31 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs3_32 EN_on r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs4 VDD r4 r5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5 VDD r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs6 VDD r6 r7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs7 VDD r7 r8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs8 VDD r8 r9 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs9 VDD r9 r10 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs10 VDD r10 r11 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs11 VDD r11 r12 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs12 VDD r12 r13 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs13 VDD r13 r14 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs14 VDD r14 r15 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs15 VDD r15 ring_out VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
.ic v(ring_out)=0V
.options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25
.control
tran 0.5ns 200ns uic
meas tran t_period trig v(ring_out) val=2.5 rise=3 targ v(ring_out) val=2.5 rise=4
let f_mhz = 1.0 / t_period / 1e6
echo "RESULT $&f_mhz"
.endc
.end