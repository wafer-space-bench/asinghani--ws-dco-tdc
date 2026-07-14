* Minimal SPICE testbench: NOT-gate path through pad ring
* GF180MCU, 5V, typical corner, 25C, 10pF load

* --- PDK model parameters ---
.param fnoicor=0
.param sw_stat_global=0
.param sw_stat_mismatch=0
.param mc_skew=3
.param res_mc_skew=3
.param cap_mc_skew=3

* --- PDK model files (using .lib for proper section loading) ---
.lib /home/anish/wafer_space_docker_based_starter_kit/pdk/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /home/anish/wafer_space_docker_based_starter_kit/pdk/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.lib /home/anish/wafer_space_docker_based_starter_kit/pdk/gf180mcuD/libs.tech/ngspice/smbb000149.ngspice typical

* --- Standard-cell SPICE (transistor-level) ---
.include pdk/gf180mcuD/libs.ref/gf180mcu_fd_sc_mcu7t5v0/spice/gf180mcu_fd_sc_mcu7t5v0.spice
* --- I/O pad SPICE (transistor-level) ---
.include pdk/gf180mcuD/libs.ref/gf180mcu_fd_io/spice/gf180mcu_fd_io.spice

* --- Power supply ---
VDD_net VDD 0 5.0
VSS_net VSS 0 0
VDVDD DVDD 0 5.0
VDVSS DVSS 0 0

* --- Input signal on PAD ---
Vin input_PAD 0 PWL(0ns 0V 40ns 0V 50ns 5V 140ns 5V 150ns 0V 200ns 0V)

* --- Input pad (in_c): DVDD DVSS PAD PD PU VDD VSS Y ---
Xin_pad DVDD DVSS input_PAD 0 0 VDD VSS wire5_I gf180mcu_fd_io__in_c

* --- Buffer 1 (buf_8): I Z VDD VNW VPW VSS ---
Xwire5 wire5_I wire5_Z VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__buf_8

* --- Inverter (clkinv_2): I ZN VDD VNW VPW VSS ---
Xinv wire5_Z wire4_Z VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_2

* --- Buffer 2 (buf_8): I Z VDD VNW VPW VSS ---
Xwire3 wire4_Z wire3_Z VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__buf_8

* --- Buffer 3 (buf_12): I Z VDD VNW VPW VSS ---
Xwire2 wire3_Z wire2_Z VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__buf_12

* --- Buffer 4 (buf_8): I Z VDD VNW VPW VSS ---
Xwire1 wire2_Z wire1_Z VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__buf_8

* --- Bidir pad (bi_24t): A CS DVDD DVSS IE OE PAD PD PU SL VDD VSS Y ---
Xbidir_pad wire1_Z 0 DVDD DVSS 0 1 output_PAD 0 0 0 VDD VSS 0 gf180mcu_fd_io__bi_24t

* --- Load on output: 10pF ---
Cload output_PAD 0 10p

* --- Options ---
.options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25 gmin=1e-12 rshunt=1e12

.control
tran 0.1ns 200ns uic

meas tran tpd_rise trig v(input_PAD) val=2.5 rise=1 targ v(output_PAD) val=2.5 fall=1
meas tran tpd_fall trig v(input_PAD) val=2.5 fall=1 targ v(output_PAD) val=2.5 rise=1
meas tran t_rise trig v(output_PAD) val=0.5 rise=1 targ v(output_PAD) val=4.5 rise=1
meas tran t_fall trig v(output_PAD) val=4.5 fall=1 targ v(output_PAD) val=0.5 fall=1

echo ""
echo "========================================"
echo "  NOT-GATE SPICE RESULTS (GF180MCU, 5V, 25C, 10pF load)"
echo "========================================"
print tpd_rise
print tpd_fall
print t_rise
print t_fall
echo "========================================"

wrdata spice_out.txt v(input_PAD) v(output_PAD) v(wire5_Z) v(wire4_Z) v(wire3_Z) v(wire2_Z) v(wire1_Z)
.endc

.end
