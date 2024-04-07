module main_decoder
(
    input   [5:0]       Op_i        ,
    output              MemtoReg_o  ,
    output              MemWrite_o  ,
    output              Branch_o    ,
    output              AluScr_o    ,
    output              RegDst_o    ,
    output              RegWrite_o  ,
    output  [1:0]       AluOp_o     
)

always_comb begin :opcode_decoding
    if(!Op_i) // R-type instruction
    begin
        RegWrite_o = 1;
        RegDst_o = 1;
        AluScr_o = 0;
        Branch_o = 0;
        MemWrite_o = 0;
        MemtoReg_o = 0;
        AluOp_o[1:0] = 2'b10;
    end 
    else if(Op_i == 6'b100011) // lw instruction
    begin 
        RegWrite_o = 1;
        RegDst_o = 0;
        AluScr_o = 1;
        Branch_o = 0;
        MemWrite_o = 0;
        MemtoReg_o = 1;
        AluOp_o[1:0] = 2'b00;
    end
    else if(Op_i == 6'b101011) // sw instruction
    begin 
        RegWrite_o = 0;
        RegDst_o = 0; // acceptable any (= x)
        AluScr_o = 1;
        Branch_o = 0;
        MemWrite_o = 1;
        MemtoReg_o = 0; // acceptable any (= x)
        AluOp_o[1:0] = 2'b00;
    end
    else if (Op_i == 6'b000100) // beq instruction
    begin 
        RegWrite_o = 0;
        RegDst_o = 0; // acceptable any (= x)
        AluScr_o = 0;
        Branch_o = 1;
        MemWrite_o = 0;
        MemtoReg_o = 0; // acceptable any (= x)
        AluOp_o[1:0] = 2'b01;
    end
    else 
    begin 
        RegWrite_o = 0;
        RegDst_o = 0;
        AluScr_o = 0;
        Branch_o = 0;
        MemWrite_o = 0;
        MemtoReg_o = 0;
        AluOp_o[1:0] = 2'b11;
    end    
end 


endmodule:main_decoder