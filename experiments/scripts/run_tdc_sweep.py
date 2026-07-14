#!/usr/bin/env python3
"""
Vernier TDC SPICE sweep.

CIRCUIT:
  16-tap Vernier TDC using standard cells.
  - START chain: 2× inv_1 per tap (slow buffer, non-inverting)
  - STOP chain:  2× inv_4 per tap (fast buffer, non-inverting)
  - Each tap has a dffrnq_1 DFF: D = stop_tap[i], CLK = start_tap[i]
  - RN (active-low reset) clears all DFFs before measurement

PRINCIPLE:
  START fires at t=0, STOP fires at t=ΔT.
  START chain delay per tap = 2 × t_pd(inv_1)  (slow)
  STOP chain delay per tap  = 2 × t_pd(inv_4)  (fast)
  
  At tap i:
    START arrives at: i × 2 × t_pd(inv_1)
    STOP arrives at:  ΔT + i × 2 × t_pd(inv_4)

  STOP catches up to START when:
    ΔT + i × 2 × t_pd(inv_4) < i × 2 × t_pd(inv_1)
    ΔT < i × 2 × (t_pd(inv_1) - t_pd(inv_4))

  Before that point: STOP hasn't arrived → DFF samples 0
  After that point:  STOP arrived → DFF samples 1

  Resolution = 2 × (t_pd(inv_1) - t_pd(inv_4))
  The 0→1 boundary in the thermometer code gives the time measurement.

SWEEP:
  ΔT from 0 to 1500 ps in 50 ps steps (31 measurements).
  Read all 16 Q outputs at t=25 ns and print as thermometer code.
"""
import subprocess
import os

os.chdir('/home/anish/wafer_space_docker_based_starter_kit')

NUM_TAPS = 16

def gen_spice(delta_t_ps):
    dt_ns = delta_t_ps * 1e-3
    lines = []
    lines.append(f"* Vernier TDC: delta_t={delta_t_ps}ps")
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
    # RN: active-low reset. 0V for first 5ns, then 5V
    lines.append("Vrn RN 0 PULSE(0 5 5n 0.1n 0.1n 20n 30n)")
    # START: rising edge at t=10ns
    lines.append("Vstart START_IN 0 PULSE(0 5 10n 0.1n 0.1n 10n 30n)")
    # STOP: rising edge at t=10ns + delta_t
    stop_time = 10.0 + dt_ns
    lines.append(f"Vstop STOP_IN 0 PULSE(0 5 {stop_time}n 0.1n 0.1n 10n 30n)")
    lines.append("")
    # START chain: 2× inv_1 per tap (slow, non-inverting buffer)
    prev = "START_IN"
    for i in range(NUM_TAPS):
        mid = f"s{i}m"
        out = f"start_s{i}"
        lines.append(f"Xs_inv_{i}a {prev} {mid} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1")
        lines.append(f"Xs_inv_{i}b {mid} {out} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1")
        prev = out
    lines.append("")
    # STOP chain: 2× inv_4 per tap (fast, non-inverting buffer)
    prev = "STOP_IN"
    for i in range(NUM_TAPS):
        mid = f"p{i}m"
        out = f"stop_s{i}"
        lines.append(f"Xp_inv_{i}a {prev} {mid} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4")
        lines.append(f"Xp_inv_{i}b {mid} {out} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_4")
        prev = out
    lines.append("")
    # DFFs: dffrnq_1  D RN CLK Q VDD VNW VPW VSS
    for i in range(NUM_TAPS):
        lines.append(f"Xdff_{i} stop_s{i} RN start_s{i} q{i} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dffrnq_1")
    lines.append("")
    # Measurement: read all Q values at t=25ns
    lines.append(".ic v(START_IN)=0 v(STOP_IN)=0 v(RN)=0")
    lines.append(".options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25")
    lines.append(".control")
    lines.append("tran 0.01ns 25ns uic")
    # Print all Q values at t=25ns
    for i in range(NUM_TAPS):
        lines.append(f"meas tran q{i}_val FIND v(q{i}) AT=24.5n")
    lines.append('echo "RESULT ' + ' '.join([f'q{i}=$&q{i}_val' for i in range(NUM_TAPS)]) + '"')
    lines.append(".endc")
    lines.append(".end")
    return '\n'.join(lines)


results = []

for delta_t in range(0, 1550, 50):
    sp_content = gen_spice(delta_t)
    sp_file = f'spice_sim/tdc_{delta_t}ps.sp'
    with open(sp_file, 'w') as f:
        f.write(sp_content)

    print(f"ΔT={delta_t:4d} ps... ", end='', flush=True)
    try:
        result = subprocess.run(
            ['ngspice', '-b', sp_file],
            capture_output=True, text=True, timeout=60
        )
        output = result.stdout + result.stderr

        # Parse Q values from RESULT line
        q_vals = {}
        found = False
        for line in output.split('\n'):
            if 'RESULT' in line:
                found = True
                # Parse "q0=4.99e+00 q1=0.00e+00 ..."
                parts = line.split()
                for p in parts:
                    if '=' in p and p.startswith('q'):
                        name, val = p.split('=')
                        try:
                            q_vals[int(name[1:])] = float(val)
                        except ValueError:
                            pass
                break

        if found:
            # Convert to thermometer code (1 if > 2.5V)
            code = ''
            for i in range(NUM_TAPS):
                val = q_vals.get(i, 0)
                code += '1' if val > 2.5 else '0'

            # Count ones (number of taps where STOP arrived before START)
            num_ones = code.count('1')
            num_zeros = code.count('0')
            print(f"{''.join(code)}  ({num_ones} ones, {num_zeros} zeros)")
            results.append((delta_t, code, num_ones))
        else:
            print("FAILED")
            results.append((delta_t, '????', 0))
    except subprocess.TimeoutExpired:
        print("TIMEOUT")
        results.append((delta_t, '????', 0))

# Summary table
print(f"\n{'='*70}")
print(f"VERNIER TDC RESULTS SUMMARY")
print(f"{'='*70}")
print(f"{'ΔT (ps)':>8} {'Thermometer Code (q0..q15)':>20} {'#ones':>6} {'Est. ΔT (ps)':>13}")
print(f"{'-'*8} {'-'*20} {'-'*6} {'-'*13}")
for dt, code, ones in results:
    print(f"{dt:8d} {code:20s} {ones:6d}")

# Try to estimate resolution
print(f"\n{'='*70}")
print(f"RESOLUTION ANALYSIS")
print(f"{'='*70}")
prev_ones = None
for dt, code, ones in results:
    if prev_ones is not None and ones != prev_ones:
        print(f"  ΔT={dt:4d}ps: code changed from {prev_ones} to {ones} ones")
    prev_ones = ones
