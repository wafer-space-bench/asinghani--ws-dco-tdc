#!/usr/bin/env python3
"""Plot the 3-inverter chain SPICE output from the hardened chip."""
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

# ngspice wrdata format: columns of time, val, time, val, ...
data = np.loadtxt('spice_3inv_hardened.txt')
t    = data[:, 0] * 1e9      # ns
vin  = data[:, 1]              # input (after pre-buffer, so this is the buffer output)
vbuf = data[:, 3]              # w_inv1 (buffer output into inv1)
v1   = data[:, 5]              # w_inv2 (inv1 output = inv2 input)
v2   = data[:, 7]              # w_inv3 (inv2 output = inv3 input)
v3   = data[:, 9]              # w_post (inv3 output)
vout = data[:, 11]             # final output (after post-buffers)

fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(14, 10), gridspec_kw={'height_ratios': [2, 1]})

# --- Top plot: full waveforms ---
ax1.plot(t, vin,  'k-',  linewidth=1,   label='vin (input)')
ax1.plot(t, v1,   'b-',  linewidth=1.5, label='v(inv1_out) — after inverter 1')
ax1.plot(t, v2,   'r-',  linewidth=1.5, label='v(inv2_out) — after inverter 2')
ax1.plot(t, v3,   'g-',  linewidth=1.5, label='v(inv3_out) — after inverter 3')
ax1.plot(t, vout, 'm--', linewidth=1,   label='v(out) — after post-buffers')

ax1.set_xlabel('Time (ns)')
ax1.set_ylabel('Voltage (V)')
ax1.set_title('3-Inverter Chain — Extracted from Hardened GF180MCU Chip (5V, 25C, 10pF load)')
ax1.legend(loc='upper right', fontsize=9)
ax1.grid(True, alpha=0.3)
ax1.set_xlim(0, 3000)
ax1.set_ylim(-0.5, 5.5)

# Add annotations for inverter stages
ax1.annotate('inv1 (clkinv_1)', xy=(150, 4.8), fontsize=8, color='blue')
ax1.annotate('inv2 (clkinv_1)', xy=(150, 4.5), fontsize=8, color='red')
ax1.annotate('inv3 (clkinv_2)', xy=(150, 4.2), fontsize=8, color='green')

# --- Bottom plot: zoomed into first rising edge ---
ax2.plot(t, vin,  'k-',  linewidth=1.5, label='vin')
ax2.plot(t, v1,   'b-',  linewidth=1.5, label='v(inv1_out)')
ax2.plot(t, v2,   'r-',  linewidth=1.5, label='v(inv2_out)')
ax2.plot(t, v3,   'g-',  linewidth=1.5, label='v(inv3_out)')

ax2.set_xlabel('Time (ns)')
ax2.set_ylabel('Voltage (V)')
ax2.set_title('Zoom: first rising edge — cascaded inverter delay')
ax2.legend(loc='center right', fontsize=9)
ax2.grid(True, alpha=0.3)
ax2.set_xlim(0, 50)
ax2.set_ylim(-0.5, 5.5)

# Mark the 50% crossing points
ax2.axhline(y=2.5, color='gray', linestyle=':', alpha=0.5)

fig.tight_layout()
fig.savefig('spice_3inv_hardened_plot.png', dpi=150)
print("Saved spice_3inv_hardened_plot.png")

# Print summary
print("\n=== Propagation delays (from hardened chip) ===")
print(f"  tpd_inv1_rise  = {3.875888e-11*1e9:.3f} ns")
print(f"  tpd_inv1_fall  = {8.051425e-10*1e9:.3f} ns")
print(f"  tpd_inv2_rise  = {1.123213e-10*1e9:.3f} ns")
print(f"  tpd_inv2_fall  = {8.811605e-10*1e9:.3f} ns")
print(f"  tpd_inv3_rise  = {2.349856e-10*1e9:.3f} ns")
print(f"  tpd_inv3_fall  = {1.000544e-09*1e9:.3f} ns")
print(f"  tpd_total_rise = {7.856955e-09*1e9:.2f} ns  (input to final output, rising)")
print(f"  tpd_total_fall  = {1.282895e-08*1e9:.2f} ns  (input to final output, falling)")
print(f"\n  Per-inverter avg (rise) = {(3.875888e-11 + 1.123213e-10 + 2.349856e-10)/3*1e9:.3f} ns")
print(f"  Per-inverter avg (fall) = {(8.051425e-10 + 8.811605e-10 + 1.000544e-09)/3*1e9:.3f} ns")
