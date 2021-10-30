// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Fri Oct 29 19:10:30 2021
// Host        : DESKTOP-HJ97TPV running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top inst_rom -prefix
//               inst_rom_ inst_rom_stub.v
// Design      : inst_rom
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_4,Vivado 2019.2" *)
module inst_rom(clka, ena, addra, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,addra[10:0],douta[31:0]" */;
  input clka;
  input ena;
  input [10:0]addra;
  output [31:0]douta;
endmodule
