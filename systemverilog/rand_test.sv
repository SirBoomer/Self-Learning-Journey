module rand_test;
    
    class Packet;
        rand bit [7:0] addr;
        rand bit [7:0] data;

        function void print();
            $display("addr=0x%0h data=0x%0h", addr, data);
        endfunction
    
    endclass    
    Packet  p;

    initial begin
        p=new();
        repeat (5) begin
            p.randomize();
            p.print();
        end
    end

endmodule
        
