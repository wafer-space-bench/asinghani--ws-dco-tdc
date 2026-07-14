* 3-inverter chain extracted from hardened chip_top
* Path: input -> buf_12 -> clkinv_1(inv1) -> clkinv_1(inv2) -> clkinv_2(inv3) -> buf_12 -> buf_8 -> output
* GF180MCU, 5V, typical corner, 25C
*
* The 3 inverters are what we want to measure. The buffers (buf_12, buf_8)
* are from synthesis/post-routing drive-strength sizing — they drive the
* inverter chain from the input pad and to the output pad.

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

* --- Input signal: square wave at 1 MHz ---
Vin in 0 PULSE(0 5 0ns 5ns 5ns 500ns 1000ns)

* --- Pre-inverter buffer (buf_12): matches the extracted netlist's drive chain ---
Xbuf_in in w_inv1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__buf_12

* --- Inverter 1 (clkinv_1): I ZN VDD VNW VPW VSS ---
Xinv1 w_inv1 w_inv2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1

* --- Inverter 2 (clkinv_1) ---
Xinv2 w_inv2 w_inv3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1

* --- Inverter 3 (clkinv_2 — bigger drive strength) ---
Xinv3 w_inv3 w_post VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_2

* --- Post-inverter buffer chain (buf_12 -> buf_8) ---
Xbuf_mid w_post w_mid VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__buf_12
Xbuf_out w_mid out VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__buf_8

* --- Load on output: 10pF (scope probe) ---
Cload out 0 10p

* --- Options ---
.options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25

.control
tran 0.5ns 3us

* Measure per-stage delay through each inverter
meas tran tpd_inv1_rise trig v(in) val=2.5 rise=1 targ v(w_inv2) val=2.5 fall=1
meas tran tpd_inv1_fall trig v(in) val=2.5 fall=1 targ v(w_inv2) val=2.5 rise=1
meas tran tpd_inv2_rise trig v(in) val=2.5 rise=1 targ v(w_inv3) val=2.5 rise=1
meas tran tpd_inv2_fall trig v(in) val=2.5 fall=1 targ v(w_inv3) val=2.5 fall=1
meas tran tpd_inv3_rise trig v(in) val=2.5 rise=1 targ v(w_post) val=2.5 fall=1
meas tran tpd_inv3_fall trig v(in) val=2.5 fall=1 targ v(w_post) val=2.5 rise=1
meas tran tpd_total_rise trig v(in) val=2.5 rise=1 targ v(out) val=2.5 fall=1
meas tran tpd_total_fall trig v(in) val=2.5 fall=1 targ v(out) val=2.5 rise=1

echo ""
echo "============================================"
echo "  3-INVERTER CHAIN (extracted from hardened chip)"
echo "  GF180MCU, 5V, 25C, 10pF output load"
echo "============================================"
print tpd_inv1_rise
print tpd_inv1_fall
print tpd_inv2_rise
print tpd_inv2_fall
print tpd_inv3_rise
print tpd_inv3_fall
print tpd_total_rise
print tpd_total_fall
echo "============================================"

wrdata spice_3inv_hardened.txt v(in) v(w_inv1) v(w_inv2) v(w_inv3) v(w_post) v(out)
.endc

.end
