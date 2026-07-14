#!/usr/bin/env python3
"""Plot the 3-inverter chain SPICE output."""
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

# ngspice wrdata format: columns of time, val, time, val, ...
data = np.loadtxt('spice_3inv.txt')
t  = data[:, 0] * 1e9      # ns
vin = data[:, 1]
v1  = data[:, 3]
v2  = data[:, 5]
v3  = data[:, 7]

fig, ax = plt.subplots(figsize=(12, 6))
ax.plot(t, vin, 'k-',  linewidth=1, label='vin (input)')
ax.plot(t, v1,   'b-',  linewidth=1.5, label='v(out1) — after inv1')
ax.plot(t, v2,   'r-',  linewidth=1.5, label='v(out2) — after inv2')
ax.plot(t, v3,   'g-',  linewidth=1.5, label='v(out3) — after inv3')

ax.set_xlabel('Time (ns)')
ax.set_ylabel('Voltage (V)')
ax.set_title('3-Inverter Chain — GF180MCU, 5V, 25C, 10pF load/stage')
ax.legend(loc='upper right')
ax.grid(True, alpha=0.3)
ax.set_xlim(0, 3000)
ax.set_ylim(-0.5, 5.5)

# Zoom into first pulse edge
axins = ax.inset_axes([0.55, 0.15, 0.4, 0.4])
axins.plot(t, vin, 'k-',  linewidth=1)
axins.plot(t, v1,   'b-',  linewidth=1.5)
axins.plot(t, v2,   'r-',  linewidth=1.5)
axins.plot(t, v3,   'g-',  linewidth=1.5)
axins.set_xlim(0, 200)
axins.set_ylim(-0.5, 5.5)
axins.set_title('Zoom: first rising edge')
axins.grid(True, alpha=0.3)

fig.tight_layout()
fig.savefig('spice_3inv_plot.png', dpi=150)
print("Saved spice_3inv_plot.png")

# Print summary
print("\n=== Propagation delays ===")
for label, val in [
    ("tpd1_rise (in↑→out1↓)", 4.807013e-08),
    ("tpd1_fall (in↓→out1↑)", 4.723459e-08),
    ("tpd2_rise (in↑→out2↑)", 1.171673e-07),
    ("tpd2_fall (in↓→out2↓)", 1.142460e-07),
    ("tpd3_rise (in↑→out3↓)", 1.842334e-07),
    ("tpd3_fall (in↓→out3↑)", 1.843309e-07),
]:
    print(f"  {label:30s} = {val*1e9:.2f} ns")
print(f"\n  Per-stage delay (avg) ≈ {(1.842334e-07 + 1.843309e-07)/2/3*1e9:.2f} ns")
print(f"  Max freq (3-stage ring) ≈ {1/((1.842334e-07 + 1.843309e-07))*1e6:.2f} MHz")
