module counter_if_tb;

    logic clk=0;
    always #5 clk = ~clk;

    count_if    cif (clk);
    counter_if  dut (cif);

    initial begin
        cif.rst_n = 0;
        cif.en    = 0;
        #12 cif.rst_n = 1;

        @(cif.cb);
        cif.cb.en <=1'b1;
        
        repeat (5) @(cif.cb);
        $display("count=%0d", cif.cb.count);
        $finish;
    end
endmodule