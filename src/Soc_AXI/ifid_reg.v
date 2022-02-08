`include "defines.v"

module ifid_reg (
	input  wire 						cpu_clk_50M,
	input  wire 						cpu_rst_n,

	// ����ȡָ�׶ε���Ϣ  
	input  wire [`INST_ADDR_BUS]       if_pc,
	input  wire [`INST_ADDR_BUS]       if_pc_plus_4,
	input  wire [`STALL_BUS    ]       stall,
	input  wire                        flush,
	input  wire [`EXC_CODE_BUS ]       if_exccode,
	input  wire                        if_inst_data_ok,
	
	// ��������׶ε���Ϣ  
	output reg  [`INST_ADDR_BUS]       id_pc,
	output reg  [`INST_ADDR_BUS]       id_pc_plus_4,
	output reg  [`EXC_CODE_BUS ]       id_exccode,
	output reg                         id_inst_data_ok
	);

	always @(posedge cpu_clk_50M) begin
	    // ��λ��ʱ����������׶ε���Ϣ��0
		if (cpu_rst_n == `RST_ENABLE || flush) begin
			id_pc 	        <= `PC_INIT;
			id_pc_plus_4    <= `PC_INIT; 
			id_exccode      <= `EXC_NONE;
            id_inst_data_ok <= 1'b0;
		end
		
		//ȡָ��ͣ�����벻��ͣ�����ݿ�ָ��
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