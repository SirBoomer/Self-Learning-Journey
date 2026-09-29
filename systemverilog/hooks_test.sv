module hooks_test;

    class Packet;
        rand bit [7:0] data;
        bit            parity;

        function void pre_randomize();
            $display("about to randomize");
        endfunction

        function void post_randomize();
            parity = ^data;
            $display("data=%0d, parity=%0d", data, parity);
        endfunction

    endclass

    Packet  p;

    initial begin
        p = new();
        repeat (3)
            if (!p.randomize()) $fatal(1,"randomize failed");
    end

endmodule