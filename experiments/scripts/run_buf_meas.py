#!/usr/bin/env python3
"""
Measure delay of all GF180MCU buffer and clkbuf cells.
"""
import subprocess
import os

os.chdir('/home/anish/wafer_space_docker_based_starter_kit')

CELLS = [
    'gf180mcu_fd_sc_mcu7t5v0__buf_1',
    'gf180mcu_fd_sc_mcu7t5v0__buf_2',
    'gf180mcu_fd_sc_mcu7t5v0__buf_3',
    'gf180mcu_fd_sc_mcu7t5v0__buf_4',
    'gf180mcu_fd_sc_mcu7t5v0__buf_8',
    'gf180mcu_fd_sc_mcu7t5v0__buf_12',
    'gf180mcu_fd_sc_mcu7t5v0__buf_16',
    'gf180mcu_fd_sc_mcu7t5v0__buf_20',
    'gf180mcu_fd_sc_mcu7t5v0__clkbuf_1',
    'gf180mcu_fd_sc_mcu7t5v0__clkbuf_2',
    'gf180mcu_fd_sc_mcu7t5v0__clkbuf_3',
    'gf180mcu_fd_sc_mcu7t5v0__clkbuf_4',
    'gf180mcu_fd_sc_mcu7t5v0__clkbuf_8',
    'gf180mcu_fd_sc_mcu7t5v0__clkbuf_12',
    'gf180mcu_fd_sc_mcu7t5v0__clkbuf_16',
    'gf180mcu_fd_sc_mcu7t5v0__clkbuf_20',
    # Also include dlyd_4 for comparison
    'gf180mcu_fd_sc_mcu7t5v0__dlyd_4',
]

def gen_spice(cell_name):
    lines = []
    lines.append(f"* Delay measurement: {cell_name}")
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
    lines.append("Vin in 0 PULSE(0 5 5n 0.1n 0.1n 10n 20n)")
    lines.append(f"Xdut in out VDD VDD VSS VSS {cell_name}")
    lines.append(".options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25")
    lines.append(".control")
    lines.append("tran 0.01ns 20ns uic")
    lines.append("meas tran t_delay TRIG v(in) VAL=2.5 RISE=1 TARG v(out) VAL=2.5 RISE=1")
    lines.append('echo "RESULT $&t_delay"')
    lines.append(".endc")
    lines.append(".end")
    return '\n'.join(lines)

print(f"{'Cell':>12} {'Delay (ns)':>12} {'Delay (ps)':>12}")
print(f"{'-'*12} {'-'*12} {'-'*12}")

for cell in CELLS:
    short = cell.replace('gf180mcu_fd_sc_mcu7t5v0__', '')
    sp_content = gen_spice(cell)
    sp_file = f'spice_sim/dly_meas_{short}.sp'
    with open(sp_file, 'w') as f:
        f.write(sp_content)

    try:
        result = subprocess.run(
            ['ngspice', '-b', sp_file],
            capture_output=True, text=True, timeout=30
        )
        output = result.stdout + result.stderr
        delay = None
        for line in output.split('\n'):
            if 'RESULT' in line:
                try:
                    delay = float(line.split()[-1])
                except ValueError:
                    pass
                break
        if delay is not None:
            print(f"{short:>12} {delay*1e9:12.3f} {delay*1e12:12.1f}")
        else:
            print(f"{short:>12} FAILED")
    except subprocess.TimeoutExpired:
        print(f"{short:>12} TIMEOUT")
