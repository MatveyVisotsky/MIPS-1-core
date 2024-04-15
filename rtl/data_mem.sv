module data_mem 
(
    input               clk_i       ,
//    input               rst_n_i     ,
    input               write_en_i  ,
    input   [31:0]      write_data_i,
    input   [31:0]      address_i   ,
    output  [31:0]      read_data_o
);

reg [31:0]  dmem_r[31:0];

always_ff@(posedge clk_i/*, negedge rst_n_i*/)
begin 
    if(write_en_i)
        dmem_r[address_i] <= write_data_i[31:0];
end 

assign read_data_o[31:0] = dmem_r[address_i];
    
endmodule