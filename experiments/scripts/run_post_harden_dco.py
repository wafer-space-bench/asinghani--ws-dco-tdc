#!/usr/bin/env python3
"""Attempt a transistor-level post-harden DCO simulation from Magic extraction.

The complete extracted die is intentionally simulated here, including the pad
ring and extracted interconnect. DCO tuning registers are held in their reset
state, so both rings run with fine=0 and coarse=0. This is much heavier than
run_final_dco_spice.py and serves as a post-PnR sanity check.
"""

import re
import subprocess


ROOT = "/home/anish/wafer_space_docker_based_starter_kit"
NETLIST = f"{ROOT}/final/spice/chip_top_nostubs.spice"
DECK = f"{ROOT}/spice_sim/post_harden_dco.sp"


def top_ports():
    lines = open(NETLIST, encoding="utf-8").read().splitlines()
    for index, line in enumerate(lines):
        if line.lower().startswith(".subckt chip_top "):
            joined = line
            current = index + 1
            while current < len(lines) and lines[current].startswith("+"):
                joined += " " + lines[current][1:]
                current += 1
            return joined.split()[2:]
    raise RuntimeError("chip_top port list not found")


ports = top_ports()
input_nodes = {f"input_PAD[{index}]": "0" for index in range(12)}
input_nodes["input_PAD[0]"] = "PWL(0n 0 15n 0 20n 5 150n 5)"  # DCO1 enable
input_nodes["input_PAD[1]"] = "PWL(0n 0 15n 0 20n 5 150n 5)"  # DCO2 enable
input_nodes["rst_n_PAD"] = "PWL(0n 0 2n 0 3n 5 150n 5)"       # clear DFFs
input_nodes["clk_PAD"] = "0"

lines = [
    "* Post-harden full-chip DCO check from Magic extraction",
    ".param fnoicor=0",
    ".param sw_stat_global=0",
    ".param sw_stat_mismatch=0",
    ".param mc_skew=3",
    ".param res_mc_skew=3",
    ".param cap_mc_skew=3",
    "* Magic extracted a two-port endcap; bridge its PDK four-port definition.",
    ".subckt gf180mcu_fd_sc_mcu7t5v0__endcap VDD VSS",
    ".ends gf180mcu_fd_sc_mcu7t5v0__endcap",
    "* Wafer-space ID macros have no transistor-level behavior needed here.",
    ".subckt gf180mcu_ws_ip__qrcode_id",
    ".ends gf180mcu_ws_ip__qrcode_id",
    ".subckt gf180mcu_ws_ip__shuttle_id",
    ".ends gf180mcu_ws_ip__shuttle_id",
    ".subckt gf180mcu_ws_ip__project_id",
    ".ends gf180mcu_ws_ip__project_id",
    ".subckt gf180mcu_ws_ip__marker",
    ".ends gf180mcu_ws_ip__marker",
    ".subckt gf180mcu_ws_ip__logo",
    ".ends gf180mcu_ws_ip__logo",
    f".include {ROOT}/pdk/gf180mcuD/libs.tech/ngspice/design.ngspice",
    f".include {ROOT}/spice_sim/sm141064_typical.spice",
    f".include {ROOT}/spice_sim/smbb000149_typical.spice",
    f".include {ROOT}/pdk/gf180mcuD/libs.ref/gf180mcu_fd_sc_mcu7t5v0/spice/gf180mcu_fd_sc_mcu7t5v0.spice",
    f".include {ROOT}/pdk/gf180mcuD/libs.ref/gf180mcu_fd_io/spice/gf180mcu_fd_io.spice",
    f".include {NETLIST}",
    "VDD_source VDD 0 5.0",
    "VSS_source VSS 0 0",
]

source_number = 0
for node, value in input_nodes.items():
    lines.append(f"Vin_{source_number} {node} 0 {value}")
    source_number += 1

# Bias unused analog/bidir pads weakly so no package pin is left singular.
for index in range(2):
    lines.append(f"Rana_{index} analog_PAD[{index}] 0 1G")
for index in range(40):
    lines.append(f"Rbidir_{index} bidir_PAD[{index}] 0 1G")

lines += [
    "Xchip " + " ".join(ports) + " chip_top",
    ".ic v(bidir_PAD[0])=0 v(bidir_PAD[3])=0",
    ".options reltol=3e-3 abstol=1e-11 vntol=1e-3 chgtol=1e-15 method=gear gmin=1e-12 rshunt=1e12 temp=25",
    ".control",
    "tran 0.2n 150n uic",
    "meas tran dco1_period trig v(bidir_PAD[0]) val=2.5 rise=5 targ v(bidir_PAD[0]) val=2.5 rise=6",
    "meas tran dco2_period trig v(bidir_PAD[3]) val=2.5 rise=3 targ v(bidir_PAD[3]) val=2.5 rise=4",
    "let dco1_mhz = 1.0 / dco1_period / 1e6",
    "let dco2_mhz = 1.0 / dco2_period / 1e6",
    "echo \"RESULT_DCO1_MHZ $&dco1_mhz\"",
    "echo \"RESULT_DCO2_MHZ $&dco2_mhz\"",
    ".endc",
    ".end",
]

with open(DECK, "w", encoding="utf-8") as handle:
    handle.write("\n".join(lines) + "\n")

print(f"Generated {DECK} with {len(ports)} chip_top ports")
result = subprocess.run(["ngspice", "-b", DECK], capture_output=True, text=True, timeout=1800)
output = result.stdout + result.stderr
for line in output.splitlines():
    if "RESULT_DCO" in line or "error" in line.lower() or "fatal" in line.lower():
        print(line)
print(f"ngspice exit code: {result.returncode}")
