module regfile
(
    input               clk_i           ,
    input   [4:0]       raddr1_i        ,
    input   [4:0]       raddr2_i        ,
    input   [4:0]       waddr_i         ,
    input   [31:0]      write_data_i    ,
    output  [31:0]      reg_data1_o     ,
    output  [31:0]      reg_data2_o     ,
    input               reg_write_en_i
);

reg[31:0] registers_r[4:0];

always_ff@(posedge clk_i)
begin 
    if(reg_write_en_i)
        registers_r[waddr_i] <= write_data_i[31:0];
end 

assign reg_data1_o[31:0] = registers_r[raddr1_i];
assign reg_data2_o[31:0] = registers_r[raddr2_i];

endmodule