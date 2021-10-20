`include "defines.v"

module if_stage (
    input 	wire 					cpu_clk_50M,
    input 	wire 					cpu_rst_n,
    
    output  reg                     ice,
    output 	reg  [`INST_ADDR_BUS] 	pc,
    output 	wire [`INST_ADDR_BUS]	iaddr
    );
    
    wire [`INST_ADDR_BUS] pc_next; 
    assign pc_next = pc + 4;                  // ������һ��ָ��ĵ�ַ
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