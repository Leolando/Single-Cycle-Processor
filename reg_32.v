module reg_32(q, d, clk, en, clr);
   
   //Inputs
   input clk, en, clr;
	input[31:0] d;
   
   wire clr;
	
	
   //Output
   output [31:0] q;
   
   //Register
   
   genvar i;
	generate
       for (i = 0; i < 32; i = i + 1) 
	     begin : reg32
	       dffe_r dffe_i(q[i], d[i], clk, en, clr);
        end
   endgenerate
   
endmodule