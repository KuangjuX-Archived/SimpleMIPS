`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/25 21:12:15
// Design Name: 
// Module Name: hilo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "defines.v"

module hilo(
    input wire cpu_clk_50M,
    input wire cpu_rst_n,

    // д�˿�
    input wire we,
    input wire[`REG_BUS] hi_i,
    input wire[`REG_BUS] lo_i,

    // ���˿�
    output reg[`REG_BUS] hi_o,
    output reg[`REG_BUS] lo_o,
    );
    
    always @(posedge cpu_clk_50M) begin
      if(cpu_rst_n == `RST_ENABLE) begin
        hi_o <= `ZERO_WORD;
        lo_o <= `ZERO_WORD;
      end
      else if(we == `WRITE_ENABLE) begin
        hi_o <= hi_i; // ���˷����mulres��ǰ32λ��HI�Ĵ���
        lo_o <= lo_i; // ���˷����mulres�ĺ�32λ��LO�Ĵ���
      end
    end
endmodule
