################################################################################
#
# script to analyze timing and power using PrimeTimePX
#
################################################################################

set power_enable_analysis TRUE
set power_analysis_mode averaged

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

#set the library
set target_library sc9_cln40g_base_lvt_tt_typical_max_0p90v_25c.db
set link_library "* $cell_lib_path/$target_library"


################################################################################
#
# read design and simulation data
#
################################################################################

#read the netlist
read_verilog acc.netlist.v
current_design acc
link

#read support data to the design
read_sdc acc.sdc
read_parasitics acc.spf
read_vcd sim.vpd -strip_path tb/u_target

################################################################################
#
# check timing
#
################################################################################

report_timing > acc.ptime.rpt

################################################################################
#
# report power
#
################################################################################

report_power > acc.power.rpt

exit


