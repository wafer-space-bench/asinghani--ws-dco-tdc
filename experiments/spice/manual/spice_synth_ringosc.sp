* Synth-only SPICE: just the ring oscillator (extracted from Yosys output)
* No pad cells, no parasitics — pure gate-level SPICE from synthesis.
* GF180MCU, 5V, typical corner, 25C

* --- PDK model parameters ---
.param fnoicor=0
.param sw_stat_global=0
.param sw_stat_mismatch=0
.param mc_skew=3
.param res_mc_skew=3
.param cap_mc_skew=3

* --- PDK model files ---
.include /home/anish/wafer_space_docker_based_starter_kit/pdk/gf180mcuD/libs.tech/ngspice/design.ngspice
.include /tmp/sm141064_typical.spice
.include /tmp/smbb000149_typical.spice

* --- Standard-cell SPICE (transistor-level) ---
.include pdk/gf180mcuD/libs.ref/gf180mcu_fd_sc_mcu7t5v0/spice/gf180mcu_fd_sc_mcu7t5v0.spice

* --- Power ---
VDD_net VDD 0 5.0
VSS_net VSS 0 0

* --- Enable ---
Ven enable 0 PWL(0ns 0V 45ns 0V 50ns 5V 500ns 5V)

* --- NAND gate (nand2_1): A1 A2 ZN VDD VNW VPW VSS ---
Xnand enable ring_out ring0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__nand2_1

* --- 8 inverter stages (clkinv_1): I ZN VDD VNW VPW VSS ---
Xinv2 ring0 ring1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1
Xinv3 ring1 ring2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1
Xinv4 ring2 ring3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1
Xinv5 ring3 ring4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1
Xinv6 ring4 ring5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1
Xinv7 ring5 ring6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1
Xinv8 ring6 ring7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1
Xinv9 ring7 ring_out VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1

* --- Initial condition to kick-start ---
.ic v(ring_out)=0V

* --- Options ---
.options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25 gmin=1e-12 rshunt=1e12

.control
tran 0.1ns 500ns uic

meas tran t_period trig v(ring_out) val=2.5 rise=5 targ v(ring_out) val=2.5 rise=6
let f_osc = 1/t_period

echo ""
echo "============================================"
echo "  SYNTH-ONLY RING OSC (no parasitics, no PnR)"
echo "  GF180MCU, 5V, 25C"
echo "============================================"
print t_period
print f_osc
echo "============================================"

wrdata spice_synth_ringosc.txt v(enable) v(ring_out) v(ring0) v(ring4) v(ring7)
.endc

.end
