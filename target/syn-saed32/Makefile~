################################################################################
#
# Makefile @[lec02-seq_ckt/rear_light]
#
################################################################################

default: analysis



################################################################################
#
# cell library setup
#
################################################################################

CELL_LIB_ROOT ?= /usr/local/cell_lib
SAED_LIB_DIR = $(CELL_LIB_ROOT)/SAED32_EDK
SAED_SIM_DIR = $(SAED_LIB_DIR)/lib/stdcell_lvt/verilog
CELL_LIB_SIM_DIR = $(SAED_SIM_DIR)
CELL_LIB_SIM_SRC_FILES += $(CELL_LIB_SIM_DIR)/saed32nm_lvt.v



################################################################################
#
# to build the cell library
#
################################################################################

CELL_LIBS += saed32lvt_ff0p85v25c
CELL_LIBS += saed32lvt_pg_ff0p85v25c

DB_FILES += $(addsuffix .db, $(CELL_LIBS))

$(DB_FILES): eda_env.tcl build_lib.tcl
	dc_shell -f build_lib.tcl

build_db: $(DB_FILES)

clean_db:
	rm -f *.db
	rm -f *.log



################################################################################
#
# synthesis the design
#
################################################################################

DESIGN_NAME = acc

SYNTH_TARGETS += $(DESIGN_NAME).netlist.v
SYNTH_TARGETS += $(DESIGN_NAME).ddc
SYNTH_TARGETS += $(DESIGN_NAME).sdc
SYNTH_TARGETS += $(DESIGN_NAME).sdf
SYNTH_TARGETS += $(DESIGN_NAME).spf

SYNTH_REPORTS += $(DESIGN_NAME).area.rpt
SYNTH_REPORTS += $(DESIGN_NAME).timing.rpt

$(SYNTH_TARGETS) $(SYNTH_REPORTS): synthesis.tcl $(DB_FILES)
	dc_shell -f synthesis.tcl

synth: $(SYNTH_TARGETS) $(SYNTH_REPORTS)

clean_synth:
	rm -f $(SYNTH_TARGETS)
	rm -f $(SYNTH_REPORTS)



################################################################################
#
# pre-layout simulation
#
################################################################################

VERILOG = vcs

DESIGN_INC_DIR +=

SIM_FLAGS = -q
INC_FLAGS += $(addprefix +incdir+, $(DESIGN_INC_DIR))
DEBUG_FLAGS = -I

VERILOG_FLAGS += -full64 +v2k $(INC_FLAGS) 
VERILOG_FLAGS += -v $(CELL_LIB_SIM_SRC_FILES)
VERILOG_FLAGS += $(DEBUG_FLAGS)

sim.exe: tb.v $(DESIGN_NAME).netlist.v
	$(VERILOG) $(VERILOG_FLAGS) $^ -o $@ 

sim.out sim.vpd: sim.exe
	./sim.exe > sim.out



################################################################################
#
# prime time analysis
#
################################################################################

ANALYSIS_OUT_FILES += $(DESIGN_NAME).ptime.rpt
ANALYSIS_OUT_FILES += $(DESIGN_NAME).power.rpt

$(ANALYSIS_OUT_FILES): analysis.tcl sim.vpd
	pt_shell -f analysis.tcl

analysis: $(ANALYSIS_OUT_FILES)

clean_analysis:
	rm -f $(ANALYSIS_OUT_FILES)



################################################################################
#
# user interface
#
################################################################################

clean: clean_db clean_synth clean_analysis
	rm -f *.exe
	rm -f *.out
	rm -f *.vpd
	rm -rf *.exe.daidir
	rm -rf csrc
	rm -rf DVEfiles
	rm -f ucli.key
	rm -f default.svf

