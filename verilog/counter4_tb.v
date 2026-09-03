module counter4_tb;
    reg clk = 0;
    reg rst_n = 0;
    reg en = 0;
    wire [3:0] count;

    counter4 dut (.clk(clk), .rst_n(rst_n), .en(en), .count(count));

    always #5 clk = ~clk;

    initial begin
        $monitor("time=%0t rst_n=%b en=%b count=%0d", $time, rst_n, en, count);
        #12 rst_n = 1;
        #10 en = 1;
        #200 en = 0;
        #30 $finish;
    end
endmodule
