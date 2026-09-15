module packet_test;
    
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

    Packet      p1;
    Packet      p2;
    Packet      p3;

    Packet      q [$];
    Packet      tmp;
    Packet      pkt;


    initial begin
        p1  =   new(8'h10,8'haa);
        p2  =   new(8'h20,8'hbb);
        p3  =   new(8'h30,8'hcc);
        p1.print();
        p2.print();
        p3.print();
        q.push_back(p1);
        q.push_back(p2);
        q.push_back(p3);
        $display("size = %0d", q.size());
        tmp=q.pop_front();
        tmp.print();
        tmp.data= 8'hff;
        p1.print();
        for (int i = 0; i < 3; i++) begin
            pkt = new(i, i * 2);      // new object each iteration
            q.push_back(pkt);
            foreach (q[i]) q[i].print();
        end
    end
    
endmodule


