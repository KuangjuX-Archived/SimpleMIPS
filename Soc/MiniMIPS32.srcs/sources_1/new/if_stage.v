`include "defines.v"

module if_stage (
    input 	wire 					cpu_clk_50M,
    input 	wire 					cpu_rst_n,
    input   wire [`INST_ADDR_BUS]   jump_addr_1_i,
    input   wire [`INST_ADDR_BUS]   jump_addr_2_i,
    input   wire [`INST_ADDR_BUS]   jump_addr_3_i,
    input   wire [`JTSEL_BUS]       jtsel_i,
    
    output  reg                     ice,
    output 	reg  [`INST_ADDR_BUS] 	pc,
    output 	wire [`INST_ADDR_BUS]	iaddr,
    output  wire [`INST_ADDR_BUS]   pc_plus_4_o
    );

    // ��� PC+4, �ṩ������׶Σ����ڲ���ת�Ƶ�ַ
    assign  pc_plus_4_o = (cpu_rst_n == `RST_ENABLE) ? `PC_INIT: pc + 4;
    
    wire [`INST_ADDR_BUS] pc_next; 

    // ������һ��ָ��ĵ�ַ
    assign pc_next = (jtsel_i == 2'b00) ? pc_plus_4_o:
                     (jtsel_i == 2'b01) ? jump_addr_1_i:    // J, JAR ת�Ƶ�ַ
                     (jtsel_i == 2'b10) ? jump_addr_2_i:    // JR ת�Ƶ�ַ
                     (jtsel_i == 2'b11) ? jump_addr_3_i:    // BEQ, BNE ת�Ƶ�ַ
                     `PC_INIT;

    
    always @(posedge cpu_clk_50M) begin
		if (cpu_rst_n == `RST_ENABLE) begin
			ice <= `CHIP_DISABLE;		      // ��λ��ʱ��ָ��洢������  
		end else begin
			ice <= `CHIP_ENABLE; 		      // ��λ������ָ��洢��ʹ��
		end
	end

    always @(posedge cpu_clk_50M) begin
        if (ice == `CHIP_DISABLE)
            pc <= `PC_INIT;                   // ָ��洢�����õ�ʱ��PC���ֳ�ʼֵ��MiniMIPS32������Ϊ0x00000000��
        else begin
            pc <= pc_next;                    // ָ��洢��ʹ�ܺ�PCֵÿʱ�����ڼ�4 	
        end
    end
    
    // TODO��ָ��洢���ķ��ʵ�ַû�и�����������Χ���н��й̶���ַӳ�䣬��Ҫ�޸�!!!
    assign iaddr = (ice == `CHIP_DISABLE) ? `PC_INIT : pc;    // ��÷���ָ��洢���ĵ�ַ
    
endmodule