module uart_tx_tb;
    parameter CLKS_PER_BIT = 4;

    reg clk = 0;
    reg rst_n = 0;
    reg start = 0;
    reg [7:0] data = 8'h00;
    reg [7:0] received;
    wire tx, busy;
    

    uart_tx #(.CLKS_PER_BIT(CLKS_PER_BIT)) dut (.clk(clk), .rst_n(rst_n), .start(start), .data(data), .tx(tx), .busy(busy));

    always #5 clk = ~clk;

    task uart_receive(output [7:0] byte_out);
        integer j;
        begin
            @(negedge tx);
            #(CLKS_PER_BIT * 10 * 1.5);
            for (j = 0; j < 8 ; j = j + 1) begin
                byte_out[j] = tx;
                #(CLKS_PER_BIT * 10);
            end
        end
    endtask

        integer k;
    integer errors = 0;

    initial begin
        #12 rst_n = 1;

        for (k = 0; k < 256; k = k + 1) begin
            @(negedge clk);
            data  = k;
            start = 1;
            @(negedge clk);
            start = 0;

            uart_receive(received);

            if (received !== data) begin
                $display("FAIL: sent=%h received=%h", data, received);
                errors = errors + 1;
            end

            wait (busy == 0);
            @(negedge clk);
        end

        if (errors == 0)
            $display("PASS: all 256 byte values transmitted correctly");
        else
            $display("FAILED with %0d errors", errors);

        $finish;
    end
endmodule
