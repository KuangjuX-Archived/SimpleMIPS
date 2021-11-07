-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
-- Date        : Mon Oct 11 14:39:52 2021
-- Host        : LAPTOP-BEASOA6F running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub d:/MiniMIPS32/MiniMIPS32.srcs/sources_1/ip/clkdiv/clkdiv_stub.vhdl
-- Design      : clkdiv
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k325tffg900-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clkdiv is
  Port ( 
    cpu_clk : out STD_LOGIC;
    clk_in1_p : in STD_LOGIC;
    clk_in1_n : in STD_LOGIC
  );

end clkdiv;

architecture stub of clkdiv is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "cpu_clk,clk_in1_p,clk_in1_n";
begin
end;
