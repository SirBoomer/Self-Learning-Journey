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
            if (!p.randomize()) $fatal("randomize failed");
            p.print();
        end
    end

endmodule
        
