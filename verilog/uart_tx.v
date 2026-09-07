module uart_tx #(
    parameter CLKS_PER_BIT = 4
)(
    input   clk,
    input   rst_n,
    input   start,
    input [7:0] data,
    output reg tx,
    output reg busy
);
    localparam  IDLE = 2'd0;
    localparam  START = 2'd1;
    localparam  DATA = 2'd2;
    localparam  STOP = 2'd3;

    reg [1:0]   state;
    reg [15:0]  clk_count;
    reg [2:0]   bit_index;
    reg [7:0]   shift_reg;

    always @(posedge clk) begin
        if (!rst_n) begin
            state   <=  IDLE;
            tx      <=  1'b1;
            busy    <=  1'b0;
            clk_count<= 0;
            bit_index<= 0;
            shift_reg<= 8'b0;
        end else begin
            case (state)
                IDLE : begin
                    tx      <=  1'b1;
                    busy    <=  1'b0;
                    clk_count<= 0;
                    bit_index<= 0;
                    if (start) begin
                        shift_reg   <= data;
                        busy        <= 1'b1;
                        state       <= START;
                    end
                end

                START : begin
                    tx  <= 1'b0;
                    if (clk_count < CLKS_PER_BIT-1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count   <=  0;
                        state       <=  DATA;
                    end
                end

                DATA : begin
                    tx  <=  shift_reg[0];
                    if (clk_count < CLKS_PER_BIT-1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count <= 0;
                        if (bit_index < 7) begin
                            bit_index <= bit_index + 1;
                            shift_reg <= {1'b0, shift_reg[7:1]};

                        end else begin
                            bit_index   <=  0;
                            state       <= STOP;
                        end
                    end
                end

                STOP : begin
                    tx <= 1'b1;
                    if (clk_count < CLKS_PER_BIT-1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count   <= 0;
                        busy        <= 1'b0;
                        state       <= IDLE;
                    end
                end

                default :   state   <=  IDLE;
            endcase
        end
    end
endmodule

                    
