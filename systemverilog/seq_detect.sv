module seq_detect (
    input   logic clk,
    input   logic rst_n,
    input   logic in,
    output  logic found 
);
    typedef enum logic [2:0] {S0,S1,S2,S3,S4} state_t;

    state_t state, next_state;
    
    // Block 1
    always_ff @(posedge clk) begin
        if (!rst_n)
            state <= S0;
        else
            state <= next_state;
    end

    //Block 2
    always_comb begin
        case (state)
            S0 :        next_state = in ? S1    :   S0;
            S1 :        next_state = in ? S1    :   S2;
            S2 :        next_state = in ? S3    :   S0; 
            S3 :        next_state = in ? S4    :   S2;
            S4 :        next_state = in ? S1    :   S2;
            default:    next_state = S0;
        endcase
    end

    //Block 3
    always_comb begin
        found   = (state == S4);
    end
endmodule