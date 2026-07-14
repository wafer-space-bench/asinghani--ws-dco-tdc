#!/usr/bin/env bash
# experiments/scripts/synth_spice.sh - synthesize RTL to SPICE via Yosys
#
# Usage:  bash experiments/scripts/synth_spice.sh
#
# Produces: final/spice/chip_top.synth.spice  (gate-level SPICE, no parasitics)
set -euo pipefail

export MSYS_NO_PATHCONV=1

docker compose run --rm harden bash -lc '
    set -euo pipefail
    git config --global --add safe.directory /work 2>/dev/null || true

    # --- Generate slot defines (same as make defines) ---
    bash scripts/gen_defines.sh

    # --- Yosys synthesis + SPICE write ---
    # Reads the RTL, synthesizes to GF180MCU standard cells, writes a SPICE
    # netlist where each cell is a subcircuit instantiation.
    # The transistor-level cell definitions come from the PDK .spice files
    # (included separately in the testbench).

    yosys -p "
        # Read the standard-cell Liberty (for synthesis mapping)
        read_liberty -lib -ignore_miss_dir -setattr blackbox \
            /pdk/gf180mcuD/libs.ref/gf180mcu_fd_sc_mcu7t5v0/lib/gf180mcu_fd_sc_mcu7t5v0__tt_025C_5v00.lib

        # Read pad-cell Liberty (blackbox)
        read_liberty -lib -ignore_miss_dir -setattr blackbox \
            /pdk/gf180mcuD/libs.ref/gf180mcu_fd_io/lib/gf180mcu_fd_io__tt_025C_5v00.lib

        # Read pad-cell Verilog blackbox (has correct port names matching chip_top.sv)
        read_verilog -sv /pdk/gf180mcuD/libs.ref/gf180mcu_fd_io/verilog/gf180mcu_fd_io__blackbox_pp.v

        # Read wafer.space IP Liberty (blackbox)
        read_liberty -lib -ignore_miss_dir -setattr blackbox \
            /work/ip/gf180mcu_ws_ip__qrcode_id/lib/gf180mcu_ws_ip__qrcode_id.lib
        read_liberty -lib -ignore_miss_dir -setattr blackbox \
            /work/ip/gf180mcu_ws_ip__shuttle_id/lib/gf180mcu_ws_ip__shuttle_id.lib
        read_liberty -lib -ignore_miss_dir -setattr blackbox \
            /work/ip/gf180mcu_ws_ip__project_id/lib/gf180mcu_ws_ip__project_id.lib
        read_liberty -lib -ignore_miss_dir -setattr blackbox \
            /work/ip/gf180mcu_ws_ip__marker/lib/gf180mcu_ws_ip__marker.lib
        read_liberty -lib -ignore_miss_dir -setattr blackbox \
            /work/ip/gf180mcu_ws_ip__logo/lib/gf180mcu_ws_ip__logo.lib

        # Read RTL
        read_verilog -sv -DUSE_POWER_PINS /work/src/chip_top.sv
        read_verilog -sv -DUSE_POWER_PINS /work/src/chip_core.sv

        # Synthesize
        synth -top chip_top -flatten

        # Optimize
        opt
        abc -liberty /pdk/gf180mcuD/libs.ref/gf180mcu_fd_sc_mcu7t5v0/lib/gf180mcu_fd_sc_mcu7t5v0__tt_025C_5v00.lib
        opt

        # Write gate-level Verilog (for reference)
        write_verilog /work/final/spice/chip_top.synth.nl.v

        # Write SPICE netlist
        write_spice -top chip_top /work/final/spice/chip_top.synth.spice
    " 2>&1

    echo ""
    echo "=== Synth-only SPICE netlist written ==="
    wc -l /work/final/spice/chip_top.synth.spice
    echo "Cells used:"
    grep -oP "gf180mcu_fd_sc_mcu7t5v0__\w+" /work/final/spice/chip_top.synth.spice | sort | uniq -c | sort -rn | head -10
'
