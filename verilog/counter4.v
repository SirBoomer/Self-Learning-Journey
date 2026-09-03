module counter4 (
    input   clk,
    input   rst_n,
    input   en,
    output reg [3:0] count
);
    always @(posedge clk) begin
        if (!rst_n)
            count <=4'b0000;
        else if (en)
            count <= count + 1'b1;
    end
endmodule