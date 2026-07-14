#!/usr/bin/env python3
"""
3-Level TDC using proper delay cells.

  FINE:     Vernier — START: 2×inv_1, STOP: 2×inv_4 (~50 ps/tap, 16 taps)
  COARSE:   Delay-line — 1×dlyd_4 per tap (~1.2 ns/tap, 16 taps)
  XCOARSE:  Delay-line — 4×dlyd_4 per tap (~4.9 ns/tap, 8 taps)

FINE uses Vernier (two delay chains) for sub-ns resolution.
COARSE and XCOARSE use delay-line (START delayed, STOP direct to DFF data).

Sweep:
  0-400 ps:   50 ps steps   (FINE region)
  0.5-20 ns:  1 ns steps    (COARSE region)
  20-40 ns:   5 ns steps    (XCOARSE region)
"""
import subprocess
import os

os.chdir('/home/anish/wafer_space_docker_based_starter_kit')

NUM_FINE_TAPS = 16
NUM_COARSE_TAPS = 16
NUM_XCOARSE_TAPS = 8

def gen_fine_spice(delta_t_ps):
    """Vernier TDC: START=2×inv_1, STOP=2×inv_4"""
    prefix = 'fine'
    dt_ns = delta_t_ps * 1e-3
    lines = []
    lines.append(f"* FINE Vernier TDC: delta_t={delta_t_ps}ps")
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
    lines.append("Vrn RN 0 PULSE(0 5 5n 0.1n 0.1n 500n 1000n)")
    lines.append("Vstart START_IN 0 PULSE(0 5 10n 0.1n 0.1n 500n 1000n)")
    stop_time = 10.0 + dt_ns
    lines.append(f"Vstop STOP_IN 0 PULSE(0 5 {stop_time}n 0.1n 0.1n 500n 1000n)")
    lines.append("")
    # START chain: 2×inv_1 per tap (slow)
    prev = "START_IN"
    for i in range(NUM_FINE_TAPS):
        mid = f"{prefix}_s{i}m"
        out = f"{prefix}_start_s{i}"
        lines.append(f"Xs_{i}a {prev} {mid} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1")
        lines.append(f"Xs_{i}b {mid} {out} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1")
        prev = out
    # STOP chain: 2×inv_4 per tap (fast)
    prev = "STOP_IN"
    for i in range(NUM_FINE_TAPS):
        mid = f"{prefix}_p{i}m"
        out = f"{prefix}_stop_s{i}"
        lines.append(f"Xp_{i}a {prev} {mid} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4")
        lines.append(f"Xp_{i}b {mid} {out} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4")
        prev = out
    # DFFs: D=stop, CLK=start
    for i in range(NUM_FINE_TAPS):
        lines.append(f"Xdff_{i} {prefix}_stop_s{i} RN {prefix}_start_s{i} {prefix}_q{i} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1")
    lines.append("")
    lines.append(".ic v(START_IN)=0 v(STOP_IN)=0 v(RN)=0")
    lines.append(".options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25")
    lines.append(".control")
    lines.append("tran 0.01ns 20ns uic")
    for i in range(NUM_FINE_TAPS):
        lines.append(f"meas tran {prefix}_q{i}_val FIND v({prefix}_q{i}) AT=18n")
    result_str = ' '.join([f"{prefix}_q{i}=$&{prefix}_q{i}_val" for i in range(NUM_FINE_TAPS)])
    lines.append(f'echo "RESULT {result_str}"')
    lines.append(".endc")
    lines.append(".end")
    return '\n'.join(lines)

def gen_delayline_spice(name, num_taps, dlyd_count, delta_t_ps):
    """Delay-line TDC: START goes through dlyd_4 chain, STOP direct to DFF data."""
    prefix = name.lower()
    dt_ns = delta_t_ps * 1e-3
    lines = []
    lines.append(f"* {name} delay-line TDC: delta_t={delta_t_ps}ps, {dlyd_count}x dlyd_4/tap")
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
    lines.append("Vrn RN 0 PULSE(0 5 5n 0.1n 0.1n 500n 1000n)")
    lines.append("Vstart START_IN 0 PULSE(0 5 10n 0.1n 0.1n 500n 1000n)")
    stop_time = 10.0 + dt_ns
    lines.append(f"Vstop STOP_IN 0 PULSE(0 5 {stop_time}n 0.1n 0.1n 500n 1000n)")
    lines.append("")
    # START delay chain: dlyd_count × dlyd_4 per tap
    prev = "START_IN"
    for i in range(num_taps):
        for j in range(dlyd_count):
            out = f"{prefix}_tap_s{i}" if j == dlyd_count - 1 else f"{prefix}_s{i}_{j}"
            lines.append(f"Xs_{i}_{j} {prev} {out} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4")
            prev = out
    lines.append("")
    # DFFs: D=STOP_IN (direct), CLK=start_tap[i]
    for i in range(num_taps):
        lines.append(f"Xdff_{i} STOP_IN RN {prefix}_tap_s{i} {prefix}_q{i} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1")
    lines.append("")
    lines.append(".ic v(START_IN)=0 v(STOP_IN)=0 v(RN)=0")
    lines.append(".options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25")
    # Sim time: 10ns start + num_taps * dlyd_count * 1.23ns + margin
    tap_delay_ns = dlyd_count * 1.23
    total_delay_ns = num_taps * tap_delay_ns
    sim_time = 10.0 + total_delay_ns + 5
    meas_time = 10.0 + total_delay_ns + 2
    lines.append(".control")
    lines.append(f"tran 0.1ns {sim_time:.0f}ns uic")
    for i in range(num_taps):
        lines.append(f"meas tran {prefix}_q{i}_val FIND v({prefix}_q{i}) AT={meas_time:.0f}n")
    result_str = ' '.join([f"{prefix}_q{i}=$&{prefix}_q{i}_val" for i in range(num_taps)])
    lines.append(f'echo "RESULT {result_str}"')
    lines.append(".endc")
    lines.append(".end")
    return '\n'.join(lines)

