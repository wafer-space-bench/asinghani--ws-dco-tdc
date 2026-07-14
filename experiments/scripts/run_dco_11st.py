#!/usr/bin/env python3
"""
11-stage ring, 4 tunable stages, 33-cell thermometer, 0.1ns timestep, 100ns tran.
Should be same speed as 9-stage (similar cell count: 138 vs 136).
9-stage gave 107-141 MHz; 11-stage should give ~87-115 MHz.
100 MHz should land around code 24-28 where steps are <0.1 MHz.
"""
import subprocess
import os

os.chdir('/home/anish/wafer_space_docker_based_starter_kit')

num_stages = 11
NUM_TUNABLE = 4
TOTAL_CELLS = 33

def gen_spice(code):
    n_enabled = code + 1
    lines = []
    lines.append(f"* Ring {num_stages} stages, code={code} (en={n_enabled}/33)")
    lines.append(".param fnoicor=0")
    lines.append(".param sw_stat_global=0")
    lines.append(".param sw_stat_mismatch=0")
    lines.append(".param mc_skew=3")
    lines.append(".param res_mc_skew=3")
    lines.append(".param cap_mc_skew=3")
    lines.append(".include /home/anish/wafer_space_docker_based_starter_kit/pdk/gf180mcuD/libs.tech/ngspice/design.ngspice")
    lines.append(".include /home/anish/wafer_space_docker_based_starter_kit/spice_sim/sm141064_typical.spice")
    lines.append(".include /home/anish/wafer_space_docker_based_starter_kit/spice_sim/smbb000149_typical.spice")
    lines.append(".include pdk/gf180mcuD/libs.ref/gf180mcu_fd_sc_mcu7t5v0/spice/gf180mcu_fd_sc_mcu7t5v0.spice")
    lines.append("VDD_net VDD 0 5.0")
    lines.append("VSS_net VSS 0 0")
    lines.append("Ven enable 0 5.0")
    lines.append("VEN_on EN_on 0 5.0")
    lines.append("VEN_off EN_off 0 0")
    lines.append("")
    lines.append("Xnand enable ring_out ring0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__nand2_1")

    stage_inputs = ['ring0'] + [f'r{i}' for i in range(1, num_stages - 1)]
    stage_outputs = [f'r{i}' for i in range(1, num_stages - 1)] + ['ring_out']

    for s in range(num_stages - 1):
        inp = stage_inputs[s]
        outp = stage_outputs[s]
        if s < NUM_TUNABLE:
            for k in range(TOTAL_CELLS):
                en = "EN_on" if k < n_enabled else "EN_off"
                lines.append(f"Xs{s}_{k} {en} {inp} {outp} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1")
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

for code in range(33):
    sp_content = gen_spice(code)
    sp_file = f'spice_sim/dco_11st_{code}.sp'
    with open(sp_file, 'w') as f:
        f.write(sp_content)

    n_en = code + 1
    print(f"Code {code:2d} (en={n_en:2d}/33)...", end=' ', flush=True)
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

import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

fig, ax = plt.subplots(figsize=(14, 6))
ax.bar(codes, freqs, color='steelblue', edgecolor='black', linewidth=0.3)
ax.set_xlabel('Tuning Code (0-32, thermometer)')
ax.set_ylabel('Frequency (MHz)')
ax.set_title('DCO 32x Thermometer: 11-Stage Ring, 4 Tunable Stages\n'
             '33 invz_1 per tunable stage (tristate EN)\n'
             'GF180MCU, 5V, 25C, synth-only')
ax.set_xticks(range(0, 33, 2))
ax.grid(True, alpha=0.3, axis='y')
ax.axhline(y=100, color='red', linestyle='--', label='100 MHz target')
ax.legend()
fig.tight_layout()
fig.savefig('dco_therm32_11st_plot.png', dpi=150)
print(f"\nSaved dco_therm32_11st_plot.png")

print(f"\n=== 11-Stage Ring, 33-Cell Thermometer ===")
print(f"{'Code':>5} {'En':>4} {'Freq(MHz)':>10} {'Step(MHz)':>10}")
prev = None
for c, f in zip(codes, freqs):
    step = f - prev if prev is not None else 0
    print(f"{c:5d} {c+1:4d} {f:10.3f} {step:10.4f}")
    prev = f

valid = [f for f in freqs if f > 0]
if valid:
    diffs = np.diff([f for f in freqs if f > 0])
    print(f"\nRange: {min(valid):.3f} - {max(valid):.3f} MHz ({max(valid)/min(valid):.2f}x)")
    print(f"Median step: {np.median(diffs):.4f} MHz")
    print(f"\n--- Near 100 MHz ---")
    for i, (c, f) in enumerate(zip(codes, freqs)):
        if 90 < f < 110 and i > 0 and freqs[i-1] > 0:
            print(f"  Code {c}: {f:.3f} MHz, step={f-freqs[i-1]:.4f} MHz")
