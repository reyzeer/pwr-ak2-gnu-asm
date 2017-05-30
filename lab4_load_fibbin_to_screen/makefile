PROG=fib

$(PROG): $(PROG).o
	gcc -g -m64 -c $(PROG).s
	gcc -g -m64 -o $(PROG) $(PROG).o

$(PROG).o: $(PROG).s
	as -g -o $(PROG).o $(PROG).s

clean:
	rm -f $(PROG).o $(PROG) $(PROG).bin

run: $(PROG)
	./$(PROG) >> $(PROG).bin

result:
	hexdump $(PROG).bin

