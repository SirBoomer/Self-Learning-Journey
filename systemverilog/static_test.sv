module static_test;
    
    class Packet;
        bit [7:0] addr;
        bit [7:0] data;
        static int count;
        int        id;


        function new(bit [7:0] addr, bit [7:0] data);
            this.addr = addr;
            this.data = data;
            count++;
            this.id = count;
        endfunction

        function void print();
            $display("id=%0d addr=0x%0h data=0x%0h", id, addr, data);
        endfunction

        static function void report();
            $display("packets created = %0d", count);
        endfunction
    endclass

    Packet      s1;
    Packet      s2;
    Packet      s3;

    initial begin;
        s1=new(8'h10,8'haa);
        s2=new(8'h20,8'hbb);
        s3=new(8'h30,8'hcc);
        s1.print();
        s2.print();
        s3.print();
        Packet::report();
    end
endmodule
