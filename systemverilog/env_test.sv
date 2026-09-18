module env_test;
    
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

    class Generator;
        mailbox #(Packet) mbx;

        function new(mailbox #(Packet) mbx);
            this.mbx=mbx;
        endfunction

        task run();
            repeat (3) begin
                Packet p = new($urandom, $urandom);
                mbx.put(p);
            end
        endtask
    endclass

    class Driver;
        mailbox #(Packet) mbx;

        function new(mailbox #(Packet) mbx);
        this.mbx = mbx;                
        endfunction

        task run();
            repeat (3) begin
                Packet      p;
                mbx.get(p);
                p.print();
            end
        endtask
    endclass

    Generator   gen;
    Driver      drv;
    mailbox #(Packet) mbx = new();

    initial begin
        gen=new(mbx);
        drv=new(mbx);
        fork
            gen.run();
            drv.run();
        join
    end

endmodule