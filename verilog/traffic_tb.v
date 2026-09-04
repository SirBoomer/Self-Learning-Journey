module traffic_tb;
    reg clk = 0;
    reg rst_n = 0;
    reg tick = 0;
    wire red, green, yellow;

    traffic dut (.clk(clk), .rst_n(rst_n), .tick(tick), .red(red), .green(green), .yellow(yellow));

    always #5 clk = ~clk ;

    initial begin
        $monitor("time=%0t tick=%b r=%b g=%b y=%b", $time, tick, red, green, yellow);
        #12 rst_n = 1;
        #10 tick = 1;
        #10 tick = 0;
        #20 tick = 1;
        #10 tick = 0;
        #20 tick = 1;
        #10 tick = 0;
        #20 $finish;
    end
endmodule
