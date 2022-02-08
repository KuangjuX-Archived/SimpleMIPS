`timescale 1ns / 1ps
`include "defines.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/06 13:30:49
// Design Name: 
// Module Name: scu
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


module scu(
    input   wire                cpu_rst_n,
    input   wire                stallreq_id,    //译码阶段暂停信号
    input   wire                stallreq_exe,   //执行阶段暂停信号
    
    output  wire [`STALL_BUS]   stall  
    );
    
    assign  stall = (cpu_rst_n == `RST_ENABLE) ? 4'b0000 :
                    (stallreq_exe == `STOP) ? 4'b1111 :         //除法指令需要将执行阶段暂停
                    (stallreq_id == `STOP) ? 4'b0111 : 
                    4'b0000; //加载相关不需要将执行阶段暂停
                   
endmodule
