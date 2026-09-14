module counter_if_tb;

    logic clk=0;
    always #5 clk = ~clk;

    count_if    cif (clk);
    counter_if  dut (cif);

    initial begin
        cif.rst_n = 0;
        cif.en    = 0;
        #12 cif.rst_n = 1;

        @(negedge clk);
        cif.en =1;

        repeat (5) @(posedge clk);
        #1;
        $display("count=%0d", cif.count);
        $finish;
    end
endmodule