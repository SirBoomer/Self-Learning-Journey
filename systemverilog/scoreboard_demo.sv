module scoreboard_demo;

    logic [7:0] expected_q [$];
    int errors = 0;

    task check(input logic [7:0] observed);
        logic [7:0] exp;
        if (expected_q.size() == 0) begin
            $display("FAIL: unexpected item %h", observed);
            errors++;
        end else begin
            exp = expected_q.pop_front();
            if (observed!== exp) begin
                $display("FAIL: expected %h, got %h", exp, observed);
                errors++;
            end
        end
    endtask

    initial begin
        // record what we sent
        expected_q.push_back(8'h11);
        expected_q.push_back(8'h22);
        expected_q.push_back(8'h33);

        // item arrive later, one at a time
        #10 check(8'h11);
        #10 check(8'h22);
        #10 check(8'h44); //wrong on purpose

        if (errors==0) $display("PASS");
        else            $display("FAILED with %0d errors", errors);
        $finish;
    end
endmodule

