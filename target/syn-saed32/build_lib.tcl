################################################################################
#
# EDA script: [build_lib.tcl]
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
#set work_dir ".."
set rtl_dir "$SRC_ROOT/trial_pgate_flow/acc"

#the search path for everything
set search_path " ., $cell_lib_path "



################################################################################
#
# build my library for synthesis
#
################################################################################

enable_write_lib_mode

read_lib saed32lvt_ff0p85v25c.lib
read_lib saed32lvt_pg_ff0p85v25c.lib

write_lib saed32lvt_ff0p85v25c -format db
write_lib saed32lvt_pg_ff0p85v25c -format db

exit











