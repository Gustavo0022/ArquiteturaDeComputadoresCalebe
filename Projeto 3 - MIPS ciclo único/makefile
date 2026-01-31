#Vars
IVERILOG = iverilog
VVP = VVP
GTKW = gtkwave
TB = MIPS_tb.v
EXEC = MIPS.vvp
VCD = MIPS.vcd
TOP = MIPS.v
ALU = $(wildcard ./ULA/*.v)
CONTROL = $(wildcard ./ControleEFluxo/*.v)
MUXETC = $(wildcard ./MuxesEtc/*.v)
MEM = $(wildcard ./Memoria/*.v)



.PHONY: all compile run comprun view clean

all: compile run view

compile: $(DUT)
	$(IVERILOG) -o $(EXEC) $(CONTROL) $(MUXETC) $(MEM) $(ALU) $(TOP) $(TB)

run:	$(EXEC)
	vvp $(EXEC)

comprun: compile run

view: $(VCD)
	$(GTKW) $(VCD)

clean: 
	rm $(VCD) $(EXEC)
