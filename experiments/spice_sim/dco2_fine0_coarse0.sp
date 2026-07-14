* Integrated prototype DCO core sweep: dco2_fine0_coarse0
.param fnoicor=0
.param sw_stat_global=0
.param sw_stat_mismatch=0
.param mc_skew=3
.param res_mc_skew=3
.param cap_mc_skew=3
.include /home/anish/wafer_space_docker_based_starter_kit/pdk/gf180mcuD/libs.tech/ngspice/design.ngspice
.include /home/anish/wafer_space_docker_based_starter_kit/spice_sim/sm141064_typical.spice
.include /home/anish/wafer_space_docker_based_starter_kit/spice_sim/smbb000149_typical.spice
.include /home/anish/wafer_space_docker_based_starter_kit/pdk/gf180mcuD/libs.ref/gf180mcu_fd_sc_mcu7t5v0/spice/gf180mcu_fd_sc_mcu7t5v0.spice
VDD_net VDD 0 5.0
VSS_net VSS 0 0
Ven enable 0 5.0
Vfine0 fine0 0 0
Vfine1 fine1 0 0
Vfine2 fine2 0 0
Vfine3 fine3 0 0
Vcoarse0 coarse0 0 0
Vcoarse1 coarse1 0 0
Vcoarse2 coarse2 0 0
Vcoarse3 coarse3 0 0

Xnand enable out ring0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__nand2_1
Xs0_fixed_delay ring0 s0_d0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs0_extra_delay s0_d0 s0_d1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs0_mux s0_d0 s0_d1 coarse0 s0_in VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__mux2_1
Xs0_base VDD s0_in ring1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_drv1 fine0 s0_in ring1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_drv2 fine1 s0_in ring1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_2
Xs0_drv4 fine2 s0_in ring1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_4
Xs0_drv8 fine3 s0_in ring1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_8
Xs1d ring1 s1_delay VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs1i s1_delay ring2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs2_fixed_delay ring2 s2_d0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs2_extra_delay s2_d0 s2_d1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs2_mux s2_d0 s2_d1 coarse1 s2_in VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__mux2_1
Xs2_base VDD s2_in ring3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_drv1 fine0 s2_in ring3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_drv2 fine1 s2_in ring3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_2
Xs2_drv4 fine2 s2_in ring3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_4
Xs2_drv8 fine3 s2_in ring3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_8
Xs3d ring3 s3_delay VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs3i s3_delay ring4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs4_fixed_delay ring4 s4_d0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs4_extra_delay s4_d0 s4_d1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs4_mux s4_d0 s4_d1 coarse2 s4_in VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__mux2_1
Xs4_base VDD s4_in ring5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs4_drv1 fine0 s4_in ring5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs4_drv2 fine1 s4_in ring5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_2
Xs4_drv4 fine2 s4_in ring5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_4
Xs4_drv8 fine3 s4_in ring5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_8
Xs5d ring5 s5_delay VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs5i s5_delay ring6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs6_fixed_delay ring6 s6_d0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs6_extra_delay s6_d0 s6_d1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs6_mux s6_d0 s6_d1 coarse3 s6_in VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__mux2_1
Xs6_base VDD s6_in ring7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs6_drv1 fine0 s6_in ring7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs6_drv2 fine1 s6_in ring7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_2
Xs6_drv4 fine2 s6_in ring7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_4
Xs6_drv8 fine3 s6_in ring7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_8
Xs7d ring7 s7_delay VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs7i s7_delay out VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
.ic v(out)=0
.options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25
.control
tran 0.1n 1u uic
meas tran t_period trig v(out) val=2.5 rise=5 targ v(out) val=2.5 rise=6
let f_mhz = 1.0 / t_period / 1e6
echo "RESULT $&f_mhz"
.endc
.end
