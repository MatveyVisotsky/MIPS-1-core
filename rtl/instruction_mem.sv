module instruction_mem
(
    input   [31:0]      address_i         ,
    output  [31:0]      instruction_o  
);

reg [31:0] instr_mem_r[31:0];

assign instruction_o[31:0] = instr_mem_r[address_i];
    
endmodule