def run_sim(sp_file):
    try:
        result = subprocess.run(
            ['ngspice', '-b', sp_file],
            capture_output=True, text=True, timeout=120
        )
        output = result.stdout + result.stderr
        return output
    except subprocess.TimeoutExpired:
        return None

def parse_result(output, prefix, num_taps):
    if output is None:
        return None, 0
    q_vals = {}
    for line in output.split('\n'):
        if 'RESULT' in line:
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
    code = ''
    for i in range(num_taps):
        code += '1' if q_vals.get(i, 0) > 2.5 else '0'
    return code, code.count('1')

# Sweep points
fine_sweep = list(range(0, 450, 50))          # 0-400 ps, 50 ps steps
coarse_sweep = list(range(500, 20500, 1000))  # 0.5-20 ns, 1 ns steps
xcoarse_sweep = list(range(20000, 45000, 5000))  # 20-40 ns, 5 ns steps

results = []

# Run FINE sweep
print(f"\n{'='*70}")
print(f"FINE: Vernier (2×inv_1 vs 2×inv_4), 16 taps, ~50 ps/tap")
print(f"{'='*70}")
for dt in fine_sweep:
    sp = gen_fine_spice(dt)
    sp_file = f'spice_sim/tdc3d_fine_{dt}ps.sp'
    with open(sp_file, 'w') as f:
        f.write(sp)
    output = run_sim(sp_file)
    code, ones = parse_result(output, 'fine', NUM_FINE_TAPS)
    print(f"  ΔT={dt:5d}ps  {code}  ({ones} ones)")
    results.append((dt, 'FINE', code, ones))

# Run COARSE sweep
print(f"\n{'='*70}")
print(f"COARSE: Delay-line (1×dlyd_4/tap), 16 taps, ~1.2 ns/tap")
print(f"{'='*70}")
for dt in coarse_sweep:
    sp = gen_delayline_spice('COARSE', NUM_COARSE_TAPS, 1, dt)
    sp_file = f'spice_sim/tdc3d_coarse_{dt}ps.sp'
    with open(sp_file, 'w') as f:
        f.write(sp)
    output = run_sim(sp_file)
    code, ones = parse_result(output, 'coarse', NUM_COARSE_TAPS)
    print(f"  ΔT={dt/1000:6.1f}ns  {code}  ({ones} ones)")
    results.append((dt, 'COARSE', code, ones))

# Run XCOARSE sweep
print(f"\n{'='*70}")
print(f"XCOARSE: Delay-line (4×dlyd_4/tap), 8 taps, ~4.9 ns/tap")
print(f"{'='*70}")
for dt in xcoarse_sweep:
    sp = gen_delayline_spice('XCOARSE', NUM_XCOARSE_TAPS, 4, dt)
    sp_file = f'spice_sim/tdc3d_xcoarse_{dt}ps.sp'
    with open(sp_file, 'w') as f:
        f.write(sp)
    output = run_sim(sp_file)
    code, ones = parse_result(output, 'xcoarse', NUM_XCOARSE_TAPS)
    print(f"  ΔT={dt/1000:6.1f}ns  {code}  ({ones} ones)")
    results.append((dt, 'XCOARSE', code, ones))

# Summary
print(f"\n{'='*90}")
print(f"3-LEVEL TDC SUMMARY (with delay cells)")
print(f"{'='*90}")
print(f"{'ΔT':>8} {'Level':>8} {'Code':>20} {'#ones':>6} {'Est. ΔT':>10}")
print(f"{'-'*8} {'-'*8} {'-'*20} {'-'*6} {'-'*10}")
for dt, level, code, ones in results:
    if level == 'FINE':
        est = f"~{ones*50}ps"
    elif level == 'COARSE':
        est = f"~{ones*1.2:.1f}ns"
    else:
        est = f"~{ones*4.9:.1f}ns"
    dt_str = f"{dt/1000:.1f}ns" if dt >= 1000 else f"{dt}ps"
    print(f"{dt_str:>8} {level:>8} {code:>20} {ones:>6} {est:>10}")
