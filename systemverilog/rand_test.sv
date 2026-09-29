module rand_test;
    
    class Packet;
        rand bit [7:0] addr;
        rand bit [7:0] data;
        constraint c_addr { addr inside {[8'h10:8'h1f]};}
        constraint c_data { data !=8'h00; }

        function void print();
            $display("addr=0x%0h data=0x%0h", addr, data);
        endfunction
    
    endclass    
    Packet  p;

    initial begin
        p=new();
        repeat (5) begin
            if (!p.randomize()) $fatal(1, "randomize failed");
            p.print();
        end
        p.c_addr.constraint_mode(0);
        repeat (5) begin
            if (!p.randomize()) $fatal(1, "randomize failed");
            p.print();
        end    
        p.addr.rand_mode(0);
        p.addr= 8'h55;
        repeat (5) begin
            if (!p.randomize()) $fatal(1, "randomize failed");
            p.print();
        end    
    end


endmodule
        
