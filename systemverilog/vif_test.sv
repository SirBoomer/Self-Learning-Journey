module vif_test;

    logic clk = 0;
    always #5 clk = ~clk;

    count_if    cif (clk);
    counter_if  dut (cif);

    class CountDriver;
        virtual count_if vif;

        function new(virtual count_if vif);
            this.vif=vif;
        endfunction

        task run();
            vif.cb.rst_n <= 0;
            repeat (2) @(vif.cb);
            vif.cb.rst_n <= 1;
            vif.cb.en <= 1;
            repeat (5) @(vif.cb);
            $display("count=%0d", vif.cb.count);
        endtask
    endclass

    class CountMonitor;
        virtual count_if vif;

        function new(virtual count_if vif);
            this.vif=vif;
        endfunction

        task run();
            repeat (6) begin
                @(vif.cb);
                $display("count=%0d", vif.cb.count);
            end
        endtask
    endclass

    CountDriver drv;
    CountMonitor mon;

    initial begin
        drv = new(cif);
        mon = new(cif);
        fork
            drv.run();
            mon.run();
        join
        $finish;
    end
endmodule     
 