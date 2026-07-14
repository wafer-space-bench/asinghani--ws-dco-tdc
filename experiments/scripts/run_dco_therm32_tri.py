#!/usr/bin/env python3
"""
32x thermometer DCO sweep with TRISTATE invz_1 cells.
33 codes (0-32), 4 tunable stages (2,4,6,8).
Each tunable stage has 33 invz_1 cells: (N+1) enabled (EN=VDD), rest disabled (EN=0).
Disabled cells still add gate cap but don't drive — so base freq is lower
but adding more enabled cells increases drive → higher frequency.
Monotonic, fine steps at high drive.
"""
import subprocess
import os
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

os.chdir('/home/anish/wafer_space_docker_based_starter_kit')

CODES = range(33)
NUM_TUNABLE = 4
TOTAL_CELLS_PER_STAGE = 33  # always present

def gen_spice(code):
    n_enabled = code + 1  # 1..33
    lines = []
    lines.append(f"* Thermometer 32x tristate: code={code} (enabled={n_enabled}/33)")
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
    lines.append("VEN_on EN_on 0 5.0")
    lines.append("VEN_off EN_off 0 0")
    lines.append("")
    lines.append("Xnand enable ring_out ring0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__nand2_1")
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
            for k in range(TOTAL_CELLS_PER_STAGE):
                if k < n_enabled:
                    lines.append(f"Xs{s}_{k} EN_on {inp} {outp} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1")
                else:
                    lines.append(f"Xs{s}_{k} EN_off {inp} {outp} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1")
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
    sp_file = f'/tmp/dco_therm32tri_{code}.sp'
    with open(sp_file, 'w') as f:
        f.write(sp_content)

    n_en = code + 1
    total = n_en * NUM_TUNABLE + 5 + (TOTAL_CELLS_PER_STAGE - n_en) * NUM_TUNABLE
    print(f"Code {code:2d} (enabled={n_en:2d}/33)...", end=' ', flush=True)
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
ax.set_title('DCO 32x Thermometer (Tristate): Frequency vs Code\n'
             '9-stage ring, 4 tunable stages, 33 invz_1 each (tristate EN)\n'
             'GF180MCU, 5V, 25C, synth-only (no parasitics)')
ax.set_xticks(range(0, 33, 2))
ax.grid(True, alpha=0.3, axis='y')
fig.tight_layout()
fig.savefig('dco_therm32_tri_plot.png', dpi=150)
print(f"\nSaved dco_therm32_tri_plot.png")

# Summary table
print(f"\n=== DCO 32x Thermometer (Tristate) Results ===")
print(f"{'Code':>5} {'Enabled':>8} {'Freq(MHz)':>10} {'Period(ns)':>10} {'Step(MHz)':>10}")
prev_f = None
for c, f in zip(codes, freqs):
    n_en = c + 1
    step = f - prev_f if prev_f is not None else 0
    print(f"{c:5d} {n_en:7d} {f:10.3f} {1000/f:10.3f} {step:10.4f}")
    prev_f = f

diffs = np.diff(freqs)
print(f"\nRange: {min(freqs):.3f} - {max(freqs):.3f} MHz ({max(freqs)/min(freqs):.2f}x)")
print(f"Mean step: {np.mean(diffs):.4f} MHz")
print(f"Max step:  {np.max(diffs):.4f} MHz")
print(f"Min step:  {np.min(diffs):.4f} MHz")
print(f"Median step: {np.median(diffs):.4f} MHz")

# Monotonicity
neg = sum(1 for d in diffs if d < 0)
print(f"Non-monotonic: {neg}/{len(diffs)} steps negative")

# Steps near 100 MHz
print(f"\n--- Steps near 100 MHz ---")
for i, (c, f) in enumerate(zip(codes, freqs)):
    if 80 < f < 130 and i > 0:
        step = f - freqs[i-1]
        print(f"Code {c:2d}: {f:.3f} MHz, step={step:.4f} MHz")
