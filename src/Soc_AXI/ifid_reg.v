`include "defines.v"

module ifid_reg (
	input  wire 						cpu_clk_50M,
	input  wire 						cpu_rst_n,

	// 来自取指阶段的信息  
	input  wire [`INST_ADDR_BUS]       if_pc,
	input  wire [`INST_ADDR_BUS]       if_pc_plus_4,
	input  wire [`STALL_BUS    ]       stall,
	input  wire                        flush,
	input  wire [`EXC_CODE_BUS ]       if_exccode,
	input  wire                        if_inst_data_ok,
	
	// 送至译码阶段的信息  
	output reg  [`INST_ADDR_BUS]       id_pc,
	output reg  [`INST_ADDR_BUS]       id_pc_plus_4,
	output reg  [`EXC_CODE_BUS ]       id_exccode,
	output reg                         id_inst_data_ok
	);

	always @(posedge cpu_clk_50M) begin
	    // 复位的时候将送至译码阶段的信息清0
		if (cpu_rst_n == `RST_ENABLE || flush) begin
			id_pc 	        <= `PC_INIT;
			id_pc_plus_4    <= `PC_INIT; 
			id_exccode      <= `EXC_NONE;
            id_inst_data_ok <= 1'b0;
		end
		
		//取指暂停，译码不暂停，传递空指令
		else if(stall[1] == `STOP && stall[2] == `NOSTOP) begin
			id_pc 	        <= `PC_INIT;
			id_pc_plus_4    <= `PC_INIT; 
			id_exccode      <= `EXC_NONE;
            id_inst_data_ok <= 1'b0;
		end
		
		else if(stall[1] == `NOSTOP) begin
		    id_pc	        <= if_pc;	
			id_pc_plus_4    <= if_pc_plus_4;
			id_exccode      <= if_exccode;
            id_inst_data_ok <= if_inst_data_ok;
		end
	end

endmodule