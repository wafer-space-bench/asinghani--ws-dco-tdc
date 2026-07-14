* Core-only SPICE: just the standard-cell path (no I/O pads)
* Path: buf_8 -> clkinv_2 -> buf_8 -> buf_12 -> buf_8
* This tests the actual NOT gate + buffer chain from synthesis.
* GF180MCU, 5V, typical corner, 25C, 10pF load

* --- PDK model parameters ---
.param fnoicor=0
.param sw_stat_global=0
.param sw_stat_mismatch=0
.param mc_skew=3
.param res_mc_skew=3
.param cap_mc_skew=3

* --- PDK model files (preprocessed: .lib sections resolved for typical corner) ---
.include /home/anish/wafer_space_docker_based_starter_kit/pdk/gf180mcuD/libs.tech/ngspice/design.ngspice
.include /tmp/sm141064_typical.spice
.include /tmp/smbb000149_typical.spice

* --- Standard-cell SPICE (transistor-level) ---
.include pdk/gf180mcuD/libs.ref/gf180mcu_fd_sc_mcu7t5v0/spice/gf180mcu_fd_sc_mcu7t5v0.spice

* --- Power supply ---
VDD_net VDD 0 5.0
VSS_net VSS 0 0

* --- Input signal ---
Vin in 0 PWL(0ns 0V 40ns 0V 50ns 5V 140ns 5V 150ns 0V 200ns 0V)

* --- Buffer 1 (buf_8): I Z VDD VNW VPW VSS ---
Xbuf1 in w1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__buf_8

* --- Inverter (clkinv_2): I ZN VDD VNW VPW VSS ---
Xinv w1 w2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_2

* --- Buffer 2 (buf_8) ---
Xbuf2 w2 w3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__buf_8

* --- Buffer 3 (buf_12) ---
Xbuf3 w3 w4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__buf_12

* --- Buffer 4 (buf_8) ---
Xbuf4 w4 out VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__buf_8

* --- Load on output: 10pF ---
Cload out 0 10p

* --- Options ---
.options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25

.control
tran 0.1ns 200ns

meas tran tpd_rise trig v(in) val=2.5 rise=1 targ v(out) val=2.5 fall=1
meas tran tpd_fall trig v(in) val=2.5 fall=1 targ v(out) val=2.5 rise=1
meas tran t_rise trig v(out) val=0.5 rise=1 targ v(out) val=4.5 rise=1
meas tran t_fall trig v(out) val=4.5 fall=1 targ v(out) val=0.5 fall=1

echo ""
echo "========================================"
echo "  NOT-GATE SPICE RESULTS (core-only, GF180MCU, 5V, 25C, 10pF)"
echo "========================================"
print tpd_rise
print tpd_fall
print t_rise
print t_fall
echo "========================================"

wrdata spice_out.txt v(in) v(out) v(w1) v(w2) v(w3) v(w4)
.endc

.end
