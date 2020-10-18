######################################
# Makefile
# Author:  Chad Coates (crcoates@pdx.edu)
######################################

CC=iverilog
CFLAGS=-g2012 
BIN=scoreboard
SRC=tb_Scoreboard_v2.sv Scoreboard.sv bcd_counter_2digit.sv sseg_encoder.sv input_logic.sv clk_divider.sv 

$(BIN): $(SRC) 
	$(CC) $(CFLAGS) -o $(BIN) $(SRC)

run:
	./$(BIN)

clean:
	rm $(BIN)
