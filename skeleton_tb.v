// ---------- SAMPLE TEST BENCH ----------
`timescale 1 ns / 100 ps
module skeleton_tb();
// inputs to the DUT are reg type
reg clock, reset;

// outputs from the DUT are wire type
wire imem_clock, dmem_clock, processor_clock, regfile_clock;

// Tracking the number of errors
integer errors;
integer index; // for testing...

// instantiate the DUT
/*module regfile (
clock,
ctrl_writeEnable,
ctrl_reset, ctrl_writeReg,
ctrl_readRegA, ctrl_readRegB, data_writeReg,
data_readRegA, data_readRegB
);*/
skeleton s1(clock, reset, imem_clock, dmem_clock, processor_clock, regfile_clock);

// setting the initial values of all the reg
initial
begin
$display($time, " << Starting the Simulation >>");
clock = 1'b0; // at time 0
errors = 0;

reset = 1'b1; // assert reset
#30 reset = 1'b0; // toggle
#100000
$stop;
end

// Clock generator
always
#10 clock = ~clock; // toggle

// Task for writing

endmodule
