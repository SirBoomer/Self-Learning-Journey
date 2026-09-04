module mux4_tb;
    reg [3:0] a, b, c, d;
    reg [1:0] sel;
    wire [3:0] y;

    mux4 dut (.a(a), .b(b), .c(c), .d(d), .sel(sel), .y(y));

    initial begin
        a = 4'd1; b=4'd2; c=4'd3; d=4'd4;
        $monitor("time=%0t sel=%b y=%0d", $time, sel, y);
        sel = 2'b00; #10;
        sel = 2'b01; #10;
        sel = 2'b10; #10;
        sel = 2'b11; #10;
        $finish;
    end
endmodule