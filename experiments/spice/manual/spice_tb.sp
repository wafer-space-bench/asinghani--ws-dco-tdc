* Testbench: measure propagation delay of NOT-gate path through chip_top
* GF180MCU process: 5V supply, typical corner (25C)

* --- PDK model parameters ---
.param fnoicor=0
.param sw_stat_global=0
.param sw_stat_mismatch=0
.param mc_skew=3
.param res_mc_skew=3
.param cap_mc_skew=3

* --- Include PDK model files (preprocessed: .lib/.endl directives removed) ---
.include /home/anish/wafer_space_docker_based_starter_kit/pdk/gf180mcuD/libs.tech/ngspice/design.spice
.include /tmp/sm141064_flat.spice
.include /tmp/smbb000149_flat.spice

* --- Include the extracted netlist (black-box stubs removed) ---
.include final/spice/chip_top_nostubs.spice

* --- Bridge: 2-port endcap (must come BEFORE PDK SPICE so ngspice uses this one) ---
.subckt gf180mcu_fd_sc_mcu7t5v0__endcap VDD VSS
.ends

* --- Include real transistor-level SPICE ---
.include pdk/gf180mcuD/libs.ref/gf180mcu_fd_sc_mcu7t5v0/spice/gf180mcu_fd_sc_mcu7t5v0.spice
.include pdk/gf180mcuD/libs.ref/gf180mcu_fd_io/spice/gf180mcu_fd_io.spice

* --- Power supply: 5V (GF180MCU is a 5V process) ---
VDD_net VDD 0 5.0
VSS_net VSS 0 0

* --- Drive input_PAD[0] with a pulse ---
Vin input_PAD0 0 PWL(0ns 0V 40ns 0V 50ns 5V 140ns 5V 150ns 0V 200ns 0V)

* --- All other input pads tied to 0 ---
Vin1  input_PAD1  0 0
Vin2  input_PAD2  0 0
Vin3  input_PAD3  0 0
Vin4  input_PAD4  0 0
Vin5  input_PAD5  0 0
Vin6  input_PAD6  0 0
Vin7  input_PAD7  0 0
Vin8  input_PAD8  0 0
Vin9  input_PAD9  0 0
Vin10 input_PAD10 0 0
Vin11 input_PAD11 0 0

* --- Clock and reset tied low ---
Vclk  clk_PAD 0 0
Vrst  rst_n_PAD 0 0

* --- Analog pads: tie to 0 ---
Vana0 analog_PAD0 0 0
Vana1 analog_PAD1 0 0

* --- Unused bidir pads: tie to 0 via 1G resistor (avoid floating) ---
Rbidir1  bidir_PAD1  0 1G
Rbidir2  bidir_PAD2  0 1G
Rbidir3  bidir_PAD3  0 1G
Rbidir4  bidir_PAD4  0 1G
Rbidir5  bidir_PAD5  0 1G
Rbidir6  bidir_PAD6  0 1G
Rbidir7  bidir_PAD7  0 1G
Rbidir8  bidir_PAD8  0 1G
Rbidir9  bidir_PAD9  0 1G
Rbidir10 bidir_PAD10 0 1G
Rbidir11 bidir_PAD11 0 1G
Rbidir12 bidir_PAD12 0 1G
Rbidir13 bidir_PAD13 0 1G
Rbidir14 bidir_PAD14 0 1G
Rbidir15 bidir_PAD15 0 1G
Rbidir16 bidir_PAD16 0 1G
Rbidir17 bidir_PAD17 0 1G
Rbidir18 bidir_PAD18 0 1G
Rbidir19 bidir_PAD19 0 1G
Rbidir20 bidir_PAD20 0 1G
Rbidir21 bidir_PAD21 0 1G
Rbidir22 bidir_PAD22 0 1G
Rbidir23 bidir_PAD23 0 1G
Rbidir24 bidir_PAD24 0 1G
Rbidir25 bidir_PAD25 0 1G
Rbidir26 bidir_PAD26 0 1G
Rbidir27 bidir_PAD27 0 1G
Rbidir28 bidir_PAD28 0 1G
Rbidir29 bidir_PAD29 0 1G
Rbidir30 bidir_PAD30 0 1G
Rbidir31 bidir_PAD31 0 1G
Rbidir32 bidir_PAD32 0 1G
Rbidir33 bidir_PAD33 0 1G
Rbidir34 bidir_PAD34 0 1G
Rbidir35 bidir_PAD35 0 1G
Rbidir36 bidir_PAD36 0 1G
Rbidir37 bidir_PAD37 0 1G
Rbidir38 bidir_PAD38 0 1G
Rbidir39 bidir_PAD39 0 1G

* --- Load on bidir_PAD[0]: 10pF ---
Cload bidir_PAD0 0 10p

* --- Instantiate the chip (all nodes on one line to avoid parsing issues) ---
Xchip_top VDD VSS analog_PAD0 analog_PAD1 bidir_PAD0 bidir_PAD10 bidir_PAD11 bidir_PAD12 bidir_PAD13 bidir_PAD14 bidir_PAD15 bidir_PAD16 bidir_PAD17 bidir_PAD18 bidir_PAD19 bidir_PAD1 bidir_PAD20 bidir_PAD21 bidir_PAD22 bidir_PAD23 bidir_PAD24 bidir_PAD25 bidir_PAD26 bidir_PAD27 bidir_PAD28 bidir_PAD29 bidir_PAD2 bidir_PAD30 bidir_PAD31 bidir_PAD32 bidir_PAD33 bidir_PAD34 bidir_PAD35 bidir_PAD36 bidir_PAD37 bidir_PAD38 bidir_PAD39 bidir_PAD3 bidir_PAD4 bidir_PAD5 bidir_PAD6 bidir_PAD7 bidir_PAD8 bidir_PAD9 clk_PAD input_PAD0 input_PAD10 input_PAD11 input_PAD1 input_PAD2 input_PAD3 input_PAD4 input_PAD5 input_PAD6 input_PAD7 input_PAD8 input_PAD9 rst_n_PAD chip_top

* --- Control options ---
.options reltol=1e-3 abstol=1e-12 vntol=1e-4 chgtol=1e-16 method=gear temp=25 gmin=1e-12 rshunt=1e12

.control
* Use uic to skip DC operating point (which doesn't converge)
tran 0.1ns 200ns uic

* Print initial and final values for debugging
echo ""
echo "=== Voltage at key time points ==="
print v(input_PAD0) v(bidir_PAD0)

* Measure propagation delay: rising input -> falling output
meas tran tpd_rise trig v(input_PAD0) val=2.5 rise=1 targ v(bidir_PAD0) val=2.5 fall=1
* Falling input -> rising output
meas tran tpd_fall trig v(input_PAD0) val=2.5 fall=1 targ v(bidir_PAD0) val=2.5 rise=1

* Rise and fall times of output
meas tran t_rise trig v(bidir_PAD0) val=0.5 rise=1 targ v(bidir_PAD0) val=4.5 rise=1
meas tran t_fall trig v(bidir_PAD0) val=4.5 fall=1 targ v(bidir_PAD0) val=0.5 fall=1

* Print all measurements
echo ""
echo "========================================"
echo "  NOT-GATE SPICE RESULTS (GF180MCU, 5V, 25C, 10pF load)"
echo "========================================"
print tpd_rise
print tpd_fall
print t_rise
print t_fall
echo "========================================"
echo ""

* Write data for plotting
wrdata spice_out.txt v(input_PAD0) v(bidir_PAD0)
.endc

.end
