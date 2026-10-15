module cov_test;

    bit [7:0] addr;
    bit wr;


    covergroup cg;
        cp_addr: coverpoint addr {
            bins low =  {[0:63]};
            bins mid =  {[64:191]};
            bins high = {[192:255]};
            bins max = {255};
        }
        cp_wr:  coverpoint wr;
        x_addr_wr: cross cp_addr, cp_wr {
            illegal_bins no_write_max = binsof(cp_addr.max) && binsof(cp_wr) intersect {1};
        }
    endgroup

    cg c=new();

    initial begin
        int n = 0;
        while (c.get_coverage() < 100) begin
            if (!std::randomize(addr, wr) with {
                    addr dist { 255 := 25, [0:254] := 1 };
                    addr == 255 -> wr == 0;
                }) $fatal(1, "randomize failed");
            c.sample();
            n++;
        end
        $display("100%% coverage after %0d samples", n);
    end

endmodule
