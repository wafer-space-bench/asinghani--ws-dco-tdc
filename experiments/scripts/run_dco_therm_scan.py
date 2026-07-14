#!/usr/bin/env python3
"""
Scan ring lengths with 33-cell thermometer (2 tunable stages).
Only run codes 0, 16, 32 (min, mid, max) to keep total sims small.
Longer timeout (300s) and coarser timestep (0.5ns).
"""
import subprocess
import os

os.chdir('/home/anish/wafer_space_docker_based_starter_kit')

RING_LENGTHS = [9, 11, 13, 15, 17, 19, 21, 25, 31]
NUM_TUNABLE = 2
TOTAL_CELLS_PER_STAGE = 33
SAMPLE_CODES = [0, 16, 32]

def gen_spice(num_stages, code):
    n_enabled = code + 1
    lines = []
    lines.append(f"* Ring {num_stages} stages, code={code} (en={n_enabled}/33), {NUM_TUNABLE} tunable")
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
            for k in range(TOTAL_CELLS_PER_STAGE):
                en = "EN_on" if k < n_enabled else "EN_off"
                lines.append(f"Xs{s}_{k} {en} {inp} {outp} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1")
        else:
            lines.append(f"Xs{s} VDD {inp} {outp} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1")

    lines.append(".ic v(ring_out)=0V")
    lines.append(".options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25")
    lines.append(".control")
    lines.append("tran 0.5ns 60ns uic")
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

    for code in SAMPLE_CODES:
        sp_content = gen_spice(num_stages, code)
        sp_file = f'spice_sim/dco_scan_{num_stages}st_{code}.sp'
        with open(sp_file, 'w') as f:
            f.write(sp_content)

        n_en = code + 1
        print(f"  Code {code:2d} (en={n_en:2d}/33)...", end=' ', flush=True)
        try:
            result = subprocess.run(
                ['ngspice', '-b', sp_file],
                capture_output=True, text=True, timeout=300
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
