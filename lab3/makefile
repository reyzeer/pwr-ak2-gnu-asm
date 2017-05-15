PROG=fib
PROG2=memory_test

$(PROG): $(PROG).o
	ld -o $(PROG) $(PROG).o

$(PROG).o: $(PROG).s
	as -g -o $(PROG).o $(PROG).s

clean:
	rm -f $(PROG).o $(PROG) $(PROG2).o $(PROG2).s

run: $(PROG)
	./$(PROG)

$(PROG2): $(PROG2).o
	ld -o $(PROG2) $(PROG2).o

$(PROG2).o: $(PROG2).s
	as -g -o $(PROG2).o $(PROG2).s

run_memory: $(PROG)
	./$(PROG)

