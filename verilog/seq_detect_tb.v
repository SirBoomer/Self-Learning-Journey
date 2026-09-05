module seq_detect_tb;
    reg clk = 0;
    reg rst_n = 0;
    reg in = 0;
    reg expected;
    integer errors = 0;
    wire found;
    integer i;
    reg [11:0] stream = 12'b101101101100;
    reg [3:0] history =4'b0000;

    seq_detect dut (.clk(clk), .rst_n(rst_n), .in(in), .found(found));

    always #5 clk = ~clk;

    initial begin
        #12 rst_n = 1;
        for (i=11; i>=0; i=i-1) begin
            @(negedge clk);
            in = stream[i];
            @(posedge clk);
            history={history[2:0], in};
            #1;
            expected = (history == 4'b1011);
            if (found!== expected) begin 
                $display("FAIL: time=%0t history=%b expected=%b got=%b", $time, history, expected, found);
                errors = errors + 1;
            end
        end
        if (errors == 0)
            $display("PASS: 12 bits checked, no errors");
        else
            $display("FAILED with %0d errors", errors);
        $finish;
    end
endmodule