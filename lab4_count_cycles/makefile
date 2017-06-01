PROG=get_cycles

$(PROG):
	gcc -g -m64 -Os -c gett.s
	gcc -g -m64 -Os -c main.c
	gcc -g -m64 -o $(PROG) main.o gett.o

clean:
	rm -f $(PROG) gett.o gett main.o

run: $(PROG)
	./$(PROG)
