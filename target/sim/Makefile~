################################################################################
#
# Makefile @[vlsi_flow/acc/sim]
#
################################################################################

default: run



################################################################################
#
# environment setup
#
################################################################################

DESIGN_ROOT = $(abspath $(PWD)/..)

RTL_DIR = $(DESIGN_ROOT)/rtl



################################################################################
#
# Verilog compiler setup
#
################################################################################

VERILOG = vcs

DESIGN_INC_DIR +=

SIM_FLAGS = -q
INC_FLAGS += $(addprefix +incdir+, $(DESIGN_INC_DIR))
DEBUG_FLAGS = -I

VERILOG_FLAGS += -full64 +v2k $(INC_FLAGS) +libext+.v+ $(DEBUG_FLAGS)

vpath %.v $(RTL_DIR)

sim.exe: tb.v acc.v
	$(VERILOG) $(VERILOG_FLAGS) -o $@ $^



################################################################################
#
# execute the simulation
#
################################################################################

SIM_OUTPUT_FILES += sim.out sim.vpd

$(SIM_OUTPUT_FILES): sim.exe
	./$^ -q > $@



################################################################################
#
# user interface
#
################################################################################

run: sim.out

clean:
	rm -f *.exe
	rm -rf csrc *.daidir DVEfiles
	rm -f ucli.key
	rm -f *.vpd
	rm -f sim.out



