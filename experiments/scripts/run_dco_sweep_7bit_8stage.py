#!/usr/bin/env python3
"""
Run ngspice for all 128 tuning codes (7-bit) and plot the frequency vs code.
ALL 8 non-NAND stages are tunable (stages 2-9), each with base invz_1 + 7
code-switched parallel drivers: invz_1/2/3/4/8/12/16.
"""
import subprocess
import os
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

# Drive strengths per cell type
DRIVE = [1, 2, 3, 4, 8, 12, 16]  # invz_1/2/3/4/8/12/16
NBITS = 7

TEMPLATE = """* Code {code}: 7-bit drive-strength tuning, all 8 stages tunable
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
{code_voltage_lines}

Xnand enable ring_out ring0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__nand2_1
{stage_instances}
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

# SPICE cell names for each bit
CELL_NAMES = [
    'gf180mcu_fd_sc_mcu7t5v0__invz_1',
    'gf180mcu_fd_sc_mcu7t5v0__invz_2',
    'gf180mcu_fd_sc_mcu7t5v0__invz_3',
    'gf180mcu_fd_sc_mcu7t5v0__invz_4',
    'gf180mcu_fd_sc_mcu7t5v0__invz_8',
    'gf180mcu_fd_sc_mcu7t5v0__invz_12',
    'gf180mcu_fd_sc_mcu7t5v0__invz_16',
]

# All 8 stages (2-9) are tunable. Stage 1 is the NAND gate.
# Ring: NAND(ring_out) -> ring0 -> s2 -> r1 -> s3 -> r2 -> s4 -> r3 -> s5 -> r4
#       -> s6 -> r5 -> s7 -> r6 -> s8 -> r7 -> s9 -> ring_out
STAGE_MAP = {
    2: ('ring0', 'r1'),
    3: ('r1', 'r2'),
    4: ('r2', 'r3'),
    5: ('r3', 'r4'),
    6: ('r4', 'r5'),
    7: ('r5', 'r6'),
    8: ('r6', 'r7'),
    9: ('r7', 'ring_out'),
}

def gen_code_lines(code):
    lines = []
    for i in range(NBITS):
        bit = (code >> i) & 1
        v = bit * 5.0
        lines.append(f"Vcode{i} code{i} 0 {v}")
    return '\n'.join(lines)

def gen_stage_instances():
    """Generate SPICE for all 8 tunable stages (2-9)."""
    parts = []
    for stage_num in sorted(STAGE_MAP.keys()):
        inp, outp = STAGE_MAP[stage_num]
        # Base invz_1 always on (EN=VDD)
        parts.append(f"Xs{stage_num}b VDD {inp} {outp} VDD VDD VSS VSS {CELL_NAMES[0]}")
        # 7 code-switched parallel drivers
        for i in range(NBITS):
            parts.append(f"Xs{stage_num}d{i} code{i} {inp} {outp} VDD VDD VSS VSS {CELL_NAMES[i]}")
    return '\n'.join(parts)

os.chdir('/home/anish/wafer_space_docker_based_starter_kit')

stage_instances = gen_stage_instances()

codes = []
freqs = []

for code in range(128):
    bits = [(code >> i) & 1 for i in range(NBITS)]
    total_drive = 1 + sum(b * d for b, d in zip(bits, DRIVE))

    code_voltage_lines = gen_code_lines(code)
    sp_content = TEMPLATE.format(
        code=code,
        code_voltage_lines=code_voltage_lines,
        stage_instances=stage_instances,
    )
    sp_file = f'/tmp/dco7_8st_code_{code}.sp'
    with open(sp_file, 'w') as f:
        f.write(sp_content)

    print(f"Code {code:3d} (drive={total_drive:2d}x)...", end=' ', flush=True)
    try:
        result = subprocess.run(
            ['ngspice', '-b', sp_file],
            capture_output=True, text=True, timeout=60
        )
        output = result.stdout + result.stderr
        found = False
        for line in output.split('\n'):
            if 'RESULT' in line:
                try:
                    freq = float(line.split()[-1])
                    codes.append(code)
                    freqs.append(freq)
                    print(f"{freq:.2f} MHz")
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
ax.set_xlabel('Tuning Code (7-bit, 0-127)')
ax.set_ylabel('Frequency (MHz)')
ax.set_title('DCO 7-Bit Drive-Strength Tuning: ALL 8 Stages Tunable\n'
             '9-stage ring, 8 tunable stages with parallel invz_1/2/3/4/8/12/16\n'
             'GF180MCU, 5V, 25C, synth-only (no parasitics)')
ax.set_xticks(range(0, 128, 8))
ax.grid(True, alpha=0.3, axis='y')

fig.tight_layout()
fig.savefig('dco_tuning_7bit_8stage_plot.png', dpi=150)
print(f"\nSaved dco_tuning_7bit_8stage_plot.png")

# Print summary table
print(f"\n=== DCO 7-Bit Tuning Results (8 tunable stages) ===")
print(f"{'Code':>5} {'Drive':>6} {'Freq(MHz)':>10} {'Period(ns)':>10} {'Step(MHz)':>10}")
prev_f = None
for c, f in zip(codes, freqs):
    bits = [(c >> i) & 1 for i in range(NBITS)]
    drv = 1 + sum(b * d for b, d in zip(bits, DRIVE))
    step = f - prev_f if prev_f is not None else 0
    print(f"{c:5d} {drv:5d}x {f:10.2f} {1000/f:10.2f} {step:10.3f}")
    prev_f = f

# Compute step sizes
diffs = np.diff(freqs)
print(f"\nRange: {min(freqs):.2f} - {max(freqs):.2f} MHz ({max(freqs)/min(freqs):.2f}x)")
print(f"Mean step: {np.mean(diffs):.3f} MHz")
print(f"Max step:  {np.max(diffs):.3f} MHz")
print(f"Min step:  {np.min(diffs):.3f} MHz")
print(f"Median step: {np.median(diffs):.3f} MHz")
