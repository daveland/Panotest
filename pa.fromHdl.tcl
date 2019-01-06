
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name testpano -dir "/home/ise/daveland/github/Panotest/planAhead_run_5" -part xc6slx150fgg484-2
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "toplevel.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {ipcore_dir/pll2.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {utils_pack.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {simple_counter.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {toplevel.vhdl}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top toplevel $srcset
add_files [list {toplevel.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc6slx150fgg484-2
