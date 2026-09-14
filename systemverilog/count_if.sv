interface count_if (input logic clk);
    logic   rst_n;
    logic   en;
    logic [3:0] count;

    clocking cb @(posedge clk);
        output rst_n, en;
        input count;
    endclocking
endinterface //