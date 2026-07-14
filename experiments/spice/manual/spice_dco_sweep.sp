* 9-stage ring oscillator with 4-bit tristate cap tuning
* Synth-only SPICE (no parasitics) — sweeps all 16 tuning codes.
*
* Each of the 8 inverter stages has 4 disabled-tristate invz cells
* (invz_1, invz_2, invz_4, invz_8) acting as binary-weighted gate-cap loads.
* EN=0 → disabled → gate cap loads the ring node.
* EN=1 → enabled → acts as inverter (not used here).
*
* We drive ~load_code to EN, so load_code=0 → all caps active, load_code=15 → none.
*
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

* --- Enable: always high (ring running) ---
Ven enable 0 5.0

* --- Tuning code bits (controlled by ngspice .control loop) ---
Vcode0 code0 0 0
Vcode1 code1 0 0
Vcode2 code2 0 0
Vcode3 code3 0 0

* --- Invert code bits for EN (0=caps active, 1=caps inactive) ---
Xinv_code0 code0 en0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1
Xinv_code1 code1 en1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1
Xinv_code2 code2 en2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1
Xinv_code3 code3 en3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1

* --- NAND gate (nand2_1): A1 A2 ZN VDD VNW VPW VSS ---
Xnand enable ring_out ring0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__nand2_1

* --- 8 inverter stages + 4 binary-weighted caps each ---
* invz port order: EN I ZN VDD VNW VPW VSS

* Stage 1
Xinv2 ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1
Xc1a en0 r1 za1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xc1b en1 r1 zb1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_2
Xc1c en2 r1 zc1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_4
Xc1d en3 r1 zd1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_8

* Stage 2
Xinv3 r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1
Xc2a en0 r2 za2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xc2b en1 r2 zb2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_2
Xc2c en2 r2 zc2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_4
Xc2d en3 r2 zd2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_8

* Stage 3
Xinv4 r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1
Xc3a en0 r3 za3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xc3b en1 r3 zb3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_2
Xc3c en2 r3 zc3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_4
Xc3d en3 r3 zd3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_8

* Stage 4
Xinv5 r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1
Xc4a en0 r4 za4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xc4b en1 r4 zb4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_2
Xc4c en2 r4 zc4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_4
Xc4d en3 r4 zd4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_8

* Stage 5
Xinv6 r4 r5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1
Xc5a en0 r5 za5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xc5b en1 r5 zb5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_2
Xc5c en2 r5 zc5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_4
Xc5d en3 r5 zd5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_8

* Stage 6
Xinv7 r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1
Xc6a en0 r6 za6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xc6b en1 r6 zb6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_2
Xc6c en2 r6 zc6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_4
Xc6d en3 r6 zd6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_8

* Stage 7
Xinv8 r6 r7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1
Xc7a en0 r7 za7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xc7b en1 r7 zb7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_2
Xc7c en2 r7 zc7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_4
Xc7d en3 r7 zd7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_8

* Stage 8 (output = ring_out, feeds back to NAND)
Xinv9 r7 ring_out VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__clkinv_1
Xc8a en0 ring_out za8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xc8b en1 ring_out zb8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_2
Xc8c en2 ring_out zc8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_4
Xc8d en3 ring_out zd8 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_8

* --- Options ---
.options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25 gmin=1e-12 rshunt=1e12

.control

echo ""
echo "============================================"
echo "  RING OSC DCO: TRISTATE CAP TUNING SWEEP"
echo "  9-stage ring, 4-bit binary-weighted caps"
echo "  GF180MCU, 5V, 25C (synth-only, no parasitics)"
echo "============================================"
echo "Code  Freq(MHz)  Period(ns)"

let code = 0
while code < 16
    * Set tuning code bits using alter on voltage sources
    let b0 = code - 2*int(code/2)
    let b1 = int(code/2) - 2*int(code/4)
    let b2 = int(code/4) - 2*int(code/8)
    let b3 = int(code/8)

    alter Vcode0 dc = $b0 * 5
    alter Vcode1 dc = $b1 * 5
    alter Vcode2 dc = $b2 * 5
    alter Vcode3 dc = $b3 * 5

    tran 0.1ns 200ns uic

    meas tran t_period trig v(ring_out) val=2.5 rise=3 targ v(ring_out) val=2.5 rise=4

    let f_osc = 1.0 / t_period
    let f_mhz = f_osc / 1e6
    let t_ns = t_period * 1e9
    echo $&code  $&f_mhz  $&t_ns

    let code = code + 1
end while

echo "============================================"

.endc

.end
