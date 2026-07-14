* Delay measurement: gf180mcu_fd_sc_mcu7t5v0__dlyc_2
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
Vin in 0 PULSE(0 5 5n 0.1n 0.1n 10n 20n)
Xdut in out VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyc_2
.options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25
.control
tran 0.01ns 20ns uic
meas tran t_delay TRIG v(in) VAL=2.5 RISE=1 TARG v(out) VAL=2.5 RISE=1
echo "RESULT $&t_delay"
.endc
.end