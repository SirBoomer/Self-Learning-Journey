module struct_test;

    typedef struct packed {
        logic [7:0] data;
        logic       valid;

    } packet_t;

    packet_t p;

    initial begin
        p.data  =   8'hA5;
        p.valid =   1'b1;
        $display("p = %b", p);
        $display("data = %h, valid = %b", p.data, p.valid);
        $finish;
    end
endmodule