`include "defines.v"

module ifid_reg (
	input  wire 						cpu_clk_50M,
	input  wire 						cpu_rst_n,

	// ����ȡָ�׶ε���Ϣ  
	input  wire [`INST_ADDR_BUS]       if_pc,
	
	input  wire [`STALL_BUS    ]       stall,
	
	// ��������׶ε���Ϣ  
	output reg  [`INST_ADDR_BUS]       id_pc,
	
	input wire                         flush
	);

	always @(posedge cpu_clk_50M) begin
	    // ��λ��ʱ����������׶ε���Ϣ��0
		if (cpu_rst_n == `RST_ENABLE || flush) begin
			id_pc 	<= `PC_INIT;
		end else if (stall[1] == `STOP && stall[2] == `NOSTOP) begin
		    id_pc   <= `ZERO_WORD;
		end
		// ������ȡָ�׶ε���Ϣ�Ĵ沢��������׶�
		else if (stall[1] == `NOSTOP) begin
			id_pc	<= if_pc;		
		end
	end

endmodule