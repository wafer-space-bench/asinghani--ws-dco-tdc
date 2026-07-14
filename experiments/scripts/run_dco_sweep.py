#!/usr/bin/env python3
"""
Run ngspice for all 16 tuning codes and plot the frequency vs code.
Generates 16 individual SPICE files (hardcoded code values), runs ngspice
on each, collects the frequency, and plots the result.
"""
import subprocess
import os
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

TEMPLATE = """* Code {code}: drive-strength tuning
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
Vcode0 code0 0 {v0}
Vcode1 code1 0 {v1}
Vcode2 code2 0 {v2}
Vcode3 code3 0 {v3}

Xnand enable ring_out ring0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__nand2_1
Xs2b VDD ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2a code0 ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs2c code1 ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_2
Xs2d code2 ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_4
Xs2e code3 ring0 r1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_8
Xs3 VDD r1 r2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs4b VDD r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs4a code0 r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs4c code1 r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_2
Xs4d code2 r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_4
Xs4e code3 r2 r3 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_8
Xs5 VDD r3 r4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs6b VDD r4 r5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs6a code0 r4 r5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs6c code1 r4 r5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_2
Xs6d code2 r4 r5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_4
Xs6e code3 r4 r5 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_8
Xs7 VDD r5 r6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs8b VDD r6 r7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs8a code0 r6 r7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
Xs8c code1 r6 r7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_2
Xs8d code2 r6 r7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_4
Xs8e code3 r6 r7 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_8
Xs9 VDD r7 ring_out VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1
.ic v(ring_out)=0V
.options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25
.control
tran 0.1ns 100ns uic
meas tran t_period trig v(ring_out) val=2.5 rise=3 targ v(ring_out) val=2.5 rise=4
let f_mhz = 1.0 / t_period / 1e6
echo "RESULT $&f_mhz"
.endc
.end
"""

os.chdir('/home/anish/wafer_space_docker_based_starter_kit')

codes = []
freqs = []

for code in range(16):
    b0 = code & 1
    b1 = (code >> 1) & 1
    b2 = (code >> 2) & 1
    b3 = (code >> 3) & 1
    v0 = b0 * 5
    v1 = b1 * 5
    v2 = b2 * 5
    v3 = b3 * 5

    sp_content = TEMPLATE.format(code=code, v0=v0, v1=v1, v2=v2, v3=v3)
    sp_file = f'/tmp/dco_code_{code}.sp'
    with open(sp_file, 'w') as f:
        f.write(sp_content)

    print(f"Running code {code} (drive={1+b0*1+b1*2+b2*4+b3*8}x)...", end=' ', flush=True)
    result = subprocess.run(
        ['ngspice', '-b', sp_file],
        capture_output=True, text=True, timeout=60
    )
    output = result.stdout + result.stderr
    for line in output.split('\n'):
        if 'RESULT' in line:
            try:
                freq = float(line.split()[-1])
                codes.append(code)
                freqs.append(freq)
                print(f"{freq:.1f} MHz")
                break
            except ValueError:
                pass
    else:
        print("FAILED")
        codes.append(code)
        freqs.append(0)

# Plot
fig, ax = plt.subplots(figsize=(10, 6))
ax.bar(codes, freqs, color='steelblue', edgecolor='black')
ax.set_xlabel('Tuning Code (4-bit)')
ax.set_ylabel('Frequency (MHz)')
ax.set_title('DCO Drive-Strength Tuning: Frequency vs Code\n'
             '9-stage ring, 4 tunable stages with parallel invz_1/2/4/8\n'
             'GF180MCU, 5V, 25C, synth-only (no parasitics)')
ax.set_xticks(range(16))
ax.grid(True, alpha=0.3, axis='y')

# Add drive strength on secondary axis
ax2 = ax.twiny()
drive_labels = [f"{1 + (c&1)*1 + ((c>>1)&1)*2 + ((c>>2)&1)*4 + ((c>>3)&1)*8}x" for c in range(16)]
ax2.set_xlim(ax.get_xlim())
ax2.set_xticks(range(16))
ax2.set_xticklabels(drive_labels, fontsize=7)
ax2.set_xlabel('Drive Strength (per tunable stage)')

fig.tight_layout()
fig.savefig('dco_tuning_plot.png', dpi=150)
print(f"\nSaved dco_tuning_plot.png")

# Print summary
print(f"\n=== DCO Tuning Results ===")
print(f"{'Code':>4} {'Drive':>6} {'Freq(MHz)':>10} {'Period(ns)':>10}")
for c, f in zip(codes, freqs):
    drv = 1 + (c&1)*1 + ((c>>1)&1)*2 + ((c>>2)&1)*4 + ((c>>3)&1)*8
    print(f"{c:4d} {drv:5d}x {f:10.1f} {1000/f:10.2f}")
print(f"\nRange: {min(freqs):.1f} – {max(freqs):.1f} MHz ({max(freqs)/min(freqs):.2f}x)")
