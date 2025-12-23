#Vars
IVERILOG = iverilog
VVP = VVP
GTKW = gtkwave
DUT = ALU.v
TB = ALU_tb.v
EXEC = ALU.vvp
VCD = ALU.vcd

.PHONY: all compile run view clean

all: compile run view

compile: $(DUT)
	$(IVERILOG) -o $(EXEC) somador1bit.v somador8bit.v somador32bit.v $(DUT) $(TB)

run:	$(EXEC)
	./$(EXEC)

view: $(VCD)
	$(GTKW) $(VCD)

clean: 
	rm -f $(VCD) $(EXEC)
