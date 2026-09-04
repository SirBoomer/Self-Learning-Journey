module counter_tb;
    reg clk = 0 ;
    reg rst_n = 0 ;
    reg en = 0 ;
    wire [3:0] count4;
    wire [7:0] count8;

    counter #(.WIDTH(4)) c4 (.clk(clk), .rst_n(rst_n), .en(en), .count(count4));
    counter #(.WIDTH(8)) c8 (.clk(clk), .rst_n(rst_n), .en(en), .count(count8));

    always #5 clk = ~clk;

     initial begin
        $monitor("time=%0t count4=%0d count8=%0d", $time, count4, count8);
        #12 rst_n = 1;
        #10 en = 1;
        #250 $finish;

     end
endmodule