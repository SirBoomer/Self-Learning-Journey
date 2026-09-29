module solve_test;

    class Sv;
        rand    bit         s;
        rand    bit [3:0]   d;
        constraint c { s -> d ==0; }
        constraint order { solve d before s; }
    endclass

    Sv x;
    int ones = 0;

    initial begin
        x=new();
        repeat (1000) begin
            if (!x.randomize()) $fatal (1, "randomized failed");
            if (x.s) ones++;
        end
        $display("WITH SOLVE-BEFORE: s=1 happened %0d times out of 1000", ones);
    end
endmodule

// XSim 2026.1 ignores solve...before: s=1 was 475/1000 with and
// without it. Standard-compliant solvers give ~59 without, ~31 with.