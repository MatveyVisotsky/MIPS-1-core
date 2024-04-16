module core 
(
    input               clk_i  ,
    input               rst_n_i      
);

//PC
wire [31:0] pc_core_w;
wire [31:0] pc_next_core_w;

//control unit
wire[2:0] alu_control_core_w;
wire cu_branch_core_w;
wire cu_mem_to_reg_core_w;
wire cu_mem_write_core_w;
wire cu_alu_scr_core_w;
wire cu_reg_write_core_w;
wire cu_reg_dst_core_w;

//regfile
wire[31:0] reg_data1_core_w;
wire[31:0] reg_data2_core_w;
wire[31:0] reg_write_data_core_w;
wire[31:0] reg_write_addr_core_w;


//alu
wire[31:0] alu_result_core_w;
wire zero_flag_core_w;

//data mem
wire [31:0] read_data_core_w;

//wires 
wire [31:0] sign_extension_core_w;
assign sign_extension_core_w[31:0] = {{16{instruction_core_w[15]}}, instruction_core_w[15:0]};

wire[31:0] alu_scrB_core_w;
assign alu_scrB_core_w = (cu_alu_scr_core_w)? sign_extension_core_w : reg_data2_core_w;

wire[31:0] pc_plus_4_core_w;
assign pc_plus_4_core_w[31:0] = pc_core_w[31:0] + 32'h4;

wire[31:0] sign_extension_mult_4_core_w;
assign sign_extension_mult_4_core_w[31:0] = sign_extension_core_w[31:0] << 2;

wire[31:0] pc_branch_core_w;
assign pc_branch_core_w[31:0] = sign_extension_mult_4_core_w[31:0] + pc_plus_4_core_w[31:0];

assign pc_next_core_w = (zero_flag_core_w && cu_branch_core_w)?  pc_branch_core_w : pc_plus_4_core_w;

assign reg_write_data_core_w = (cu_mem_to_reg_core_w)? read_data_core_w : alu_result_core_w;

assign reg_write_addr_core_w = (cu_reg_dst_core_w)? instruction_core_w[15:11] : instruction_core_w[20:16];

programm_counter pc(
    .clk_i          (clk_i              ),
    .rst_n_i        (rst_n_i            ),
    .pc_next_i      (pc_next_core_w     ),
    .pc_o           (pc_core_w          )
);

wire[31:0] instruction_core_w;
instruction_mem instr_mem(
    .address_i      (pc_core_w          ),
    .instruction_o  (instruction_core_w )
);



control_unit control_unit(
    .funct_i     (instruction_core_w[5:0]       ),
    .AluControl_o(alu_control_core_w            ),
    .Op_i        (instruction_core_w[31:26]     ),
    .MemtoReg_o  (cu_mem_to_reg_core_w          ),
    .MemWrite_o  (cu_mem_write_core_w           ),
    .Branch_o    (cu_branch_core_w              ),
    .AluScr_o    (cu_alu_scr_core_w             ),
    .RegDst_o    (cu_reg_dst_core_w             ),
    .RegWrite_o  (cu_reg_write_core_w           )
);

data_mem data_mem(
    .clk_i          (clk_i                      ),
    .write_en_i     (cu_mem_write_core_w        ),
    .write_data_i   (reg_data2_core_w           ),
    .address_i      (alu_result_core_w          ),
    .read_data_o    (read_data_core_w           )
);



regfile regfile(
    .clk_i         (clk_i                       ),
    .raddr1_i      (instruction_core_w[25:21]   ),
    .raddr2_i      (instruction_core_w[20:16]   ),
    .waddr_i       (reg_write_addr_core_w       ),
    .write_data_i  (reg_write_data_core_w       ),
    .reg_data1_o   (reg_data1_core_w            ),
    .reg_data2_o   (reg_data2_core_w            ),
    .reg_write_en_i(cu_reg_write_core_w         )
);

ALU alu(
    .ScrA_i      (reg_data1_core_w              ),
    .ScrB_i      (alu_scrB_core_w               ),
    .AluControl_i(alu_control_core_w            ),
    .AluResult_o (alu_result_core_w             ),
    .Zero_o      (zero_flag_core_w              )
);


endmodule