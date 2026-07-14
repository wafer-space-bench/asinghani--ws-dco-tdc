#!/usr/bin/env python3
"""
32x thermometer DCO sweep: 33 codes (0-32), all invz_1 cells.
4 tunable stages (2,4,6,8), each with 1 base + N parallel invz_1.
Total drive per tunable stage: 1x (code 0) to 33x (code 32).
Synth-only (no parasitics).
"""
import subprocess
import os
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

os.chdir('/home/anish/wafer_space_docker_based_starter_kit')

CODES = range(33)  # 0..32
NUM_TUNABLE = 4   # stages 2,4,6,8

def gen_spice(code):
    n = code  # extra parallel invz_1 per tunable stage
    lines = []
    lines.append(f"* Thermometer 32x: code={code} (drive={1+n}x per tunable stage)")
    lines.append(".param fnoicor=0")
    lines.append(".param sw_stat_global=0")
    lines.append(".param sw_stat_mismatch=0")
    lines.append(".param mc_skew=3")
    lines.append(".param res_mc_skew=3")
    lines.append(".param cap_mc_skew=3")
    lines.append(".include /home/anish/wafer_space_docker_based_starter_kit/pdk/gf180mcuD/libs.tech/ngspice/design.ngspice")
    lines.append(".include /tmp/sm141064_typical.spice")
    lines.append(".include /tmp/smbb000149_typical.spice")
    lines.append(".include pdk/gf180mcuD/libs.ref/gf180mcu_fd_sc_mcu7t5v0/spice/gf180mcu_fd_sc_mcu7t5v0.spice")
    lines.append("VDD_net VDD 0 5.0")
    lines.append("VSS_net VSS 0 0")
    lines.append("Ven enable 0 5.0")
    lines.append("")
    # NAND gate (stage 1)
    lines.append("Xnand enable ring_out ring0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__nand2_1")
    # Tunable stages: 2,4,6,8 -- each with (1+n) invz_1 in parallel
    # Fixed stages: 3,5,7,9 -- single invz_1
    stage_io = {
        2: ('ring0', 'r1'),
        3: ('r1', 'r2'),
        4: ('r2', 'r3'),
        5: ('r3', 'r4'),
        6: ('r4', 'r5'),
        7: ('r5', 'r6'),
        8: ('r6', 'r7'),
        9: ('r7', 'ring_out'),
    }
    tunable = {2, 4, 6, 8}
    for s in range(2, 10):
        inp, outp = stage_io[s]
        if s in tunable:
            # Base + N parallel, all EN=VDD
            for k in range(1 + n):
                lines.append(f"Xs{s}_{k} VDD {inp} {outp} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1")
        else:
            lines.append(f"Xs{s} VDD {inp} {outp} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1")
    lines.append(".ic v(ring_out)=0V")
    lines.append(".options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25")
    lines.append(".control")
    lines.append("tran 0.1ns 100ns uic")
    lines.append("meas tran t_period trig v(ring_out) val=2.5 rise=3 targ v(ring_out) val=2.5 rise=4")
    lines.append('let f_mhz = 1.0 / t_period / 1e6')
    lines.append('echo "RESULT $&f_mhz"')
    lines.append(".endc")
    lines.append(".end")
    return '\n'.join(lines)

codes = []
freqs = []

for code in CODES:
    sp_content = gen_spice(code)
    sp_file = f'/tmp/dco_therm32_{code}.sp'
    with open(sp_file, 'w') as f:
        f.write(sp_content)

    drive = 1 + code
    print(f"Code {code:2d} (drive={drive:2d}x, {drive*NUM_TUNABLE + 5} invz_1 total)...", end=' ', flush=True)
    try:
        result = subprocess.run(
            ['ngspice', '-b', sp_file],
            capture_output=True, text=True, timeout=120
        )
        output = result.stdout + result.stderr
        found = False
        for line in output.split('\n'):
            if 'RESULT' in line:
                try:
                    freq = float(line.split()[-1])
                    codes.append(code)
                    freqs.append(freq)
                    print(f"{freq:.3f} MHz")
                    found = True
                    break
                except ValueError:
                    pass
        if not found:
            print("FAILED")
            codes.append(code)
            freqs.append(0)
    except subprocess.TimeoutExpired:
        print("TIMEOUT")
        codes.append(code)
        freqs.append(0)

# Plot
fig, ax = plt.subplots(figsize=(14, 6))
ax.bar(codes, freqs, color='steelblue', edgecolor='black', linewidth=0.3)
ax.set_xlabel('Tuning Code (0-32, thermometer)')
ax.set_ylabel('Frequency (MHz)')
ax.set_title('DCO 32x Thermometer Tuning: Frequency vs Code\n'
             '9-stage ring, 4 tunable stages, all invz_1 (1x to 33x drive)\n'
             'GF180MCU, 5V, 25C, synth-only (no parasitics)')
ax.set_xticks(range(0, 33, 2))
ax.grid(True, alpha=0.3, axis='y')

fig.tight_layout()
fig.savefig('dco_therm32_plot.png', dpi=150)
print(f"\nSaved dco_therm32_plot.png")

# Print summary table
print(f"\n=== DCO 32x Thermometer Results ===")
print(f"{'Code':>5} {'Drive':>6} {'Freq(MHz)':>10} {'Period(ns)':>10} {'Step(MHz)':>10}")
prev_f = None
for c, f in zip(codes, freqs):
    drv = 1 + c
    step = f - prev_f if prev_f is not None else 0
    print(f"{c:5d} {drv:5d}x {f:10.3f} {1000/f:10.3f} {step:10.4f}")
    prev_f = f

# Compute step sizes
diffs = np.diff(freqs)
print(f"\nRange: {min(freqs):.3f} - {max(freqs):.3f} MHz ({max(freqs)/min(freqs):.2f}x)")
print(f"Mean step: {np.mean(diffs):.4f} MHz")
print(f"Max step:  {np.max(diffs):.4f} MHz")
print(f"Min step:  {np.min(diffs):.4f} MHz")
print(f"Median step: {np.median(diffs):.4f} MHz")

# Show steps around 100 MHz
print(f"\n--- Steps near 100 MHz ---")
for c, f in zip(codes, freqs):
    if 80 < f < 130:
        idx = codes.index(c)
        if idx > 0:
            step = f - freqs[idx-1]
            print(f"Code {c:2d}: {f:.3f} MHz, step={step:.4f} MHz")
