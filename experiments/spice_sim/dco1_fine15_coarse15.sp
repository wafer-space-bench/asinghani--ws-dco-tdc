* Integrated prototype DCO core sweep: dco1_fine15_coarse15
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
Vfine0 fine0 0 5
Vfine1 fine1 0 5
Vfine2 fine2 0 5
Vfine3 fine3 0 5
Vcoarse0 coarse0 0 5
Vcoarse1 coarse1 0 5
Vcoarse2 coarse2 0 5
Vcoarse3 coarse3 0 5

Xnand enable out ring0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__nand2_1
Xs0_delay ring0 s0_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs0_mux ring0 s0_d coarse0 s0_in VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__mux2_1
Xs0_base VDD s0_in ring1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_drv1 fine0 s0_in ring1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs0_drv2 fine1 s0_in ring1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_2
Xs0_drv4 fine2 s0_in ring1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_4
Xs0_drv8 fine3 s0_in ring1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_8
Xs1 ring1 ring2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs2_delay ring2 s2_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs2_mux ring2 s2_d coarse1 s2_in VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__mux2_1
Xs2_base VDD s2_in ring3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_drv1 fine0 s2_in ring3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2_drv2 fine1 s2_in ring3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_2
Xs2_drv4 fine2 s2_in ring3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_4
Xs2_drv8 fine3 s2_in ring3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_8
Xs3 ring3 ring4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1
Xs4_delay ring4 s4_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs4_mux ring4 s4_d coarse2 s4_in VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__mux2_1
Xs4_base VDD s4_in ring5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs4_drv1 fine0 s4_in ring5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs4_drv2 fine1 s4_in ring5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_2
Xs4_drv4 fine2 s4_in ring5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_4
Xs4_drv8 fine3 s4_in ring5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_8
Xs5_delay ring5 s5_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4
Xs5_mux ring5 s5_d coarse3 s5_in VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__mux2_1
Xs5_base VDD s5_in out VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_drv1 fine0 s5_in out VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs5_drv2 fine1 s5_in out VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_2
Xs5_drv4 fine2 s5_in out VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_4
Xs5_drv8 fine3 s5_in out VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_8
.ic v(out)=0
.options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25
.control
tran 0.02n 200n uic
meas tran t_period trig v(out) val=2.5 rise=5 targ v(out) val=2.5 rise=6
let f_mhz = 1.0 / t_period / 1e6
echo "RESULT $&f_mhz"
.endc
.end
