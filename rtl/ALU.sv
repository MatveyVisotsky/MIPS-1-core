module ALU
(
    input           [31:0]      ScrA_i      ,
    input           [31:0]      ScrB_i      ,
    input           [2:0]       AluControl_i,
    output          [31:0]      AluResult_o ,
    output                      Zero_o      
);

logic[31:0] result_w;

localparam ADD  = 3'b010;
localparam SUB  = 3'b110;
localparam AND  = 3'b000;
localparam OR   = 3'b001;
//localparam SLT  = 3'b111;

always_comb 
begin : ALU_core
    case (AluControl_i)
        ADD :   result_w[31:0] = ScrA_i[31:0] + ScrB_i[31:0];
        SUB :   result_w[31:0] = ScrA_i[31:0] - ScrB_i[31:0];
        AND :   result_w[31:0] = ScrA_i[31:0] & ScrB_i[31:0];
        OR  :   result_w[31:0] = ScrA_i[31:0] | ScrB_i[31:0]; 
        default: result_w[31:0] = 32'h0;
    endcase
end

assign Zero_o = (!result_w);
assign AluResult_o[31:0] = result_w[31:0];

endmodule ALU 