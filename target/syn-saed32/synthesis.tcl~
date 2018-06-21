################################################################################
#
# synthesis script @[vlsi_flow/acc/syn-saed32]
#
################################################################################



################################################################################
#
# environment setup
#
################################################################################

#directories for EDA-tools and cell library
source eda_env.tcl
set cell_lib_path "$STDCELL_DB_DIR"

#directory of RTL source code
set work_dir ".."
set rtl_dir "$work_dir/rtl"

#the search path for everything
set search_path " ., $cell_lib_path, $rtl_dir"



################################################################################
#
# setup the library
#
################################################################################

set target_library ./saed32lvt_ff0p85v25c.db
set link_library "* $target_library"



################################################################################
#
# read design files
#
################################################################################

read_file -format verilog acc.v

current_design acc

set design_name "acc"


################################################################################
#
# define the design environment
#
################################################################################

set_operating_conditions ff0p85v25c
set_wire_load_model -name "8000"



################################################################################
#
# set design constraints
#
################################################################################

create_clock -name clk -period 10 [get_ports clk]
set_dont_touch_network [get_clocks clk]
set_fix_hold [get_clocks clk]



################################################################################
#
# compile the design
#
################################################################################

compile -only_design_rule -incremental_mapping

write_file -format verilog -hierarchy -output $design_name.netlist.v
write_file -format ddc -output $design_name.ddc
write_sdc $design_name.sdc
write_parasitics -output $design_name.spf
write_sdf $design_name.sdf



################################################################################
#
# report design
#
################################################################################

report_area > $design_name.area.rpt
report_timing > $design_name.timing.rpt
report_constraint -all_violators

exit

















