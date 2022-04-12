transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Fu\ Yuhao/Nutstore/1/CODE/TaskDDS {C:/Users/Fu Yuhao/Nutstore/1/CODE/TaskDDS/TaskDDS.v}
vlog -vlog01compat -work work +incdir+C:/Users/Fu\ Yuhao/Nutstore/1/CODE/TaskDDS {C:/Users/Fu Yuhao/Nutstore/1/CODE/TaskDDS/AM.v}
vlog -vlog01compat -work work +incdir+C:/Users/Fu\ Yuhao/Nutstore/1/CODE/TaskDDS {C:/Users/Fu Yuhao/Nutstore/1/CODE/TaskDDS/ROM_sin.v}
vlog -vlog01compat -work work +incdir+C:/Users/Fu\ Yuhao/Nutstore/1/CODE/TaskDDS {C:/Users/Fu Yuhao/Nutstore/1/CODE/TaskDDS/MULT_s.v}
vlog -vlog01compat -work work +incdir+C:/Users/Fu\ Yuhao/Nutstore/1/CODE/TaskDDS {C:/Users/Fu Yuhao/Nutstore/1/CODE/TaskDDS/FM.v}
vlog -vlog01compat -work work +incdir+C:/Users/Fu\ Yuhao/Nutstore/1/CODE/TaskDDS {C:/Users/Fu Yuhao/Nutstore/1/CODE/TaskDDS/MODE.v}
vlog -vlog01compat -work work +incdir+C:/Users/Fu\ Yuhao/Nutstore/1/CODE/TaskDDS {C:/Users/Fu Yuhao/Nutstore/1/CODE/TaskDDS/AM_De.v}
vlog -vlog01compat -work work +incdir+C:/Users/Fu\ Yuhao/Nutstore/1/CODE/TaskDDS {C:/Users/Fu Yuhao/Nutstore/1/CODE/TaskDDS/DIVIDE_s.v}
vlog -vlog01compat -work work +incdir+C:/Users/Fu\ Yuhao/Nutstore/1/CODE/TaskDDS {C:/Users/Fu Yuhao/Nutstore/1/CODE/TaskDDS/SINCOS.v}
vlog -vlog01compat -work work +incdir+C:/Users/Fu\ Yuhao/Nutstore/1/CODE/TaskDDS {C:/Users/Fu Yuhao/Nutstore/1/CODE/TaskDDS/SQRT.v}
vlog -vlog01compat -work work +incdir+C:/Users/Fu\ Yuhao/Nutstore/1/CODE/TaskDDS {C:/Users/Fu Yuhao/Nutstore/1/CODE/TaskDDS/filter.v}
vlog -vlog01compat -work work +incdir+C:/Users/Fu\ Yuhao/Nutstore/1/CODE/TaskDDS {C:/Users/Fu Yuhao/Nutstore/1/CODE/TaskDDS/FM_De.v}

vlog -vlog01compat -work work +incdir+C:/Users/Fu\ Yuhao/Nutstore/1/CODE/TaskDDS/simulation/modelsim {C:/Users/Fu Yuhao/Nutstore/1/CODE/TaskDDS/simulation/modelsim/TaskDDS.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  TaskDDS_vlg_tst

add wave *
view structure
view signals
run -all
