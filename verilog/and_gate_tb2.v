module and_gate_tb2;
    reg  a, b;
    wire y;

    and_gate dut (.a(a), .b(b), .y(y));

    integer errors = 0;

initial begin
    a = 0; b = 0; #10;
    if (y !== 0) begin
        $display("FAIL: a=%b b=%b expected y=0 got %b", a, b, y);
        errors = errors + 1;
    end
     a = 1; b = 0; #10;
    if (y !== 0) begin
        $display("FAIL: a=%b b=%b expected y=0 got %b", a, b, y);
        errors = errors + 1;
    end

     a = 0; b = 1; #10;
    if (y !== 0) begin
        $display("FAIL: a=%b b=%b expected y=0 got %b", a, b, y);
        errors = errors + 1;
    end

     a = 1; b = 1; #10;
    if (y !== 1) begin
        $display("FAIL: a=%b b=%b expected y=0 got %b", a, b, y);
        errors = errors + 1;
    end

    // your three remaining cases here

    if (errors == 0)
        $display("PASS: all cases correct");
    else
        $display("FAILED with %0d errors", errors);

    $finish;

    end
endmodule