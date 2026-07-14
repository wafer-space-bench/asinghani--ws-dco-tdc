#!/usr/bin/env python3
"""
15-stage ring, 4 tunable stages, 33-cell thermometer, 0.1ns timestep, 200ns tran.
Run codes 0, 16, 28, 32 to find range and check step sizes near 100 MHz.
"""
import subprocess
import os

os.chdir('/home/anish/wafer_space_docker_based_starter_kit')

num_stages = 15
NUM_TUNABLE = 4
TOTAL_CELLS = 33
CODES = [0, 8, 16, 24, 28, 30, 32]

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
    lines.append("tran 0.1ns 200ns uic")
    lines.append("meas tran t_period trig v(ring_out) val=2.5 rise=3 targ v(ring_out) val=2.5 rise=4")
    lines.append('let f_mhz = 1.0 / t_period / 1e6')
    lines.append('echo "RESULT $&f_mhz"')
    lines.append(".endc")
    lines.append(".end")
    return '\n'.join(lines)

for code in CODES:
    sp_content = gen_spice(code)
    sp_file = f'spice_sim/dco_15st_{code}.sp'
    with open(sp_file, 'w') as f:
        f.write(sp_content)

    n_en = code + 1
    print(f"Code {code:2d} (en={n_en:2d}/33)...", end=' ', flush=True)
    try:
        result = subprocess.run(
            ['ngspice', '-b', sp_file],
            capture_output=True, text=True, timeout=900
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
