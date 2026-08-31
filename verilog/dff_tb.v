module dff_tb;
    reg clk = 0;
    reg d = 0;
    wire q;

    dff dut (.clk(clk), .d(d), .q(q));

    always #5 clk = ~clk;

    initial begin
        $monitor("time=%0t clk=%b d=%b q=%b", $time, clk, d, q);
        #7  d = 1;
        #10 d = 0;
        #10 d = 1;
        #13 d = 0;
        #10 $finish;
    end
endmodule