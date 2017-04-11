PROG=load_hex_number
hello: $(PROG).o
	ld -o $(PROG) $(PROG).o

hello.o: hello.s
	as -g -o $(PROG).o $(PROG).s

clean:
	rm -f $(PROG).o $(PROG)

run: hello
	./$(PROG)

