`include "defines.v"

module cp0_reg(
    input  wire 				 cpu_clk_50M,
	input  wire 				 cpu_rst_n,
	
	input  wire 				 we,
	input  wire 				 re,
	input  wire [`REG_ADDR_BUS ] raddr,
	input  wire [`REG_ADDR_BUS ] waddr,
	input  wire [`REG_BUS      ] wdata,
	input  wire [`CP0_INT_BUS  ] int_i,
	
	input  wire [`INST_ADDR_BUS] pc_i,
	input  wire                  in_delay_i,
	input  wire [`EXC_CODE_BUS ] exccode_i,
	input  wire [`REG_BUS      ] badvaddr_i,
	 
	output wire 				 flush,
	output reg                   flush_im,
	output wire [`INST_ADDR_BUS] cp0_excaddr,

	output wire	[`REG_BUS      ] data_o,
	output wire [`REG_BUS 	   ] status_o,
	output wire [`REG_BUS 	   ] cause_o,

	output reg 			 	     timer_int_o
    );

	reg [`REG_BUS] badvaddr;	// CP0��badvaddr�Ĵ���
	reg [`REG_BUS] status;		// CP0��status�Ĵ���
	reg [`REG_BUS] cause;		// CP0��cause�Ĵ���
	reg [`REG_BUS] epc;			// CP0��epc�Ĵ���
	reg [`REG_BUS] count;		// CP0��count�Ĵ���
	reg [`REG_BUS] compare;		// CP0��compare�Ĵ���

	reg dclk_count;

	assign status_o = status;
	assign cause_o = cause;

    // �����쳣��Ϣ���������ˮ���ź�flush
    assign flush = (cpu_rst_n == `RST_ENABLE) ? `NOFLUSH : 
                   (exccode_i != `EXC_NONE ) ? `FLUSH : `NOFLUSH;

    //������մ�ָ��洢��IM��ȡ����ָ����ź�flush_im
    always @(posedge cpu_clk_50M) begin
        if(cpu_rst_n == `RST_ENABLE) begin
            flush_im <= `NOFLUSH;
        end
        else begin
            flush_im <= flush;
        end
    end

    // �����쳣
    task do_exc; begin
		if (status[1] == 0) begin
			if(in_delay_i) begin        // �ж��쳣����ָ���Ƿ�Ϊ�ӳٲ�ָ��
				cause[31] <= 1;   		// ��Ϊ�ӳٲ�ָ�cause[31]��Ϊ1
				epc       <= pc_i - 4;
			end else begin	
				cause[31] <= 0;
				epc       <= pc_i;
			end
		end
		status[1]  <= 1'b1;
		cause[6:2] <= exccode_i;
	end
	endtask

    // ����ERETָ��
	task do_eret; begin
		status[1]   <= 0;
	end
	endtask

	// �����쳣���������ڵ�ַ
	assign cp0_excaddr = (cpu_rst_n == `RST_ENABLE) ? `PC_INIT :
						 (exccode_i == `EXC_INT   ) ? `EXC_INT_ADDR :
						 (exccode_i == `EXC_ERET && waddr == `CP0_EPC && we == `WRITE_ENABLE) ? wdata :
						 (exccode_i == `EXC_ERET  ) ? epc :
						 (exccode_i != `EXC_NONE  ) ? `EXC_ADDR : `ZERO_WORD;

    // ����CP0�Ĵ�������
    always @ (posedge cpu_clk_50M) begin
		if(cpu_rst_n == `RST_ENABLE) begin
            badvaddr 	  <= `ZERO_WORD;
            status 	      <= 32'h10000000;              // status[28]Ϊ1����ʾʹ��CP0Э������
            cause 	      <= {25'b0, `EXC_NONE, 2'b0};
            epc 		  <= `ZERO_WORD;
			count 		  <= `ZERO_WORD;
			compare 	  <= `ZERO_WORD;
			timer_int_o	  <= `InterruptNotAssert;
			dclk_count    <= 1'b0;
		end 
        else begin
			dclk_count <= ~dclk_count;
			if(dclk_count) count <= count + 1;
			cause[15:10] <= int_i;
			cause[30] <= timer_int_o;
			if (compare != `ZERO_WORD && count == compare) timer_int_o <= `InterruptAssert;
			case (exccode_i)
				`EXC_NONE:                              // ���쳣����ʱ���ж��Ƿ�Ϊд�Ĵ���ָ�д������
					if (we == `WRITE_ENABLE) begin
						case(waddr)
						 	`CP0_BADVADDR: badvaddr <= wdata;
						 	`CP0_STATUS:   status   <= wdata; 
						 	`CP0_CAUSE:    cause    <= wdata;
                            `CP0_EPC:      epc      <= wdata;
							`CP0_COUNT:    begin
								dclk_count <= 1'b0;
								count    <= wdata;
							end
							`CP0_COMPARE:  begin
								compare  <= wdata;
								timer_int_o <= `InterruptNotAssert;
							end
						endcase
					end
			    `EXC_ADEL: begin
			        badvaddr <= badvaddr_i;
                    do_exc();
                end
			    `EXC_ADES: begin
			        badvaddr <= badvaddr_i;
			        do_exc();
			    end
				`EXC_ERET:       // ERETָ��
					do_eret();
				default:        // �쳣����ʱ�������Ӧ�쳣
					do_exc();
			endcase
		end
	end

	// ��CP0�еļĴ���
    assign data_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD : 
                    (re != `READ_ENABLE      ) ? `ZERO_WORD :
                    (raddr == `CP0_BADVADDR  ) ? badvaddr :
				    (raddr == `CP0_STATUS    ) ? status :
				    (raddr == `CP0_CAUSE     ) ? cause :
				    (raddr == `CP0_EPC       ) ? epc :
					(raddr == `CP0_COUNT     ) ? count :
					(raddr == `CP0_COMPARE   ) ? compare : `ZERO_WORD;

endmodule
