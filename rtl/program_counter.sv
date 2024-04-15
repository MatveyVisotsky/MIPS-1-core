module programm_counter
(
    input               clk_i           ,
    input               rst_n_i         ,
    input   [31:0]      pc_next_i       ,
    output  [31:0]      pc_o            
);

reg [31:0]  pc_r;

always_ff@(posedge clk_i, negedge rst_n_i) 
begin
    if(!rst_n_i)
        pc_r[31:0] <= 32'h0;
    else 
        pc_r[31:0] <= pc_next_i[31:0];
end

assign pc_o[31:0] = pc_r[31:0];

endmodule 