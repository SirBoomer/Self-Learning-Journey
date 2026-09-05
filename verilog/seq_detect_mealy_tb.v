module seq_detect_tb;
    reg clk = 0;
    reg rst_n = 0;
    reg in = 0;
    wire found;
    integer i;
    reg [11:0] stream = 12'b101101101100;

    seq_detect_mealy dut (.clk(clk), .rst_n(rst_n), .in(in), .found(found));

    always #5 clk = ~clk;

    initial begin
        #12 rst_n = 1;
        for (i=11; i>=0; i=i-1) begin
            @(negedge clk);
            in = stream[i];
            @(posedge clk);
            #1 $display("time=%0t in=%b state=%0d found=%b", $time, in, dut.state, found);
        end
        $finish;
    end
endmodule