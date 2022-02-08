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
    input   wire                stallreq_id,    //����׶���ͣ�ź�
    input   wire                stallreq_exe,   //ִ�н׶���ͣ�ź�
    
    output  wire [`STALL_BUS]   stall  
    );
    
    assign  stall = (cpu_rst_n == `RST_ENABLE) ? 4'b0000 :
                    (stallreq_exe == `STOP) ? 4'b1111 :         //����ָ����Ҫ��ִ�н׶���ͣ
                    (stallreq_id == `STOP) ? 4'b0111 : 
                    4'b0000; //������ز���Ҫ��ִ�н׶���ͣ
                   
endmodule
