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
        mailbox #(Packet) mbx_gd; 
        mailbox #(Packet) mbx_dd;
        mailbox #(Packet) mbx_de;

        function new(mailbox #(Packet) mbx_gd, mailbox #(Packet) mbx_dd, mailbox #(Packet) mbx_de);
            this.mbx_gd = mbx_gd;
            this.mbx_dd = mbx_dd;
            this.mbx_de = mbx_de;                
        endfunction

        task run();
            repeat (3) begin
                Packet      p;
                mbx_gd.get(p);
                mbx_dd.put(p);
                mbx_de.put(p);
            end
        endtask
    endclass

    class Scoreboard;
        mailbox #(Packet) mbx_de;  
        mailbox #(Packet) mbx_da; 

        function new(mailbox #(Packet) mbx_de, mailbox #(Packet) mbx_da);
            this.mbx_de=mbx_de;
            this.mbx_da=mbx_da;
        endfunction

        task run();
            repeat (3) begin
                Packet exp, act;
                mbx_de.get(exp);
                mbx_da.get(act);
                if (act.addr == exp.addr && act.data == exp.data + 1)
                    $display("PASS addr=0x%0h data=0x%0h", act.addr, act.data);
                else
                    $display("FAIL addr=0x%0h expected 0x%0h got 0x%0h",
                             exp.addr, exp.data + 1, act.data);
            end
        endtask
    endclass

    class Dut;
        mailbox #(Packet) mbx_dd;
        mailbox #(Packet) mbx_da;

        function new(mailbox #(Packet) mbx_dd, mailbox #(Packet) mbx_da);
            this.mbx_dd = mbx_dd;
            this.mbx_da = mbx_da;
        endfunction

        task run();
            repeat (3) begin
                Packet      in, out;
                mbx_dd.get(in);
                out = new(in.addr, in.data+1);
                mbx_da.put(out);
            end
        endtask
    endclass



    Generator   gen;
    Driver      drv;
    Dut         dut;
    Scoreboard  scb;

    mailbox #(Packet) mbx_gd = new();
    mailbox #(Packet) mbx_dd = new();
    mailbox #(Packet) mbx_de = new();
    mailbox #(Packet) mbx_da = new();

    initial begin
        gen=new(mbx_gd);
        drv=new(mbx_gd, mbx_dd, mbx_de);
        scb=new(mbx_de, mbx_da);
        dut=new(mbx_dd, mbx_da);
        fork
            gen.run();
            drv.run();
            scb.run();
            dut.run();
        join
    end

endmodule