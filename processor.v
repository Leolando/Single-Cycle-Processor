/**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB                   // I: Data from port B of regfile
//	 ,pc_now
);
    // Control signals
    input clock, reset;

    // Imem
    output [11:0] address_imem;
    input [31:0] q_imem;

    // Dmem
    output [11:0] address_dmem;
    output [31:0] data;
    output wren;
    input [31:0] q_dmem;

    // Regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;

    /* YOUR CODE STARTS HERE */
	 
	 //qImem instruction
	 
	 
	 // operation control wires
	 wire  ALUinB, Rwd;
	 wire [4:0] ALUop;
	 
	 //operation code decoder
	 wire rtype,addi, sw, lw,j, bne, jal, jr, blt, bex, setx;
	 decoder_op mydecoder(q_imem[31:27], rtype,addi, sw, lw,j, bne, jal, jr, blt, bex, setx);
	 
	 //generating control signal
	 or(ctrl_writeEnable, rtype, addi, lw, jal, setx);
	 assign wren = sw;
	 assign Rwd = lw;
	 or(ALUinB, addi, lw, sw);
	 assign ALUop= rtype?q_imem[6:2]:5'b0;
	 
	 // Instantiate ALU
	 wire [31:0] realInputB;
	 wire [31:0] immediateB;
	 wire [31:0] data_result;
	 assign immediateB = {{15{q_imem[16]}},q_imem[16:0]};
	 assign realInputB = ALUinB? immediateB:data_readRegB;
	 // temp wires
	 wire isNotEqual, isLessThan, overflow;
	 alu my_alu(data_readRegA, realInputB, ALUop,
			q_imem[11:7], data_result, isNotEqual, isLessThan, overflow);
	 
	 //generating register addresses
	 wire readBIsRd;
	 or (readBIsRd, sw, bne, blt, jr); //new****************
	 assign ctrl_readRegA = bex?5'b11110:q_imem[21:17];
	 assign ctrl_readRegB = readBIsRd?q_imem[26:22]:q_imem[16:12];
	 //*************************
	 
	 wire exception, addOrSub, addSub,ofOperation;
	 wire [31:0] pc_now;
	 wire [31:0] pc_plusOne;
	 nor(addOrSub, q_imem[6], q_imem[5], q_imem[4], q_imem[3]); 
	 and(addSub, rtype, addOrSub);
	 or(ofOperation, addSub, addi);
    and(exception, ofOperation,overflow);
	 //new added PC5 *******************
	 wire isToRstatus;
	 or(isToRstatus, exception, setx);
    assign ctrl_writeReg = jal?5'b11111:(isToRstatus?5'b11110:q_imem[26:22]);
	 wire [31:0] signExtentionT;
	 assign signExtentionT = {5'b0,q_imem[26:0]};
	 wire [31:0] exceptionData, normalData, noJumpData, jumpData;
	 assign exceptionData = q_imem[27]?32'd2:(q_imem[2]?32'd3:32'd1);
	 assign normalData = Rwd ? q_dmem:data_result;
	 assign jumpData = jal?pc_plusOne:signExtentionT;
	 assign noJumpData = exception?exceptionData:normalData;
	 wire isJumpReg;
	 or(isJumpReg, setx, jal);
    assign data_writeReg = isJumpReg?jumpData:noJumpData;
	 //setx? signExtentionT:(jal?pc_plusOne:(exception?(q_imem[27]?32'd2:(q_imem[2]?32'd3:32'd1)):(Rwd ? q_dmem:data_result)))
    //************************************
	 
	 //generating data memory addresses
	 assign data = data_readRegB;
	 assign address_dmem = data_result[11:0]; 
	 
	 
	 //******generating pc control signal*****
	 wire isPCjumpT, isPCplusN;
	 wire[31:0] pcNPlusOne;
	 wire bexTrue, bneTrue, bltTrue;
	 wire rstatusNotZero;
	 and(bneTrue, bne, isNotEqual);
	 and(bltTrue, ~isLessThan, isNotEqual, blt);
	 assign rstatusNotZero = data_readRegA?1'b1:1'b0;
	 and(bexTrue, bex, rstatusNotZero);
	 or(isPCjumpT, j,jal,bexTrue);
	 or(isPCplusN, bneTrue, bltTrue);
	 wire isNotEqualPCN, isLessThanPCN, overflowPCN;
	 alu pcPlusN(pc_plusOne, immediateB, 5'b0,
			5'b0, pcNPlusOne, isNotEqualPCN, isLessThanPCN, overflowPCN);
	 wire [31:0]pcPlus;
	 assign pcPlus = isPCplusN? pcNPlusOne:pc_plusOne;
	 //*************
	 
	 //pc 
	 wire isNotEqualPC, isLessThanPC, overflowPC;
	 wire[31:0] pc_next;
	 reg_32 pc(pc_now, pc_next, clock, 1'b1, reset);
	 alu pc_alu(pc_now, 32'b1, 5'b0,
			5'b0, pc_plusOne, isNotEqualPC, isLessThanPC, overflowPC);
	 assign pc_next = jr?data_readRegB:(isPCjumpT?signExtentionT:pcPlus);
	 assign address_imem = pc_now[11:0];

endmodule