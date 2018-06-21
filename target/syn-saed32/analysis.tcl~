################################################################################
#
# PrimeTime script: [vlsi_flow/acc/syn-saed32/analysis.tcl]
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
source ./eda_env.tcl

#directory of RTL source code
set design_root ".."
set design_src_dir "$design_root/rtl"

#the search path for everything
set search_path " . $design_src_dir"

#set the library
set target_library "./saed32lvt_ff0p85v25c.db ./saed32lvt_pg_ff0p85v25c.db"

set link_library "* $target_library"


################################################################################
#
# read design and simulation data
#
################################################################################

#read the netlist
set DESIGN_NAME acc

read_verilog $DESIGN_NAME.netlist.v
current_design acc
link

#read support data to the design
read_sdc $DESIGN_NAME.sdc
read_parasitics $DESIGN_NAME.spf
read_vcd sim.vpd -strip_path tb/u_target

################################################################################
#
# check timing
#
################################################################################

set OUTPUT $DESIGN_NAME

check_timing
report_timing > $OUTPUT.ptime.rpt

################################################################################
#
# report power
#
################################################################################

check_power
report_power > $OUTPUT.power.rpt

exit

