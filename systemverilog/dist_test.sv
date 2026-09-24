module dist_test;

    class Op;
        rand bit [1:0] op;
        constraint c_op { op dist { 0 := 1, 1 := 2, 2 := 3, 3 := 4};}
    endclass

    Op x;
    int count[4];

    initial begin
        x = new();
        repeat (1000) begin
            if (!x.randomize() with {op != 0; }) $fatal("randomize failed");
            count[x.op]++;
        end
        foreach (count[i])
            $display("op=%0d count=%0d", i, count[i])  ;
    end
endmodule   

// Note: with an inline `op != 0` constraint, XSim ignored the dist
// weights and produced a near-uniform 1/2/3 mix. dist weights are only
// guaranteed absent other constraints — measure, don't assume.