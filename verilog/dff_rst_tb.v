module dff_rst_tb;
    reg clk = 0;
    reg rst_n = 0;
    reg d = 1;
    wire q;

    dff_rst dut (.clk(clk), .rst_n(rst_n), .d(d), .q(q));

    always #5 clk = ~clk;

    initial begin
        $monitor("time=%0t rst_n=%b d=%b q=%b", $time, rst_n, d, q);
        #22 rst_n =1;
        #20 d = 0;
        #20 $finish;
    end
endmodule