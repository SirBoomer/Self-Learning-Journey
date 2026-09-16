module inherit_test;
    
    class Packet;
        bit [7:0] addr;
        bit [7:0] data;

        function new(bit [7:0] addr, bit [7:0] data);
            this.addr = addr;
            this.data = data;
        endfunction

        virtual function void print();
            $display("addr=0x%0h data=0x%0h", addr, data);
        endfunction

    endclass

    class BurstPacket extends Packet;
        int len;

        function new(bit [7:0] addr, bit[7:0] data, int len);
            super.new(addr, data);
            this.len= len;
        endfunction

        function void print();
            super.print();
            $display("len=%0d", len);
        endfunction
    endclass

    Packet      p;
    BurstPacket b;
    Packet      p2;

    initial begin;
        p = new(8'h10, 8'haa);
        b = new(8'h20, 8'hbb, 5);
        p.print();
        b.print();
        p2 = b;          // base handle, pointed at your BurstPacket object
        p2.print();
    end
endmodule 