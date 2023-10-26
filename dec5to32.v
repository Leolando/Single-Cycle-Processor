module dec5to32(out,adr);
   
   input [4:0] adr; 
   output [31:0] out;
	wire[4:0] notAdr;
	not (notAdr[0], adr[0]);
	not (notAdr[1], adr[1]);
	not (notAdr[2], adr[2]);
	not (notAdr[3], adr[3]);
   not (notAdr[4], adr[4]);

 
   and(out[0], notAdr[4],notAdr[3],notAdr[2],notAdr[1],notAdr[0]);
	and(out[1], notAdr[4],notAdr[3],notAdr[2],notAdr[1],adr[0]);
	and(out[2], notAdr[4],notAdr[3],notAdr[2],adr[1],notAdr[0]);
	and(out[3], notAdr[4],notAdr[3],notAdr[2],adr[1],adr[0]);
	and(out[4], notAdr[4],notAdr[3],adr[2],notAdr[1],notAdr[0]);
	and(out[5], notAdr[4],notAdr[3],adr[2],notAdr[1],adr[0]);
	and(out[6], notAdr[4],notAdr[3],adr[2],adr[1],notAdr[0]);
	and(out[7], notAdr[4],notAdr[3],adr[2],adr[1],adr[0]);
	and(out[8], notAdr[4],adr[3],notAdr[2],notAdr[1],notAdr[0]);
	and(out[9], notAdr[4],adr[3],notAdr[2],notAdr[1],adr[0]);
	and(out[10], notAdr[4],adr[3],notAdr[2],adr[1],notAdr[0]);
	and(out[11], notAdr[4],adr[3],notAdr[2],adr[1],adr[0]);
	and(out[12], notAdr[4],adr[3],adr[2],notAdr[1],notAdr[0]);
	and(out[13], notAdr[4],adr[3],adr[2],notAdr[1],adr[0]);
	and(out[14], notAdr[4],adr[3],adr[2],adr[1],notAdr[0]);
	and(out[15], notAdr[4],adr[3],adr[2],adr[1],adr[0]);
	and(out[16], adr[4],notAdr[3],notAdr[2],notAdr[1],notAdr[0]);
	and(out[17], adr[4],notAdr[3],notAdr[2],notAdr[1],adr[0]);
	and(out[18], adr[4],notAdr[3],notAdr[2],adr[1],notAdr[0]);
	and(out[19], adr[4],notAdr[3],notAdr[2],adr[1],adr[0]);
	and(out[20], adr[4],notAdr[3],adr[2],notAdr[1],notAdr[0]);
	and(out[21], adr[4],notAdr[3],adr[2],notAdr[1],adr[0]);
	and(out[22], adr[4],notAdr[3],adr[2],adr[1],notAdr[0]);
	and(out[23], adr[4],notAdr[3],adr[2],adr[1],adr[0]);
	and(out[24], adr[4],adr[3],notAdr[2],notAdr[1],notAdr[0]);
	and(out[25], adr[4],adr[3],notAdr[2],notAdr[1],adr[0]);
	and(out[26], adr[4],adr[3],notAdr[2],adr[1],notAdr[0]);
	and(out[27], adr[4],adr[3],notAdr[2],adr[1],adr[0]);
	and(out[28], adr[4],adr[3],adr[2],notAdr[1],notAdr[0]);
	and(out[29], adr[4],adr[3],adr[2],notAdr[1],adr[0]);
	and(out[30], adr[4],adr[3],adr[2],adr[1],notAdr[0]);
	and(out[31], adr[4],adr[3],adr[2],adr[1],adr[0]);
	
	
endmodule
