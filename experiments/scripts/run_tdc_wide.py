#!/usr/bin/env python3
"""
Wide-range delay-line TDC test.

Two levels:
  MED (1 ns/tap):    20× inv_1 per tap, 16 taps → 0-16 ns range
  COARSE (5 ns/tap): 90× inv_1 per tap, 8 taps  → 0-40 ns range

Delay-line TDC (not Vernier): START goes through delay chain,
STOP goes directly to all DFF data inputs. At each tap, the DFF
clocks when START arrives — if STOP already arrived, Q=1, else Q=0.

  t_pd(inv_1) ≈ 55 ps (from ring osc data: 1.01 GHz / 18 stages)
  20 × 55 ps ≈ 1.1 ns per tap
  90 × 55 ps ≈ 5.0 ns per tap

Simple, few cells, fast sim. Stop chain is just a wire (no cells).
"""
import subprocess
import os

os.chdir('/home/anish/wafer_space_docker_based_starter_kit')

LEVELS = [
    ('MED',     20, 16),   # 20 inv_1 per tap, 16 taps, ~1.1 ns/tap
    ('COARSE',  90, 8),    # 90 inv_1 per tap, 8 taps, ~5 ns/tap
]

def gen_spice(level_config, delta_t_ps):
    name, inv_per_tap, num_taps = level_config
    prefix = name.lower()
    dt_ns = delta_t_ps * 1e-3
    lines = []
    lines.append(f"* {name} delay-line TDC: delta_t={delta_t_ps}ps, {inv_per_tap} inv/tap, {num_taps} taps")
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
    # RN: reset for first 5ns, then release
    lines.append("Vrn RN 0 PULSE(0 5 5n 0.1n 0.1n 500n 1000n)")
    # START: rising edge at t=10ns
    lines.append("Vstart START_IN 0 PULSE(0 5 10n 0.1n 0.1n 500n 1000n)")
    # STOP: rising edge at t=10ns + delta_t
    stop_time = 10.0 + dt_ns
    lines.append(f"Vstop STOP_IN 0 PULSE(0 5 {stop_time}n 0.1n 0.1n 500n 1000n)")
    lines.append("")
    # START delay chain: inv_per_tap × inv_1 per tap, tap output = after inv_per_tap inverters
    # Use even count (pairs) so output is non-inverting
    prev = "START_IN"
    for i in range(num_taps):
        for j in range(inv_per_tap):
            out = f"{prefix}_tap_s{i}" if j == inv_per_tap - 1 else f"{prefix}_s{i}_{j}"
            lines.append(f"Xs_{i}_{j} {prev} {out} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1")
            prev = out
    lines.append("")
    # DFFs: D = STOP_IN (direct, no delay chain), CLK = start_tap[i]
    # When START arrives at tap i, DFF samples: is STOP high yet?
    # Q=1 means STOP arrived first (ΔT < i × tap_delay)
    # Q=0 means START arrived first (ΔT > i × tap_delay)
    for i in range(num_taps):
        lines.append(f"Xdff_{i} STOP_IN RN {prefix}_tap_s{i} {prefix}_q{i} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1")
    lines.append("")
    lines.append(".ic v(START_IN)=0 v(STOP_IN)=0 v(RN)=0")
    lines.append(".options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25")
    lines.append(".control")
    # Sim long enough for all taps to settle
    sim_time = 10.0 + num_taps * inv_per_tap * 0.055 + 10  # 10ns start + delay + margin
    lines.append(f"tran 0.1ns {sim_time:.0f}ns uic")
    meas_time = 10.0 + num_taps * inv_per_tap * 0.055 + 5
    for i in range(num_taps):
        lines.append(f"meas tran {prefix}_q{i}_val FIND v({prefix}_q{i}) AT={meas_time:.0f}n")
    result_str = ' '.join([f"{prefix}_q{i}=$&{prefix}_q{i}_val" for i in range(num_taps)])
    lines.append(f'echo "RESULT {result_str}"')
    lines.append(".endc")
    lines.append(".end")
    return '\n'.join(lines)

# Sweep points: MED (0-16 ns in 1 ns steps), COARSE (0-40 ns in 5 ns steps)
med_sweep = list(range(0, 17000, 1000))      # 0-16 ns, 1 ns steps
coarse_sweep = list(range(0, 45000, 5000))   # 0-40 ns, 5 ns steps

for level_cfg in LEVELS:
    name, inv_per_tap, num_taps = level_cfg
    prefix = name.lower()
    
    if name == 'MED':
        sweep = med_sweep
    else:
        sweep = coarse_sweep

    print(f"\n{'='*70}")
    print(f"{name} TDC: {inv_per_tap} inv_1/tap, {num_taps} taps, ~{inv_per_tap*0.055:.1f} ns/tap")
    print(f"{'='*70}")

    for delta_t in sweep:
        sp_content = gen_spice(level_cfg, delta_t)
        sp_file = f'spice_sim/tdc_wide_{prefix}_{delta_t}ps.sp'
        with open(sp_file, 'w') as f:
            f.write(sp_content)

        print(f"  ΔT={delta_t/1000:6.1f}ns... ", end='', flush=True)
        try:
            result = subprocess.run(
                ['ngspice', '-b', sp_file],
                capture_output=True, text=True, timeout=120
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
                for i in range(num_taps):
                    code += '1' if q_vals.get(i, 0) > 2.5 else '0'
                ones = code.count('1')
                est_ns = ones * inv_per_tap * 0.055
                print(f"{code}  ({ones} ones, ~{est_ns:.1f}ns)")
            else:
                print("FAILED")
        except subprocess.TimeoutExpired:
            print("TIMEOUT")

print("\nDone!")
