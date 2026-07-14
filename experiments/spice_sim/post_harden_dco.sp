* Post-harden full-chip DCO check from Magic extraction
.param fnoicor=0
.param sw_stat_global=0
.param sw_stat_mismatch=0
.param mc_skew=3
.param res_mc_skew=3
.param cap_mc_skew=3
* Magic extracted a two-port endcap; bridge its PDK four-port definition.
.subckt gf180mcu_fd_sc_mcu7t5v0__endcap VDD VSS
.ends gf180mcu_fd_sc_mcu7t5v0__endcap
* Wafer-space ID macros have no transistor-level behavior needed here.
.subckt gf180mcu_ws_ip__qrcode_id
.ends gf180mcu_ws_ip__qrcode_id
.subckt gf180mcu_ws_ip__shuttle_id
.ends gf180mcu_ws_ip__shuttle_id
.subckt gf180mcu_ws_ip__project_id
.ends gf180mcu_ws_ip__project_id
.subckt gf180mcu_ws_ip__marker
.ends gf180mcu_ws_ip__marker
.subckt gf180mcu_ws_ip__logo
.ends gf180mcu_ws_ip__logo
.include /home/anish/wafer_space_docker_based_starter_kit/pdk/gf180mcuD/libs.tech/ngspice/design.ngspice
.include /home/anish/wafer_space_docker_based_starter_kit/spice_sim/sm141064_typical.spice
.include /home/anish/wafer_space_docker_based_starter_kit/spice_sim/smbb000149_typical.spice
.include /home/anish/wafer_space_docker_based_starter_kit/pdk/gf180mcuD/libs.ref/gf180mcu_fd_sc_mcu7t5v0/spice/gf180mcu_fd_sc_mcu7t5v0.spice
.include /home/anish/wafer_space_docker_based_starter_kit/pdk/gf180mcuD/libs.ref/gf180mcu_fd_io/spice/gf180mcu_fd_io.spice
.include /home/anish/wafer_space_docker_based_starter_kit/final/spice/chip_top_nostubs.spice
VDD_source VDD 0 5.0
VSS_source VSS 0 0
Vin_0 input_PAD[0] 0 PWL(0n 0 15n 0 20n 5 150n 5)
Vin_1 input_PAD[1] 0 PWL(0n 0 15n 0 20n 5 150n 5)
Vin_2 input_PAD[2] 0 0
Vin_3 input_PAD[3] 0 0
Vin_4 input_PAD[4] 0 0
Vin_5 input_PAD[5] 0 0
Vin_6 input_PAD[6] 0 0
Vin_7 input_PAD[7] 0 0
Vin_8 input_PAD[8] 0 0
Vin_9 input_PAD[9] 0 0
Vin_10 input_PAD[10] 0 0
Vin_11 input_PAD[11] 0 0
Vin_12 rst_n_PAD 0 PWL(0n 0 2n 0 3n 5 150n 5)
Vin_13 clk_PAD 0 0
Rana_0 analog_PAD[0] 0 1G
Rana_1 analog_PAD[1] 0 1G
Rbidir_0 bidir_PAD[0] 0 1G
Rbidir_1 bidir_PAD[1] 0 1G
Rbidir_2 bidir_PAD[2] 0 1G
Rbidir_3 bidir_PAD[3] 0 1G
Rbidir_4 bidir_PAD[4] 0 1G
Rbidir_5 bidir_PAD[5] 0 1G
Rbidir_6 bidir_PAD[6] 0 1G
Rbidir_7 bidir_PAD[7] 0 1G
Rbidir_8 bidir_PAD[8] 0 1G
Rbidir_9 bidir_PAD[9] 0 1G
Rbidir_10 bidir_PAD[10] 0 1G
Rbidir_11 bidir_PAD[11] 0 1G
Rbidir_12 bidir_PAD[12] 0 1G
Rbidir_13 bidir_PAD[13] 0 1G
Rbidir_14 bidir_PAD[14] 0 1G
Rbidir_15 bidir_PAD[15] 0 1G
Rbidir_16 bidir_PAD[16] 0 1G
Rbidir_17 bidir_PAD[17] 0 1G
Rbidir_18 bidir_PAD[18] 0 1G
Rbidir_19 bidir_PAD[19] 0 1G
Rbidir_20 bidir_PAD[20] 0 1G
Rbidir_21 bidir_PAD[21] 0 1G
Rbidir_22 bidir_PAD[22] 0 1G
Rbidir_23 bidir_PAD[23] 0 1G
Rbidir_24 bidir_PAD[24] 0 1G
Rbidir_25 bidir_PAD[25] 0 1G
Rbidir_26 bidir_PAD[26] 0 1G
Rbidir_27 bidir_PAD[27] 0 1G
Rbidir_28 bidir_PAD[28] 0 1G
Rbidir_29 bidir_PAD[29] 0 1G
Rbidir_30 bidir_PAD[30] 0 1G
Rbidir_31 bidir_PAD[31] 0 1G
Rbidir_32 bidir_PAD[32] 0 1G
Rbidir_33 bidir_PAD[33] 0 1G
Rbidir_34 bidir_PAD[34] 0 1G
Rbidir_35 bidir_PAD[35] 0 1G
Rbidir_36 bidir_PAD[36] 0 1G
Rbidir_37 bidir_PAD[37] 0 1G
Rbidir_38 bidir_PAD[38] 0 1G
Rbidir_39 bidir_PAD[39] 0 1G
Xchip VDD VSS analog_PAD[0] analog_PAD[1] bidir_PAD[0] bidir_PAD[10] bidir_PAD[11] bidir_PAD[12] bidir_PAD[13] bidir_PAD[14] bidir_PAD[15] bidir_PAD[16] bidir_PAD[17] bidir_PAD[18] bidir_PAD[19] bidir_PAD[1] bidir_PAD[20] bidir_PAD[21] bidir_PAD[22] bidir_PAD[23] bidir_PAD[24] bidir_PAD[25] bidir_PAD[26] bidir_PAD[27] bidir_PAD[28] bidir_PAD[29] bidir_PAD[2] bidir_PAD[30] bidir_PAD[31] bidir_PAD[32] bidir_PAD[33] bidir_PAD[34] bidir_PAD[35] bidir_PAD[36] bidir_PAD[37] bidir_PAD[38] bidir_PAD[39] bidir_PAD[3] bidir_PAD[4] bidir_PAD[5] bidir_PAD[6] bidir_PAD[7] bidir_PAD[8] bidir_PAD[9] clk_PAD input_PAD[0] input_PAD[10] input_PAD[11] input_PAD[1] input_PAD[2] input_PAD[3] input_PAD[4] input_PAD[5] input_PAD[6] input_PAD[7] input_PAD[8] input_PAD[9] rst_n_PAD chip_top
.ic v(bidir_PAD[0])=0 v(bidir_PAD[3])=0
.options reltol=3e-3 abstol=1e-11 vntol=1e-3 chgtol=1e-15 method=gear gmin=1e-12 rshunt=1e12 temp=25
.control
tran 0.2n 150n uic
meas tran dco1_period trig v(bidir_PAD[0]) val=2.5 rise=5 targ v(bidir_PAD[0]) val=2.5 rise=6
meas tran dco2_period trig v(bidir_PAD[3]) val=2.5 rise=3 targ v(bidir_PAD[3]) val=2.5 rise=4
let dco1_mhz = 1.0 / dco1_period / 1e6
let dco2_mhz = 1.0 / dco2_period / 1e6
echo "RESULT_DCO1_MHZ $&dco1_mhz"
echo "RESULT_DCO2_MHZ $&dco2_mhz"
.endc
.end
