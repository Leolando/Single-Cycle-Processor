module regfile (
    clock,
    ctrl_writeEnable,
    ctrl_reset, ctrl_writeReg,
    ctrl_readRegA, ctrl_readRegB, data_writeReg,
    data_readRegA, data_readRegB
	 ,r1,r30,r31
);

   input clock, ctrl_writeEnable, ctrl_reset;
   input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
   input [31:0] data_writeReg;

   output [31:0] data_readRegA, data_readRegB;
	output [31:0] r1,r30,r31;
		//registers
	wire [31:0] reg_out[31:0];

   /* YOUR CODE HERE */
	assign r1 = reg_out[1];
//   assign r2 = reg_out[2];
//   assign r3 = reg_out[3];
//	assign r4 = reg_out[4];
//	assign r5 = reg_out[5];
//   assign r28 = reg_out[28];
//   assign r29 = reg_out[29];
   assign r30 = reg_out[30];
	assign r31 = reg_out[31];
	
	//writing
	wire [31:0] wr_sel;
	wire [31:0] wr_en;
	dec5to32 write_decode(wr_sel, ctrl_writeReg);
	genvar i;
	generate
       for (i = 0; i < 32; i = i + 1) 
	     begin : wrEnable
	       and(wr_en[i], wr_sel[i], ctrl_writeEnable);
        end
   endgenerate
	
	

	generate
       for (i = 0; i < 32; i = i + 1) 
	     begin : register
	       reg_32 reg_i(reg_out[i], data_writeReg[31:0], clock, wr_en[i], ctrl_reset);
        end
   endgenerate
	
	//reading
	wire[31:0] dA_sel;
	wire[31:0] dB_sel;
	dec5to32 readA_decode(dA_sel, ctrl_readRegA);
	dec5to32 readB_decode(dB_sel, ctrl_readRegB);
	
	genvar j;
	generate
       for (i = 0; i < 32; i = i + 1) 
	     begin : readnTristate
		    assign data_readRegA[31:0] =dA_sel[0]?32'b0:(dA_sel[i] ? reg_out[i] : 32'bz);
			 assign data_readRegB[31:0] =dB_sel[0]?32'b0:(dB_sel[i] ? reg_out[i] : 32'bz);
        end
   endgenerate
endmodule
