#Vars
IVERILOG = iverilog
VVP = VVP
GTKW = gtkwave
DUT = alu_32.v
TB = tb_alu_32.v
EXEC = ALU.vvp
VCD = ALU.vcd

.PHONY: all compile run comprun view clean

all: compile run view

compile: $(DUT)
	$(IVERILOG) -o $(EXEC) full_adder_1bit.v full_adder_8bit.v full_adder_32bit.v $(DUT) $(TB)

run:	$(EXEC)
	./$(EXEC)

comprun: compile run

view: $(VCD)
	$(GTKW) $(VCD)

clean: 
	rm -f $(VCD) $(EXEC)
