#!/usr/bin/env python3
"""Run synth-only transistor-level SPICE sweeps for the integrated DCO cores.

This instantiates the same GF180MCU structural cells used in chip_core.sv,
including their real PDK transistor subcircuits. It intentionally bypasses the
pad wrapper and synthesized control-register primitives so the two ring loops
can be measured directly.
"""

import os
import subprocess


ROOT = "/home/anish/wafer_space_docker_based_starter_kit"
SIM_DIR = f"{ROOT}/spice_sim"


HEADER = """* Integrated prototype DCO core sweep: {name}
.param fnoicor=0
.param sw_stat_global=0
.param sw_stat_mismatch=0
.param mc_skew=3
.param res_mc_skew=3
.param cap_mc_skew=3
.include {root}/pdk/gf180mcuD/libs.tech/ngspice/design.ngspice
.include {root}/spice_sim/sm141064_typical.spice
.include {root}/spice_sim/smbb000149_typical.spice
.include {root}/pdk/gf180mcuD/libs.ref/gf180mcu_fd_sc_mcu7t5v0/spice/gf180mcu_fd_sc_mcu7t5v0.spice
VDD_net VDD 0 5.0
VSS_net VSS 0 0
Ven enable 0 5.0
Vfine0 fine0 0 {fine0}
Vfine1 fine1 0 {fine1}
Vfine2 fine2 0 {fine2}
Vfine3 fine3 0 {fine3}
Vcoarse0 coarse0 0 {coarse0}
Vcoarse1 coarse1 0 {coarse1}
Vcoarse2 coarse2 0 {coarse2}
Vcoarse3 coarse3 0 {coarse3}
"""


def bits(value):
    return [(value >> i) & 1 for i in range(4)]


def tunable_stage(prefix, src, dst, coarse, slow=False):
    """Emit one ring stage matching dco_tunable_stage or dco_slow_tunable_stage."""
    lines = []
    if slow:
        lines.append(f"X{prefix}_fixed_delay {src} {prefix}_d0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4")
        lines.append(f"X{prefix}_extra_delay {prefix}_d0 {prefix}_d1 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4")
        lines.append(f"X{prefix}_mux {prefix}_d0 {prefix}_d1 {coarse} {prefix}_in VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__mux2_1")
    else:
        lines.append(f"X{prefix}_delay {src} {prefix}_d VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4")
        lines.append(f"X{prefix}_mux {src} {prefix}_d {coarse} {prefix}_in VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__mux2_1")
    lines.append(f"X{prefix}_base VDD {prefix}_in {dst} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1")
    lines.append(f"X{prefix}_drv1 fine0 {prefix}_in {dst} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_1")
    lines.append(f"X{prefix}_drv2 fine1 {prefix}_in {dst} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_2")
    lines.append(f"X{prefix}_drv4 fine2 {prefix}_in {dst} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_4")
    lines.append(f"X{prefix}_drv8 fine3 {prefix}_in {dst} VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__invz_8")
    return lines


def fast_ring():
    lines = ["Xnand enable out ring0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__nand2_1"]
    lines += tunable_stage("s0", "ring0", "ring1", "coarse0")
    lines.append("Xs1 ring1 ring2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1")
    lines += tunable_stage("s2", "ring2", "ring3", "coarse1")
    lines.append("Xs3 ring3 ring4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1")
    lines += tunable_stage("s4", "ring4", "ring5", "coarse2")
    lines += tunable_stage("s5", "ring5", "out", "coarse3")
    return "\n".join(lines)


def slow_ring():
    lines = ["Xnand enable out ring0 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__nand2_1"]
    lines += tunable_stage("s0", "ring0", "ring1", "coarse0", slow=True)
    lines.append("Xs1d ring1 s1_delay VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4")
    lines.append("Xs1i s1_delay ring2 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1")
    lines += tunable_stage("s2", "ring2", "ring3", "coarse1", slow=True)
    lines.append("Xs3d ring3 s3_delay VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4")
    lines.append("Xs3i s3_delay ring4 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1")
    lines += tunable_stage("s4", "ring4", "ring5", "coarse2", slow=True)
    lines.append("Xs5d ring5 s5_delay VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4")
    lines.append("Xs5i s5_delay ring6 VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1")
    lines += tunable_stage("s6", "ring6", "ring7", "coarse3", slow=True)
    lines.append("Xs7d ring7 s7_delay VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__dlyd_4")
    lines.append("Xs7i s7_delay out VDD VDD VSS VSS gf180mcu_fd_sc_mcu7t5v0__inv_1")
    return "\n".join(lines)


def deck(name, kind, fine, coarse):
    fine_bits = bits(fine)
    coarse_bits = bits(coarse)
    body = fast_ring() if kind == "fast" else slow_ring()
    stop = "200n" if kind == "fast" else "1u"
    step = "0.02n" if kind == "fast" else "0.1n"
    return HEADER.format(
        name=name,
        root=ROOT,
        fine0=fine_bits[0] * 5,
        fine1=fine_bits[1] * 5,
        fine2=fine_bits[2] * 5,
        fine3=fine_bits[3] * 5,
        coarse0=coarse_bits[0] * 5,
        coarse1=coarse_bits[1] * 5,
        coarse2=coarse_bits[2] * 5,
        coarse3=coarse_bits[3] * 5,
    ) + "\n" + body + f"""
.ic v(out)=0
.options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25
.control
tran {step} {stop} uic
meas tran t_period trig v(out) val=2.5 rise=5 targ v(out) val=2.5 rise=6
let f_mhz = 1.0 / t_period / 1e6
echo "RESULT $&f_mhz"
.endc
.end
"""


def run_case(name, kind, fine, coarse):
    path = f"{SIM_DIR}/{name}.sp"
    with open(path, "w") as handle:
        handle.write(deck(name, kind, fine, coarse))
    result = subprocess.run(["ngspice", "-b", path], capture_output=True, text=True, timeout=180)
    text = result.stdout + result.stderr
    for line in text.splitlines():
        if "RESULT" in line:
            try:
                return float(line.split()[-1])
            except ValueError:
                pass
    return None


os.makedirs(SIM_DIR, exist_ok=True)

cases = [
    ("dco1_fine0_coarse0", "fast", 0, 0),
    ("dco1_fine15_coarse0", "fast", 15, 0),
    ("dco1_fine15_coarse1", "fast", 15, 1),
    ("dco1_fine15_coarse15", "fast", 15, 15),
    ("dco2_fine0_coarse0", "slow", 0, 0),
    ("dco2_fine15_coarse0", "slow", 15, 0),
    ("dco2_fine15_coarse15", "slow", 15, 15),
]

print("Integrated DCO synth-only structural SPICE sweep")
print(f"{'Case':<26} {'Fine':>4} {'Coarse':>6} {'Frequency (MHz)':>17}")
print("-" * 60)
for name, kind, fine, coarse in cases:
    frequency = run_case(name, kind, fine, coarse)
    rendered = f"{frequency:.3f}" if frequency is not None else "FAILED"
    print(f"{name:<26} {fine:>4} {coarse:>6} {rendered:>17}")
