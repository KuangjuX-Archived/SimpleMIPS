`include "defines.v"

module if_stage (
    input 	wire 					cpu_clk_50M,
    input 	wire 					cpu_rst_n,
    
    input   wire [ 1: 0         ]  jtsel,
    input   wire [`REG_BUS      ]  addr1,
    input   wire [`REG_BUS      ]  addr2,
    input   wire [`REG_BUS      ]  addr3,
    
    input   wire [`STALL_BUS    ]  stall,
    
    output  wire                   ice,
    output 	reg  [`INST_ADDR_BUS] 	pc,
    output 	wire [`INST_ADDR_BUS]	iaddr,
    
    input  wire                    flush,
    input  wire  [`INST_ADDR_BUS]  cp0_excaddr
    );
    
    wire [`INST_ADDR_BUS] pc_next; 
    assign pc_next = pc + 4;                  // ������һ��ָ��ĵ�ַ
    
    reg ce;
    always @(posedge cpu_clk_50M) begin
		if (cpu_rst_n == `RST_ENABLE) begin
			ce <= `CHIP_DISABLE;		      // ��λ��ʱ��ָ��洢������  
		end else begin
			ce <= `CHIP_ENABLE; 		      // ��λ������ָ��洢��ʹ��
		end
	end

    assign ice = (stall[1] == `STOP || flush == `FLUSH) ? 0 : ce;

    always @(posedge cpu_clk_50M) begin
        if (ce == `CHIP_DISABLE)
            pc <= `PC_INIT;                   // ָ��洢�����õ�ʱ��PC���ֳ�ʼֵ��MiniMIPS32������Ϊ0x00000000��
        else if (flush == `FLUSH) begin
            pc <= cp0_excaddr;
        end
        else if (stall[0] == `NOSTOP) begin
            case (jtsel)
                2'b00: pc <= pc_next;
                2'b01: pc <= addr3;
                2'b10: pc <= addr1;
                2'b11: pc <= addr2;
                default: pc <= pc_next; // ָ��洢��ʹ�ܺ�PCֵÿʱ�����ڼ�4 
            endcase	
        end
    end
    
    assign iaddr = (ice == `CHIP_DISABLE) ? `PC_INIT : pc;    // ��÷���ָ��洢���ĵ�ַ

endmodule