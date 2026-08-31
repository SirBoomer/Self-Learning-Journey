module clock_test;
    reg clk = 0;

    always #5 clk = ~clk;

    initial begin
        $monitor("time=%0t clk=%b", $time, clk);
        #50 $finish;
    end
endmodule