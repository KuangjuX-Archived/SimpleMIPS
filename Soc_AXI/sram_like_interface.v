`include "defines.v"
module sram_like_interface(
    input               clk,
    input               resetn,
    input               flush,

    input  wire [31:0]  inst_sram_addr_v,
    input  wire         inst_sram_en,
    output reg  [31:0]  inst_sram_rdata,
    output reg          stallreq_rinst,
    

    input  wire [31:0]  data_sram_addr_v,
    input  wire         data_sram_en,
    input  wire         data_sram_wen,
    input  wire [31:0]  data_sram_wdata,
    output reg  [31:0]  data_sram_rdata,
    output reg          stallreq_rdata,
    output reg          stallreq_wdata,

    output reg          inst_req, // 请求信号,为 1 时有读写请求，为 0 时无读写请求
    output reg          inst_wr, // 该次请求是写
    output reg [1:0]    inst_size, // 该次请求传输的字节数，0:1 bytes, 1:2 bytes, 2:4bytes
    output reg [31:0]   inst_addr, // 该次请求的地址
    output reg [31:0]   inst_wdata, // 该次请求的写数据
    input  wire [31:0]  inst_rdata, // 该次请求返回的读数据
    input  wire         inst_addr_ok, // 该次请求的地址传输 OK, 读: 地址被接收; 写: 地址和数据被接收
    input  wire         inst_data_ok, // 该次请求的数据传输 Ok, 读: 数据返回; 写: 数据写入完成

    output reg          data_req,
    output reg          data_wr,
    output reg[1:0]     data_size,
    output reg[31:0]    data_addr,
    output reg[31:0]    data_wdata,
    input  wire[31:0]   data_rdata,
    input  wire         data_addr_ok,
    input  wire         data_data_ok
);

    // 读指令请求状态
    reg[2:0] rinst_current_state;
    reg[2:0] rinst_next_state;

    reg[2:0] rdata_current_state;
    reg[2:0] rdata_next_state;

    reg[2:0] wdata_current_state;
    reg[2:0] wdata_next_state;

    wire [31:0]     inst_sram_addr;
    wire [31:0]     data_sram_addr;

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


    always@(posedge clk)begin
        if(resetn == `RST_ENABLE || flush == `TRUE_V)begin
            rinst_current_state <= `AXI_IDLE;
            rdata_current_state <= `AXI_IDLE;
            wdata_current_state <= `AXI_IDLE;
        end else begin
            rinst_current_state <= rinst_next_state;
            rdata_current_state <= rdata_next_state;
            wdata_current_state <= wdata_next_state;
        end
    end

    // 下个状态
    always@(*)begin
        if(resetn == `RST_ENABLE || flush == `TRUE_V)begin
            rinst_next_state = `AXI_IDLE;
        end else begin
            case(rinst_current_state)
                `AXI_IDLE: begin
                    if(inst_sram_en == `TRUE_V)begin
                        rinst_next_state = `ARREADY;
                    end else begin
                        rinst_next_state = `AXI_IDLE;
                    end
                end

                `ARREADY: begin
                    if(inst_addr_ok == `TRUE_V)begin
                        rinst_next_state = `RVALID;
                    end else begin
                        rinst_next_state = `ARREADY;
                    end
                end

                `RVALID: begin
                    if(inst_data_ok == `TRUE_V)begin
                        rinst_next_state = `AXI_IDLE;
                    end else begin
                        rinst_next_state = `RVALID;
                    end
                end
                default: rinst_next_state <= `AXI_IDLE;
            endcase
        end
    end

    
    always@(*)begin
        if(resetn == `RST_ENABLE || flush == `TRUE_V)begin
            rdata_next_state <= `AXI_IDLE;
        end else begin
            case(rdata_current_state)
                `AXI_IDLE:begin
                    if(data_sram_en == `TRUE_V && !(data_sram_addr == data_addr && wdata_next_state != `AXI_IDLE))begin
                        // 避免读写冲突
                        rdata_next_state = `ARREADY;
                    end else begin
                        rdata_next_state = `AXI_IDLE;
                    end
                end

                `ARREADY:begin
                    if(data_addr_ok == `TRUE_V)begin
                        rdata_next_state = `RVALID;
                    end else begin
                        rdata_next_state = `ARREADY;
                    end
                end

                `RVALID: begin
                    if(data_data_ok == `TRUE_V)begin
                        rdata_next_state = `AXI_IDLE;
                    end else begin
                        rdata_next_state = `RVALID;
                    end
                end
                default: rdata_next_state = `AXI_IDLE;
            endcase
        end
    end

    always @(*) begin
        if(resetn == `RST_ENABLE || flush == `TRUE_V)begin
            wdata_next_state = `AXI_IDLE;
        end else begin
            case(wdata_current_state)
                `AXI_IDLE: begin
                    if(data_sram_en == `TRUE_V && data_sram_wen == `TRUE_V)begin
                        wdata_next_state = `AWREADY;
                    end else begin
                        wdata_next_state = `AXI_IDLE;
                    end
                end

                `AWREADY: begin
                    if(data_addr_ok == `TRUE_V)begin
                        wdata_next_state = `BVALID;
                    end else begin
                        wdata_next_state = `AWREADY;
                    end
                end

                `BVALID: begin
                    if(data_data_ok == `TRUE_V)begin
                        wdata_next_state = `AXI_IDLE;
                    end else begin
                        wdata_next_state = `BVALID;
                    end
                end
                default: wdata_next_state = `AXI_IDLE;
            endcase
        end
    end


    always@(posedge clk)begin
        if(resetn == `RST_ENABLE || flush == `TRUE_V)begin
            inst_req   <= 1'b0;
            inst_wr    <= 1'b0;
            inst_size  <= 2'b0;
            inst_addr  <= `ZERO_WORD;
            inst_wdata <= `ZERO_WORD;

            data_req   <= 1'b0;
            data_wr    <= 1'b0;
            data_size  <= 2'b0;
            data_addr  <= `ZERO_WORD;
            data_wdata <= `ZERO_WORD;

            inst_sram_rdata <= `ZERO_WORD;
            data_sram_rdata <= `ZERO_WORD;
            stallreq_rinst <= 1'b0;
            stallreq_rdata <= 1'b0;
            stallreq_wdata <= 1'b0;
        end else begin
            case(rinst_current_state)
                // 读指令的状态机
                `AXI_IDLE: begin
                    inst_sram_rdata <= `ZERO_WORD;
                    if(inst_sram_en == `TRUE_V)begin
                        inst_req <= `TRUE_V;
                        inst_wr <= `FALSE_V;
                        inst_addr <= inst_sram_addr;
                        inst_size <= 2'b10;
                        // 此时产生指令暂停
                        stallreq_rinst <= 1'b1;
                    end else begin
                        inst_req <= `FALSE_V;
                        inst_wr <= `FALSE_V;
                        inst_addr <= `ZERO_WORD;
                        inst_size <= 2'b00;
                    end
                end

                `ARREADY: begin
                    if(inst_addr_ok == `TRUE_V)begin
                        // 地址握手成功
                        inst_req <= `FALSE_V;
                        inst_size <= 2'b00;
                        inst_addr <= `ZERO_WORD;
                    end else begin
                        // 地址握手失败  
                    end
                end

                `RVALID: begin
                    if(inst_data_ok == `TRUE_V)begin
                        // 数据握手成功
                        inst_sram_rdata <= inst_rdata;
                        stallreq_rinst <= 1'b0;
                    end else begin
                        // 数据握手失败
                    end
                end
            endcase

            case(rdata_current_state)
                // 读数据的状态机
                `AXI_IDLE: begin
                    data_sram_rdata <= `ZERO_WORD;
                    if(data_sram_en == `TRUE_V)begin
                        data_req <= `TRUE_V;
                        data_wr <= `FALSE_V;
                        data_addr <= data_sram_addr;
                        data_size <= 2'b10;
                        stallreq_rdata <= 1'b1;
                    end else begin
                        data_req <= `FALSE_V;
                        data_addr <= `ZERO_WORD;
                        data_size <= 2'b00;
                    end
                end

                `ARREADY: begin
                    if(data_addr_ok == `TRUE_V)begin
                        // 地址握手成功
                        data_req <= `FALSE_V;
                        data_size <= 2'b00;
                        data_addr <= `ZERO_WORD;
                    end else begin
                        // 地址握手失败  
                    end
                end

                `RVALID: begin
                    if(data_data_ok == `TRUE_V)begin
                        // 数据握手成功
                        data_sram_rdata <= data_rdata;
                        stallreq_rdata <= 1'b0;
                    end else begin
                        // 数据握手失败
                    end
                end
            endcase

            case(wdata_current_state)
            // 写数据存储器的状态机
                `AXI_IDLE:begin
                    if(data_sram_en == `TRUE_V && data_sram_wen == `TRUE_V && data_sram_wdata != `ZERO_WORD && data_sram_addr != `ZERO_WORD)begin
                        data_req <= `TRUE_V;
                        data_wr <= `TRUE_V;
                        data_size <= 2'b10;
                        data_addr <= data_sram_addr;
                        data_wdata <= data_sram_wdata;
                        stallreq_wdata <= 1'b1;
                    end else begin
                        data_req <= `FALSE_V;
                        data_wr <= `FALSE_V;
                        data_size <= 2'b00;
                        data_addr <= `ZERO_WORD;
                        data_wdata <= `ZERO_WORD;
                    end
                end

                `AWREADY: begin
                    if(data_addr_ok == `TRUE_V)begin
                        // 地址握手成功
                        data_req <= `FALSE_V;
                        data_wr <= `FALSE_V;
                        data_size <= 2'b00;
                        data_addr <= `ZERO_WORD;
                        data_wdata <= `ZERO_WORD;
                    end else begin
                        // 地址握手失败
                    end
                end

                `BVALID: begin
                    if(data_data_ok == `TRUE_V)begin
                        stallreq_wdata <= 1'b0;
                    end
                end
            endcase
        end
    end
    

endmodule