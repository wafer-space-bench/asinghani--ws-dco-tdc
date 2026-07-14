#!/usr/bin/env python3
"""
32x thermometer DCO: try multiple ring lengths to find where 100 MHz
lands at high drive codes (where steps are <0.1 MHz).
Tests 11, 13, 15, 17, 19-stage rings, all 33 codes each.
4 tunable stages in each ring.
"""
import subprocess
import os

os.chdir('/home/anish/wafer_space_docker_based_starter_kit')

RING_LENGTHS = [11, 13, 15, 17, 19]
NUM_TUNABLE = 4
TOTAL_CELLS_PER_STAGE = 33

def gen_spice(num_stages, code):
    n_enabled = code + 1
    n_fixed = num_stages - 1 - NUM_TUNABLE  # minus NAND, minus tunable
    lines = []
    lines.append(f"* Ring {num_stages} stages, thermometer code={code} (enabled={n_enabled}/33)")
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

    # Build stage list: stage 0 = NAND (ring0), stages 1..N-1 are inverters
    # Last stage output = ring_out
    # First 4 tunable stages at positions 1,2,3,4; rest fixed
    # Wire naming: ring0 -> r1 -> r2 -> ... -> r{N-2} -> ring_out
    stage_inputs = ['ring0'] + [f'r{i}' for i in range(1, num_stages - 1)]
    stage_outputs = [f'r{i}' for i in range(1, num_stages - 1)] + ['ring_out']

    for s in range(num_stages - 1):  # num_stages-1 inverter stages
        inp = stage_inputs[s]
        outp = stage_outputs[s]
        if s < NUM_TUNABLE:
            # Tunable: 33 invz_1, n_enabled with EN_on, rest with EN_off
            for k in range(TOTAL_CELLS_PER_STAGE):
                en = "EN_on" if k < n_enabled else "EN_off"
                lines.append(f"Xs{s}_{k} {en} {inp} {outp} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1")
        else:
            # Fixed: single invz_1
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

for num_stages in RING_LENGTHS:
    print(f"\n{'='*60}")
    print(f"RING: {num_stages} stages ({num_stages-1-NUM_TUNABLE} fixed + {NUM_TUNABLE} tunable + NAND)")
    print(f"{'='*60}")

    results = []
    for code in range(33):
        sp_content = gen_spice(num_stages, code)
        sp_file = f'/tmp/dco_therm_{num_stages}st_{code}.sp'
        with open(sp_file, 'w') as f:
            f.write(sp_content)

        n_en = code + 1
        print(f"  Code {code:2d} (en={n_en:2d}/33)...", end=' ', flush=True)
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
                        results.append((code, freq))
                        print(f"{freq:.3f} MHz")
                        found = True
                        break
                    except ValueError:
                        pass
            if not found:
                print("FAILED")
                results.append((code, 0))
        except subprocess.TimeoutExpired:
            print("TIMEOUT")
            results.append((code, 0))

    # Summary
    freqs = [f for _, f in results]
    valid = [f for f in freqs if f > 0]
    if valid:
        print(f"\n  Summary: {min(valid):.3f} - {max(valid):.3f} MHz ({max(valid)/min(valid):.2f}x)")
        # Find where 100 MHz is
        for c, f in results:
            if 95 < f < 105:
                # Find step
                if c > 0 and results[c-1][1] > 0:
                    step = f - results[c-1][1]
                    print(f"  ~100 MHz at code {c}: {f:.3f} MHz, step={step:.4f} MHz")

        # Show last 5 codes (finest steps)
        print(f"  Last 5 codes:")
        for c, f in results[-5:]:
            if c > 0 and results[c-1][1] > 0:
                step = f - results[c-1][1]
                print(f"    Code {c}: {f:.3f} MHz, step={step:.4f} MHz")
