* Ring oscillator DCO: parallel tristate inverter drive-strength tuning
* Direct cell instantiation (no subcircuit wrapper — ngspice has issues
* with multiple tri-state outputs inside a .SUBCKT).
* Sweeps 16 tuning codes.
*
* 9-stage ring: NAND + 4 tunable stages (base invz_1 + parallel invz_1/2/4/8)
*              + 4 fixed invz_1 stages
* GF180MCU, 5V, 25C (synth-only, no parasitics)

.param fnoicor=0
.param sw_stat_global=0
.param sw_stat_mismatch=0
.param mc_skew=3
.param res_mc_skew=3
.param cap_mc_skew=3

.include /home/anish/wafer_space_docker_based_starter_kit/pdk/gf180mcuD/libs.tech/ngspice/design.ngspice
.include /tmp/sm141064_typical.spice
.include /tmp/smbb000149_typical.spice
.include pdk/gf180mcuD/libs.ref/gf180mcu_fd_sc_mcu7t5v0/spice/gf180mcu_fd_sc_mcu7t5v0.spice

VDD_net VDD 0 5.0
VSS_net VSS 0 0
Ven enable 0 5.0

Vcode0 code0 0 0
Vcode1 code1 0 0
Vcode2 code2 0 0
Vcode3 code3 0 0

* NAND gate
Xnand enable ring_out ring0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__nand2_1

* Stage 2: tunable (base + 4 parallel)
Xs2b VDD ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2a code0 ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2c code1 ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_2
Xs2d code2 ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_4
Xs2e code3 ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_8

* Stage 3: fixed
Xs3 VDD r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1

* Stage 4: tunable
Xs4b VDD r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs4a code0 r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs4c code1 r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_2
Xs4d code2 r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_4
Xs4e code3 r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_8

* Stage 5: fixed
Xs5 VDD r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1

* Stage 6: tunable
Xs6b VDD r4 r5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs6a code0 r4 r5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs6c code1 r4 r5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_2
Xs6d code2 r4 r5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_4
Xs6e code3 r4 r5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_8

* Stage 7: fixed
Xs7 VDD r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1

* Stage 8: tunable
Xs8b VDD r6 r7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs8a code0 r6 r7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs8c code1 r6 r7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_2
Xs8d code2 r6 r7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_4
Xs8e code3 r6 r7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_8

* Stage 9: fixed
Xs9 VDD r7 ring_out VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1

.ic v(ring_out)=0V
.options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25

.control
echo ""
echo "============================================"
echo "  DCO DRIVE-STRENGTH TUNING SWEEP"
echo "  9-stage ring, 4-bit parallel invz tuning"
echo "  GF180MCU, 5V, 25C (synth-only)"
echo "============================================"
echo "Code  Freq(MHz)  Period(ns)  DriveX"

let code = 0
while code < 16
let code = 0
while code < 16
    let b0 = code - 2*int(code/2)
    let b1 = int(code/2) - 2*int(code/4)
    let b2 = int(code/4) - 2*int(code/8)
    let b3 = int(code/8)

    * Use alter with explicit 0 or 5 based on bit values
    let v0 = 0
    let v1 = 0
    let v2 = 0
    let v3 = 0
    if b0 gt 0.5
        let v0 = 5
    end
    if b1 gt 0.5
        let v1 = 5
    end
    if b2 gt 0.5
        let v2 = 5
    end
    if b3 gt 0.5
        let v3 = 5
    end

    alter @Vcode0[dc] = $v0
    alter @Vcode1[dc] = $v1
    alter @Vcode2[dc] = $v2
    alter @Vcode3[dc] = $v3

    tran 0.1ns 100ns uic

    meas tran t_period trig v(ring_out) val=2.5 rise=3 targ v(ring_out) val=2.5 rise=4

    let f_mhz = 1.0 / t_period / 1e6
    let t_ns = t_period * 1e9
    let drv = 1 + b0*1 + b1*2 + b2*4 + b3*8
    echo $&code  $&f_mhz  $&t_ns  $&drv

    let code = code + 1
end while

echo "============================================"
.endc

.end
