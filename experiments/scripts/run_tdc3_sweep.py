#!/usr/bin/env python3
"""
3-Level Vernier TDC sweep — 3 separate sims per ΔT (one per level).
Each sim is small (16 DFFs + ~40 inverters) so ngspice handles it fast.

  FINE:     START = 2×inv_1,  STOP = 2×inv_4   (~50 ps/tap)
  COARSE:   START = 2×inv_1,  STOP = 2×inv_16  (~150 ps/tap)
  XCOARSE:  START = 4×inv_1,  STOP = 2×inv_16  (~300 ps/tap)
"""
import subprocess
import os

os.chdir('/home/anish/wafer_space_docker_based_starter_kit')

NUM_TAPS = 16

LEVELS = [
    ('FINE',    2, 'gf180mcu_fd_sc_mcu7t5v0__inv_1',  2, 'gf180mcu_fd_sc_mcu7t5v0__inv_4'),
    ('COARSE',  2, 'gf180mcu_fd_sc_mcu7t5v0__inv_1',  2, 'gf180mcu_fd_sc_mcu7t5v0__inv_16'),
    ('XCOARSE', 4, 'gf180mcu_fd_sc_mcu7t5v0__inv_1',  2, 'gf180mcu_fd_sc_mcu7t5v0__inv_16'),
]

def gen_spice(level_config, delta_t_ps):
    name, n_start_inv, start_cell, n_stop_inv, stop_cell = level_config
    prefix = name.lower()
    dt_ns = delta_t_ps * 1e-3
    lines = []
    lines.append(f"* {name} TDC: delta_t={delta_t_ps}ps")
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
    lines.append("")
    lines.append("VDD_net VDD 0 5.0")
    lines.append("VSS_net VSS 0 0")
    lines.append("")
    lines.append("Vrn RN 0 PULSE(0 5 5n 0.1n 0.1n 100n 200n)")
    lines.append("Vstart START_IN 0 PULSE(0 5 10n 0.1n 0.1n 100n 200n)")
    stop_time = 10.0 + dt_ns
    lines.append(f"Vstop STOP_IN 0 PULSE(0 5 {stop_time}n 0.1n 0.1n 100n 200n)")
    lines.append("")
    # START chain
    prev = "START_IN"
    for i in range(NUM_TAPS):
        for j in range(n_start_inv):
            out = f"{prefix}_start_s{i}" if j == n_start_inv - 1 else f"{prefix}_s{i}_{chr(98+j)}"
            lines.append(f"Xs_{i}_{j} {prev} {out} VDD VDD VSS VSS {start_cell}")
            prev = out
    # STOP chain
    prev = "STOP_IN"
    for i in range(NUM_TAPS):
        for j in range(n_stop_inv):
            out = f"{prefix}_stop_s{i}" if j == n_stop_inv - 1 else f"{prefix}_p{i}_{chr(98+j)}"
            lines.append(f"Xp_{i}_{j} {prev} {out} VDD VDD VSS VSS {stop_cell}")
            prev = out
    # DFFs
    for i in range(NUM_TAPS):
        lines.append(f"Xdff_{i} {prefix}_stop_s{i} RN {prefix}_start_s{i} {prefix}_q{i} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1")
    lines.append("")
    lines.append(".ic v(START_IN)=0 v(STOP_IN)=0 v(RN)=0")
    lines.append(".options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25")
    lines.append(".control")
    lines.append("tran 0.05ns 20ns uic")
    for i in range(NUM_TAPS):
        lines.append(f"meas tran {prefix}_q{i}_val FIND v({prefix}_q{i}) AT=18n")
    result_str = ' '.join([f"{prefix}_q{i}=$&{prefix}_q{i}_val" for i in range(NUM_TAPS)])
    lines.append(f'echo "RESULT {result_str}"')
    lines.append(".endc")
    lines.append(".end")
    return '\n'.join(lines)

sweep_points = list(range(0, 525, 25)) + list(range(600, 2050, 100)) + list(range(2250, 5250, 250))

results = []

for delta_t in sweep_points:
    all_ones = {}
    all_codes = {}

    for level_cfg in LEVELS:
        name = level_cfg[0]
        prefix = name.lower()
        sp_content = gen_spice(level_cfg, delta_t)
        sp_file = f'spice_sim/tdc3_{prefix}_{delta_t}ps.sp'
        with open(sp_file, 'w') as f:
            f.write(sp_content)

        try:
            result = subprocess.run(
                ['ngspice', '-b', sp_file],
                capture_output=True, text=True, timeout=60
            )
            output = result.stdout + result.stderr
            q_vals = {}
            found = False
            for line in output.split('\n'):
                if 'RESULT' in line:
                    found = True
                    parts = line.split()
                    for p in parts:
                        if '=' in p and p.startswith(f'{prefix}_q'):
                            pname, val = p.split('=')
                            try:
                                idx = int(pname[len(prefix)+2:])
                                q_vals[idx] = float(val)
                            except ValueError:
                                pass
                    break

            if found:
                code = ''
                for i in range(NUM_TAPS):
                    code += '1' if q_vals.get(i, 0) > 2.5 else '0'
                all_codes[name] = code
                all_ones[name] = code.count('1')
            else:
                all_codes[name] = '????????????????'
                all_ones[name] = 0
        except subprocess.TimeoutExpired:
            all_codes[name] = '????????????????'
            all_ones[name] = 0

    print(f"ΔT={delta_t:5d}ps  XC:{all_ones.get('XCOARSE',0):2d}  C:{all_ones.get('COARSE',0):2d}  F:{all_ones.get('FINE',0):2d}")
    results.append((delta_t, all_codes, all_ones))

# Summary
print(f"\n{'='*90}")
print(f"3-LEVEL VERNIER TDC RESULTS")
print(f"{'='*90}")
print(f"{'ΔT(ps)':>7} │ {'XCOARSE':>16} {'#':>3} │ {'COARSE':>16} {'#':>3} │ {'FINE':>16} {'#':>3}")
print(f"{'─'*7}─┼─{'─'*20}─┼─{'─'*20}─┼─{'─'*20}")
for dt, codes, ones in results:
    xc = codes.get('XCOARSE', '????????????????')
    c  = codes.get('COARSE',  '????????????????')
    f  = codes.get('FINE',    '????????????????')
    xo = ones.get('XCOARSE', 0)
    co = ones.get('COARSE', 0)
    fo = ones.get('FINE', 0)
    print(f"{dt:7d} │ {xc} {xo:3d} │ {c} {co:3d} │ {f} {fo:3d}")

print(f"\n{'='*90}")
print(f"RESOLUTION ANALYSIS")
print(f"{'='*90}")
prev = None
for dt, codes, ones in results:
    if prev is not None:
        changes = []
        for name in ['XCOARSE', 'COARSE', 'FINE']:
            if ones[name] != prev[1][name]:
                changes.append(f"{name}: {prev[1][name]}→{ones[name]}")
        if changes:
            print(f"  ΔT={dt:5d}ps: {', '.join(changes)}")
    prev = (dt, ones)
