module alu_decoder (
    input   [1:0]       AluOp_i     ,
    input   [5:0]       funct_i     ,
    output  [2:0]       AluControl_o
);

localparam  add = 6'b100000;
localparam  sub = 6'b100010;
localparam  and = 6'b100100;
localparam  or  = 6'b100101;
localparam  slt = 6'b101010;

always_comb
begin
    if(!AluOp_i)
    begin
        AluControl_o = 3'b010; // + 
    end
    else if (AluOp_i[0])
    begin
        AluControl_o = 3'b110; // - 
    end
    else if(AluOp_i[1])
    begin
        case(funct_i):
            add :   AluControl_o    =   3'b010; 
            sub :   AluControl_o    =   3'b110; 
            and :   AluControl_o    =   3'b000; 
            or  :   AluControl_o    =   3'b001;
            slt :   AluControl_o    =   3'b111;
            default:AluControl_o    =   3'b010;
        endcase
    end
    else AluControl_o   =   3'b010;
end 
    
endmodule
