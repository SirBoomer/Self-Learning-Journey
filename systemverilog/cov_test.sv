module cov_test;

    bit [7:0] addr;


    covergroup cg;
        coverpoint addr {
            bins low =  {[0:63]};
            bins mid =  {[64:191]};
            bins high = {[192:255]};
            bins max = {255};
        }
    endgroup

    cg c=new();

    initial begin
        int n = 0;
        while (c.get_coverage() < 100) begin
            addr = $urandom_range(0,255);
            c.sample();
            n++;
        end
        $display("100%% coverage after %0d samples", n);
    end

endmodule
