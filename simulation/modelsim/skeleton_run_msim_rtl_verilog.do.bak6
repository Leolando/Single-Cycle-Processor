transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/intelFPGA_lite/17.0/ECE550/Cp4 {E:/intelFPGA_lite/17.0/ECE550/Cp4/dmem.v}
vlog -vlog01compat -work work +incdir+E:/intelFPGA_lite/17.0/ECE550/Cp4 {E:/intelFPGA_lite/17.0/ECE550/Cp4/imem.v}
vlog -vlog01compat -work work +incdir+E:/intelFPGA_lite/17.0/ECE550/Cp4 {E:/intelFPGA_lite/17.0/ECE550/Cp4/skeleton.v}
vlog -vlog01compat -work work +incdir+E:/intelFPGA_lite/17.0/ECE550/Cp4 {E:/intelFPGA_lite/17.0/ECE550/Cp4/processor.v}
vlog -vlog01compat -work work +incdir+E:/intelFPGA_lite/17.0/ECE550/Cp4 {E:/intelFPGA_lite/17.0/ECE550/Cp4/decoder_op.v}
vlog -vlog01compat -work work +incdir+E:/intelFPGA_lite/17.0/ECE550/Cp4 {E:/intelFPGA_lite/17.0/ECE550/Cp4/regfile.v}
vlog -vlog01compat -work work +incdir+E:/intelFPGA_lite/17.0/ECE550/Cp4 {E:/intelFPGA_lite/17.0/ECE550/Cp4/clock_divider_by4.v}
vlog -vlog01compat -work work +incdir+E:/intelFPGA_lite/17.0/ECE550/Cp4 {E:/intelFPGA_lite/17.0/ECE550/Cp4/alu.v}
vlog -vlog01compat -work work +incdir+E:/intelFPGA_lite/17.0/ECE550/Cp4 {E:/intelFPGA_lite/17.0/ECE550/Cp4/reg_32.v}
vlog -vlog01compat -work work +incdir+E:/intelFPGA_lite/17.0/ECE550/Cp4 {E:/intelFPGA_lite/17.0/ECE550/Cp4/dffe.v}
vlog -vlog01compat -work work +incdir+E:/intelFPGA_lite/17.0/ECE550/Cp4 {E:/intelFPGA_lite/17.0/ECE550/Cp4/dec5to32.v}

vlog -vlog01compat -work work +incdir+E:/intelFPGA_lite/17.0/ECE550/Cp4 {E:/intelFPGA_lite/17.0/ECE550/Cp4/skeleton_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  skeleton_tb

add wave *
view structure
view signals
run -all
