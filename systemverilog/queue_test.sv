module queue_test;

    logic [7:0] q [$];
    logic [7:0] item;

    initial begin
        q.push_back(8'hA1);
        q.push_back(8'hB2);
        q.push_back(8'hC3);

        $display("size = %0d", q.size());

        item = q.pop_front();
        $display("popped %h, size now  %0d", item, q.size());

        item = q.pop_front();
        $display("popped %h, size now  %0d", item, q.size());

        $display("remaining = %p", q);
        $finish;
    end

endmodule


