`include "defines.v"

module scu (
    input  wire              cpu_rst_n,
    
    input  wire              i_stall,
    input  wire              d_stall,
    input  wire              stallreq_id,
    input  wire              stallreq_exe,
    
    output wire [`STALL_BUS] stall,
    output wire              longest_stall
);

    // assign stall = (cpu_rst_n == `RST_ENABLE) ? 4'b0000 :
    //                (stallreq_exe == `STOP   ) ? 4'b1111 :
    //                (stallreq_id  == `STOP   ) ? 4'b0111 : 
    //                4'b0000;

    assign longest_stall = i_stall | d_stall | stallreq_exe | stallreq_id;
    assign stall[0] = longest_stall;
    assign stall[1] = longest_stall;
    assign stall[2] = longest_stall;
    assign stall[3] = longest_stall;
endmodule
