#!/usr/bin/env python3
"""Plot the 9-stage ring oscillator SPICE output — full swing version."""
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

data = np.loadtxt('spice_ringosc.txt')
t       = data[:, 0] * 1e9    # ns
ven     = data[:, 1]           # enable
vout    = data[:, 3]           # ring_out (unloaded — rail-to-rail)
vnand   = data[:, 5]           # nand_out
vs2     = data[:, 7]           # stage 2
vs5     = data[:, 9]           # stage 5
vs8     = data[:, 11]          # stage 8
vtap    = data[:, 13]          # tap_out (buffered, 10pF load)

t_period = 1.136025e-09
f_osc = 1 / t_period

fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(14, 10), gridspec_kw={'height_ratios': [2, 1.5]})

# --- Top plot: enable + ring output + tap output (full timeline) ---
ax1.plot(t, ven,  'k-',  linewidth=1,   label='enable')
ax1.plot(t, vout, 'b-',  linewidth=1.5, label='ring_out (unloaded — rail-to-rail)')
ax1.plot(t, vtap, 'm--', linewidth=1,   label='tap_out (buf_8 + 10pF load)')
ax1.axvline(x=50, color='gray', linestyle='--', alpha=0.5)
ax1.annotate('enable HIGH\n→ oscillation starts', xy=(50, 4), fontsize=9,
             xytext=(55, 4.2), arrowprops=dict(arrowstyle='->', color='gray'))

ax1.set_xlabel('Time (ns)')
ax1.set_ylabel('Voltage (V)')
ax1.set_title(f'9-Stage Ring Oscillator — GF180MCU, 5V, 25C\n'
              f'Frequency = {f_osc/1e6:.0f} MHz  |  Period = {t_period*1e9:.2f} ns  |  '
              f'Swing = 0–5 V (rail-to-rail)')
ax1.legend(loc='upper right')
ax1.grid(True, alpha=0.3)
ax1.set_xlim(0, 100)
ax1.set_ylim(-0.5, 5.5)

# --- Bottom plot: zoom into oscillation (48-55 ns) ---
mask = (t >= 48) & (t <= 55)
ax2.plot(t[mask], vout[mask], 'b-',  linewidth=1.5, label='ring_out (rail-to-rail)')
ax2.plot(t[mask], vnand[mask], 'r-',  linewidth=1.5, label='nand_out (stage 1)')
ax2.plot(t[mask], vs5[mask],   'g-',  linewidth=1.5, label='stage 5 (mid-ring)')
ax2.plot(t[mask], vs8[mask],   'm-',  linewidth=1.5, label='stage 8')
ax2.plot(t[mask], vtap[mask],  'c--', linewidth=1,   label='tap_out (buffered)')

ax2.set_xlabel('Time (ns)')
ax2.set_ylabel('Voltage (V)')
ax2.set_title('Zoom: steady-state oscillation (48–55 ns) — all stages swing rail-to-rail')
ax2.legend(loc='upper right', fontsize=9)
ax2.grid(True, alpha=0.3)
ax2.set_ylim(-0.5, 5.5)

# Mark one period
mid_t = 51
ax2.annotate('', xy=(mid_t + t_period*1e9, 5.2), xytext=(mid_t, 5.2),
             arrowprops=dict(arrowstyle='<->', color='black', lw=1.5))
ax2.text(mid_t + t_period*1e9/2, 5.3, f'1 period = {t_period*1e9:.2f} ns',
         ha='center', fontsize=9)

fig.tight_layout()
fig.savefig('spice_ringosc_plot.png', dpi=150)
print("Saved spice_ringosc_plot.png")

# Print voltage swing summary
mask = t > 40
print(f"\n=== Ring Oscillator Results (unloaded ring) ===")
print(f"  Frequency:  {f_osc/1e6:.0f} MHz")
print(f"  Period:     {t_period*1e9:.2f} ns")
print(f"  Per-stage:  {t_period/18*1e9:.3f} ns")
print(f"\n  ring_out swing: {vout[mask].min():.2f} – {vout[mask].max():.2f} V")
print(f"  tap_out swing:  {vtap[mask].min():.2f} – {vtap[mask].max():.2f} V (10pF load)")
