module mycpu(
    input wire           [5:0] ext_int,
    input wire           clk,
    input wire           resetn,

    output  wire         inst_sram_en,
    output  wire [3:0]   inst_sram_wen,
    output  wire [31:0]  inst_sram_addr,
    output  wire [31:0]  inst_sram_wdata,
    input   wire [31:0]  inst_sram_rdata,
    
    output  wire         data_sram_en,
    output  wire [3:0]   data_sram_wen,
    output  wire [31:0]  data_sram_addr,
    output  wire [31:0]  data_sram_wdata,
    input   wire [31:0]  data_sram_rdata,
    
    output  wire [31:0]  debug_wb_pc,
    output  wire [3 :0]  debug_wb_rf_wen,
    output  wire [4 :0]  debug_wb_rf_wnum,
    output  wire [31:0]  debug_wb_rf_wdata
);

    wire           ice;
    wire           dce;

    assign inst_sram_en = (resetn == 1'b0) ? 1'b0 : ice;
    assign inst_sram_wen = 4'b0000;
    assign inst_sram_wdata = 32'h00000000;

    assign data_sram_en = (resetn == 1'b0) ? 1'b0 : dce;

    wire [31:0] inst_sram_addr_v, data_sram_addr_v;

    wire timer_int;

    MiniMIPS32 MiniMIPS32_0(
        .cpu_clk_50M(clk),
        .cpu_rst_n(resetn),

        .iaddr(inst_sram_addr_v), 
        .ice(ice),
        .inst(inst_sram_rdata),
        .dce(dce),
        .daddr(data_sram_addr_v),
        .we(data_sram_wen),
        .din(data_sram_wdata),
        .dm(data_sram_rdata),

        .int({timer_int, ext_int[4:0]}),
        .timer_int_o(timer_int),

        .debug_wb_pc(debug_wb_pc),
        .debug_wb_rf_wen(debug_wb_rf_wen),
        .debug_wb_rf_wnum(debug_wb_rf_wnum),
        .debug_wb_rf_wdata(debug_wb_rf_wdata)
    );

    // 指令存储器地址映射
    mmu u0_mmu(
        .addr_i(inst_sram_addr_v),
        .addr_o(inst_sram_addr)
    );

    // 数据存储器地址映射
    mmu u1_mmu(
        .addr_i(data_sram_addr_v),
        .addr_o(data_sram_addr)
    );
    
endmodule