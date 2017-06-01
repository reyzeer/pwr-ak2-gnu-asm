PROG=fpu
	
$(PROG):
	gcc -g -o $(PROG) $(PROG).s

run:
	./$(PROG)

debug:
	gdb -x .gdb $(PROG)

rebuild: clean build

clean:
	rm -f $(PROG) $(PROG).o *~

all:
	clean build run
