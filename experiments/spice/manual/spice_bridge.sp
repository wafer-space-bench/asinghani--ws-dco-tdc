* Bridge: provide a 2-port endcap matching what Magic extracted.
* The real PDK endcap has 4 ports (VDD VNW VPW VSS) but Magic's abstract view
* only kept the connected ports (VDD VSS). Provide an empty 2-port stub.
.subckt gf180mcu_fd_sc_mcu7t5v0__endcap VDD VSS
.ends
