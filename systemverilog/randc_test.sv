module randc_test;

    class Cyc;
        rand bit [1:0] r;
        randc bit [1:0] c;
    endclass

    Cyc x;

    initial begin
         x = new();
         repeat (8) begin
            if (!x.randomize()) $fatal("randomize failed");
            $display ("rand=%0d randc=%0d", x.r, x.c);
         end
    end

endmodule