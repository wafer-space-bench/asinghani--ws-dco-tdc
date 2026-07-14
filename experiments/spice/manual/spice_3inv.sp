* 3-inverter chain with intermediate tap measurements
* GF180MCU, 5V, typical corner, 25C
* Each inverter output loaded with 10pF (scope probe) to prevent synth optimization
* but NOT loaded so heavily that the signal can't propagate.

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

* --- 3 inverters in a row (clkinv_2): I ZN VDD VNW VPW VSS ---
Xinv1 in  out1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_2
Xinv2 out1 out2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_2
Xinv3 out2 out3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_2

* --- Load each intermediate output with 10pF (prevents synth from removing,
*     simulates a scope probe, but light enough to propagate) ---
C1 out1 0 10p
C2 out2 0 10p
C3 out3 0 10p

* --- Options ---
.options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25

.control
tran 0.5ns 3us

* Measure propagation delays through each stage
meas tran tpd1_rise trig v(in) val=2.5 rise=1 targ v(out1) val=2.5 fall=1
meas tran tpd1_fall trig v(in) val=2.5 fall=1 targ v(out1) val=2.5 rise=1
meas tran tpd2_rise trig v(in) val=2.5 rise=1 targ v(out2) val=2.5 rise=1
meas tran tpd2_fall trig v(in) val=2.5 fall=1 targ v(out2) val=2.5 fall=1
meas tran tpd3_rise trig v(in) val=2.5 rise=1 targ v(out3) val=2.5 fall=1
meas tran tpd3_fall trig v(in) val=2.5 fall=1 targ v(out3) val=2.5 rise=1

echo ""
echo "============================================"
echo "  3-INVERTER CHAIN SPICE RESULTS"
echo "  GF180MCU, 5V, 25C, 10pF load per stage"
echo "============================================"
print tpd1_rise
print tpd1_fall
print tpd2_rise
print tpd2_fall
print tpd3_rise
print tpd3_fall
echo "============================================"

* Write data for plotting (all 4 signals)
wrdata spice_3inv.txt v(in) v(out1) v(out2) v(out3)

* Also write a gnuplot-compatible file
set plotname = "3-inverter chain"
.endc

.end
