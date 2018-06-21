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
TSMC40_LIB_DIR = $(CELL_LIB_ROOT)/CBDK_TSMC40_Arm_v0.5
TSMC40_SIM_DIR = $(TSMC40_LIB_DIR)/CIC/Verilog
CELL_LIB_SIM_DIR = $(TSMC40_SIM_DIR)
CELL_LIB_SIM_SRC_FILES += $(CELL_LIB_SIM_DIR)/sc9_cln40g_base_lvt.v
CELL_LIB_SIM_SRC_FILES += $(CELL_LIB_SIM_DIR)/sc9_cln40g_base_lvt_udp.v



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
VERILOG_FLAGS += +neg_tchk
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

$(ANALYSIS_OUT_FILES): analysis.pt.tcl sim.vpd
	pt_shell -f analysis.pt.tcl

analysis: $(ANALYSIS_OUT_FILES)

clean_analysis:
	rm -f $(ANALYSIS_OUT_FILES)



################################################################################
#
# user interface
#
################################################################################

clean: clean_synth clean_analysis
	rm -f *.exe
	rm -f *.out
	rm -f *.vpd
	rm -rf *.exe.daidir
	rm -rf csrc
	rm -rf DVEfiles
	rm -f ucli.key
	rm -f default.svf
	rm -f *.log

