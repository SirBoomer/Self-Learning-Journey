module seq_detect_mealy (
    input   clk,
    input   rst_n,
    input   in,
    output reg  found 
);
    localparam S0 = 3'd0;
    localparam S1 = 3'd1;
    localparam S2 = 3'd2;
    localparam S3 = 3'd3;

    reg [2:0] state, next_state;
    
    // Block 1
    always @(posedge clk) begin
        if (!rst_n)
            state <= S0;
        else
            state <= next_state;
    end

    //Block 2
    always @(*) begin
        case (state)
            S0 :        next_state = in ? S1    :   S0;
            S1 :        next_state = in ? S1    :   S2;
            S2 :        next_state = in ? S3    :   S0; 
            S3 :        next_state = in ? S1    :   S2;
            default:    next_state = S0;
        endcase
    end

    //Block 3
    always @(*) begin
        found   = (state == S3) && in;
    end
endmodule