module mbx_test;
    
    class Packet;
        bit [7:0] addr;
        bit [7:0] data;

        function new(bit [7:0] addr, bit [7:0] data);
            this.addr = addr;
            this.data = data;
        endfunction

        function void print();
            $display("addr=0x%0h data=0x%0h", addr, data);
        endfunction
    endclass

    mailbox #(Packet) mbx = new();

    Packet      sent;
    Packet      received;


    initial begin
        repeat (3) begin
    
            #10;
            sent = new($urandom, $urandom);
            mbx.put(sent);
            $display("[%0t] put", $time);
        end
    end
    initial begin
        repeat (3) begin
            $display("[%0t] calling get", $time);
            mbx.get(received);
            $display("[%0t] got it", $time);
            received.print();
        end
    end

endmodule



