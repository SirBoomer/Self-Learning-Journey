module adder4_tb;
    reg  [3:0] a, b;
    wire [4:0] sum;
    integer i, j;
    integer errors = 0;

    adder4 dut (.a(a), .b(b), .sum(sum));

    initial begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                a = i;
                b = j;
                #1;
                if (sum !== i + j) begin
                    $display("FAIL: a=%0d b=%0d expected %0d got %0d", i, j, i + j, sum);
                    errors = errors + 1;
                end
            end
        end

        if (errors == 0)
            $display("PASS: all 256 combinations correct");
        else
            $display("FAILED with %0d errors", errors);

        $finish;
    end
endmodule