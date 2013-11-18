
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name Breakout -dir "/home/brian/Desktop/583final/Breakout/planAhead_run_2" -part xc3s1200eft256-5
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "Top_module.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {Sync.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {BreakRaster.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {VGA_Breakout.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {Top_module.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top Top_module $srcset
add_files [list {Top_module.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s1200eft256-5
