################################################################################
#
# script for logical synthesis of the accumulator
#
################################################################################

################################################################################
#
# environment setup
#
################################################################################

#directories for EDA-tools and cell library
source eda_env.tcl
set cell_lib_path "$CELL_LIB_DB_DIR/sc9_base_lvt"

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

set target_library sc9_cln40g_base_lvt_tt_typical_max_0p90v_25c.db
set link_library "* $cell_lib_path/$target_library"

################################################################################
#
# read design files
#
################################################################################

read_file -format verilog acc.v



################################################################################
#
# define the design environment
#
################################################################################

set_operating_conditions tt_typical_max_0p90v_25c
set_wire_load_model -name "Small"



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
# compile the design and report
#
################################################################################

compile -only_design_rule -incremental_mapping

report_area > acc.area.rpt
report_timing > acc.timing.rpt
report_constraint -all_violators

write_file -format ddc -output acc.ddc
write_file -format verilog -hierarchy -output acc.netlist.v
write_sdc acc.sdc
write_parasitics -output acc.spf
write_sdf acc.sdf

exit

















