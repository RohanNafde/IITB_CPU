transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/anway/OneDrive/Desktop/IITB_CPU-main/SE_RSE.vhd}
vcom -93 -work work {C:/Users/anway/OneDrive/Desktop/IITB_CPU-main/RF.vhd}
vcom -93 -work work {C:/Users/anway/OneDrive/Desktop/IITB_CPU-main/MUX_DEMUX.vhd}
vcom -93 -work work {C:/Users/anway/OneDrive/Desktop/IITB_CPU-main/Memory.vhd}
vcom -93 -work work {C:/Users/anway/OneDrive/Desktop/IITB_CPU-main/IITB_CPU.vhd}
vcom -93 -work work {C:/Users/anway/OneDrive/Desktop/IITB_CPU-main/FSM.vhd}
vcom -93 -work work {C:/Users/anway/OneDrive/Desktop/IITB_CPU-main/DUT.vhd}
vcom -93 -work work {C:/Users/anway/OneDrive/Desktop/IITB_CPU-main/CU.vhd}
vcom -93 -work work {C:/Users/anway/OneDrive/Desktop/IITB_CPU-main/ALU.vhd}

vcom -93 -work work {C:/Users/anway/OneDrive/Desktop/IITB_CPU-main/Testbench.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  Testbench

add wave *
view structure
view signals
run -all
