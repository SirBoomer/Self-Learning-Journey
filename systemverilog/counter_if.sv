module counter_if (count_if cif);

    always_ff @(posedge cif.clk) begin
        if (!cif.rst_n)
        cif.count <= 4'd0;
    else if (cif.en)
        cif.count <= cif.count + 1'b1;
    end
endmodule