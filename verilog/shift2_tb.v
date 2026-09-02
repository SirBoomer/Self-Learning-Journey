module shift2_tb;
    reg clk =0;
    reg d = 0;
    wire q1, q2;

    shift2 dut(.clk(clk), .d(d), .q1(q1), .q2(q2));

    always #5 clk = ~clk;

    initial begin
        $monitor("time=%0t d=%b q1=%b q2=%b", $time, d, q1, q2);
        #10 d<=1;
        #10 d<=0;
        #50 $finish;
    end
endmodule 