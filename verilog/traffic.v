module traffic(
    input   clk,
    input   rst_n,
    input   tick,
    output reg red,
    output reg green,
    output reg yellow
);
    localparam RED = 2'b00;
    localparam GREEN = 2'b01;
    localparam YELLOW = 2'b10;

    reg [1:0] state, next_state;
    
    //Block 1: state register(sequential)
    always @(posedge clk) begin
        if (!rst_n)
            state <= RED;
        else
            state <= next_state;
    end

    //Block 2: next-state logic(combinational)
    always @(*) begin
        case (state)
            RED :       next_state = tick ? GREEN   :   RED;
            GREEN :     next_state = tick ? YELLOW  :   GREEN;
            YELLOW :    next_state = tick ? RED     :   YELLOW;
            default:    next_state = RED;
        endcase
    end

    //Block 3: output logic (combinational)
    always @(*) begin
        red     = (state == RED);
        yellow  = (state == YELLOW);
        green   = (state == GREEN);
    end
endmodule