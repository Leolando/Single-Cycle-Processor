module decoder_op(opcode,rtype,addi,sw,lw,j, bne, jal, jr, blt, bex, setx);
   
   input [4:0] opcode; 
   output rtype, addi, sw, lw,j, bne, jal, jr, blt, bex, setx;
	wire[4:0] notCode;
	not (notCode[0], opcode[0]);
	not (notCode[1], opcode[1]);
	not (notCode[2], opcode[2]);
	not (notCode[3], opcode[3]);
   not (notCode[4], opcode[4]);

 
   and(rtype, notCode[4],notCode[3],notCode[2],notCode[1],notCode[0]);
	and(addi, notCode[4],notCode[3],opcode[2],notCode[1],opcode[0]);
	and(sw, notCode[4],notCode[3],opcode[2],opcode[1],opcode[0]);
	and(lw, notCode[4],opcode[3],notCode[2],notCode[1],notCode[0]);
	and(j, notCode[4],notCode[3],notCode[2],notCode[1],opcode[0]);
	and(bne, notCode[4],notCode[3],notCode[2],opcode[1],notCode[0]);
	and(jal, notCode[4],notCode[3],notCode[2],opcode[1],opcode[0]);
	and(jr, notCode[4],notCode[3],opcode[2],notCode[1],notCode[0]);
	and(blt, notCode[4],notCode[3],opcode[2],opcode[1],notCode[0]);
	and(bex, opcode[4],notCode[3],opcode[2],opcode[1],notCode[0]);
	and(setx, opcode[4],notCode[3],opcode[2],notCode[1],opcode[0]);
	

	
	
endmodule