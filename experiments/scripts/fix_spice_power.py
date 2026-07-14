#!/usr/bin/env python3
"""
Post-process Yosys write_spice output to add power/ground pins.

Yosys write_spice emits only signal pins for each cell instance, but the
PDK's transistor-level SPICE subcircuits expect VDD VNW VPW VSS as well.
This script adds those pins (VDD VDD VSS VSS — VNW=VDD, VPW=VSS for
the gf180mcu_fd_sc_mcu7t5v0 library).

Also wraps the pad-cell instances similarly (they need DVDD DVSS VDD VSS).
"""
import re
import sys

# Standard cells: signal pins + VDD VNW VPW VSS
STD_CELL_PREFIX = "gf180mcu_fd_sc_mcu7t5v0__"
STD_CELL_SUFFIX = " VDD VDD VSS VSS"

# Pad cells: signal pins + DVDD DVSS VDD VSS (for gf180mcu_fd_io)
PAD_CELL_PREFIX = "gf180mcu_fd_io__"
PAD_CELL_SUFFIX = " VDD VSS VDD VSS"

def process_line(line):
    """Add power pins to cell instances that are missing them."""
    # Match: X<num> <nodes...> <cell_name>
    m = re.match(r'^(X\S+\s+.+?\s+)(\S+)$', line)
    if not m:
        return line

    prefix, cell_name = m.group(1), m.group(2)

    if cell_name.startswith(STD_CELL_PREFIX):
        # Already has power pins? Check if VDD is in the node list
        nodes = prefix.split()
        if 'VDD' in nodes and 'VSS' in nodes:
            return line  # already has power
        return f"{prefix}{STD_CELL_SUFFIX} {cell_name}\n"

    elif cell_name.startswith(PAD_CELL_PREFIX):
        nodes = prefix.split()
        if 'DVDD' in nodes:
            return line  # already has power
        return f"{prefix}{PAD_CELL_SUFFIX} {cell_name}\n"

    return line

def main():
    infile = sys.argv[1] if len(sys.argv) > 1 else "final/spice/chip_top.synth.spice"
    outfile = infile.replace(".spice", ".fixed.spice")

    with open(infile) as f:
        lines = f.readlines()

    out = []
    for line in lines:
        if line.startswith('X') and not line.startswith('X0 ') == False:
            # Check if this is a cell instance (not a subcircuit def line)
            stripped = line.strip()
            if stripped.startswith('X') and not stripped.startswith('.'):
                # Check if the last token is a known cell
                parts = stripped.split()
                if parts and (parts[-1].startswith(STD_CELL_PREFIX) or
                              parts[-1].startswith(PAD_CELL_PREFIX)):
                    line = process_line(line)
        out.append(line)

    with open(outfile, 'w') as f:
        f.writelines(out)

    print(f"Processed {len(lines)} lines -> {outfile}")

if __name__ == "__main__":
    main()
