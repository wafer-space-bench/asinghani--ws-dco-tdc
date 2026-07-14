#!/usr/bin/env python3
"""
11 and 13-stage rings with ALTERNATING tunable/fixed stages.
9-stage alternating gave 107-141 MHz.
11-stage alternating should give ~87-115 MHz (100 MHz in range).
13-stage alternating should give ~74-98 MHz.
Only run 7 sample codes to keep it fast.
"""
import subprocess
import os

os.chdir('/home/anish/wafer_space_docker_based_starter_kit')

NUM_TUNABLE = 4
TOTAL_CELLS = 33
SAMPLE_CODES = [0, 8, 16, 24, 28, 30, 32]

def gen_spice(num_stages, code):
    n_enabled = code + 1
    lines = []
    lines.append(f"* Ring {num_stages} stages ALT, code={code} (en={n_enabled}/33)")
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

    n_inv = num_stages - 1  # inverter stages
    stage_inputs = ['ring0'] + [f'r{i}' for i in range(1, n_inv - 1)] + ['ring_out']
    stage_outputs = [f'r{i}' for i in range(1, n_inv - 1)] + ['ring_out']

    sigs = ['ring0'] + [f'r{i}' for i in range(1, n_inv)] + ['ring_out']

    # Alternate: tunable at even indices 0,2,4,6, fixed at odd indices
    # This matches 9-stage layout: tunable at stages 2,4,6,8 (0-indexed: 1,3,5,7)
    tunable_indices = set()
    t_idx = 0
    for i in range(n_inv):
        if t_idx < NUM_TUNABLE and i % 2 == 1:  # odd indices = tunable
            tunable_indices.add(i)
            t_idx += 1

    for s in range(n_inv):
        inp = sigs[s]
        outp = sigs[s + 1]
        if s in tunable_indices:
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

for num_stages in [11, 13]:
    print(f"\n{'='*60}")
    print(f"RING: {num_stages} stages (alternating tunable/fixed)")
    print(f"{'='*60}")

    for code in SAMPLE_CODES:
        sp_content = gen_spice(num_stages, code)
        sp_file = f'spice_sim/dco_alt_{num_stages}st_{code}.sp'
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
                        print(f"{freq:.3f} MHz")
                        found = True
                        break
                    except ValueError:
                        pass
            if not found:
                print("FAILED")
        except subprocess.TimeoutExpired:
            print("TIMEOUT")

print("\nDone!")
