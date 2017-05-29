GET_CYCLES=get_cycles
PROG2=memory_test

$(GET_CYCLES):
	gcc -g -m64 -Os -c $(GET_CYCLES).s
	gcc -g -m64 -Os -c main.c
	gcc -g -m64 -o $(GET_CYCLES) main.o $(GET_CYCLES).o

clean:
	rm -f $(SIMPLE_CODE).o $(SIMPLE_CODE) $(GET_CYCLES).o $(GET_CYCLES) $(PROG2).o $(PROG2).s

run: $(SIMPLE_CODE)
	./$(SIMPLE_CODE)

$(PROG2): $(PROG2).o
	ld -o $(PROG2) $(PROG2).o

$(PROG2).o: $(PROG2).s
	as -g -o $(PROG2).o $(PROG2).s

run_sc: $(SIMPLE_CODE)
	./$(SIMPLE_CODE)

