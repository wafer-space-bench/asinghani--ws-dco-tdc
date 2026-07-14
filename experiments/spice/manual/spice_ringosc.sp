* 9-stage ring oscillator with NAND enable
* Extracted from hardened chip_top.
*
* Ring loop: NAND(nand2_1) -> inv2(clkinv_1) -> ... -> inv8(clkinv_1) -> inv9(clkinv_2) -> back to NAND
* Enable: NAND input B (driven high = oscillate, low = stop)
* Output: tap at inv9 output (= NAND input A = ring feedback)
*
* GF180MCU, 5V, typical corner, 25C

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

* --- Enable signal: start low (stopped), go high at 50ns to start oscillation ---
Ven enable 0 PWL(0ns 0V 45ns 0V 50ns 5V 500ns 5V)

* --- Initial condition: force ring to a known state to kick-start oscillation ---
* Without this, the ring might start at a metastable DC operating point.
.ic v(ring_out)=0V

* --- NAND gate (nand2_1): A1 A2 ZN VDD VNW VPW VSS ---
* A1 = ring feedback (ring_out), A2 = enable, ZN = nand_out
Xnand ring_out enable nand_out VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__nand2_1

* --- Inverter stages 2-8 (clkinv_1): I ZN VDD VNW VPW VSS ---
Xinv2 nand_out     s2  VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1
Xinv3 s2           s3  VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1
Xinv4 s3           s4  VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1
Xinv5 s4           s5  VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1
Xinv6 s5           s6  VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1
Xinv7 s6           s7  VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1
Xinv8 s7           s8  VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1

* --- Inverter stage 9 (clkinv_2 — bigger drive strength, matches extracted netlist) ---
Xinv9 s8           ring_out VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_2

* --- Tap buffer: isolates the ring from the load so the ring swings rail-to-rail ---
Xtap ring_out tap_out VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__buf_8

* --- Load on the buffered output: 10pF (scope probe) ---
Cload tap_out 0 10p

* --- Options ---
.options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25 gmin=1e-12 rshunt=1e12

.control
* Use uic to respect .ic initial condition
tran 0.1ns 500ns uic

* Measure oscillation frequency: time between 2 consecutive rising edges
meas tran t_period trig v(ring_out) val=2.5 rise=5 targ v(ring_out) val=2.5 rise=6

* Measure rise/fall times on the ring output itself
meas tran t_rise trig v(ring_out) val=0.5 rise=5 targ v(ring_out) val=4.5 rise=5
meas tran t_fall trig v(ring_out) val=4.5 fall=5 targ v(ring_out) val=0.5 fall=5

echo ""
echo "============================================"
echo "  9-STAGE RING OSCILLATOR (extracted from hardened chip)"
echo "  GF180MCU, 5V, 25C, 1pF load"
echo "============================================"
print t_period
let f_osc = 1/t_period
print f_osc
print t_rise
print t_fall
echo "============================================"

wrdata spice_ringosc.txt v(enable) v(ring_out) v(nand_out) v(s2) v(s5) v(s8) v(tap_out)
.endc

.end
