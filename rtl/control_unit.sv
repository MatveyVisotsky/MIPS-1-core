module  control_unit
(
    input   [5:0]       funct_i     ,
    output  [2:0]       AluControl_o,
    input   [5:0]       Op_i        ,
    output              MemtoReg_o  ,
    output              MemWrite_o  ,
    output              Branch_o    ,
    output              AluScr_o    ,
    output              RegDst_o    ,
    output              RegWrite_o  
);

wire [1:0]  AluOp_w;

alu_decoder alu_decoder(
    .AluOp_i        (AluOp_w        ),
    .funct_i        (funct_i        ),
    .AluControl_o   (AluControl_o   )
);

main_decoder main_decoder(
    .Op_i           (Op_i           ),
    .MemtoReg_o     (MemtoReg_o     ),
    .MemWrite_o     (MemWrite_o     ),
    .Branch_o       (Branch_o       ),
    .AluScr_o       (AluScr_o       ),
    .RegDst_o       (RegDst_o       ),
    .RegWrite_o     (RegWrite_o     ),
    .AluOp_o        (AluOp_w        )
);

endmodule
