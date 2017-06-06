PROG=fpuprog

$(PROG):
	gcc -g -m64 -Os -c f.s
	gcc -g -m64 -Os -c g.s
	gcc -g -m64 -Os -c main.c
	gcc -g -m64 -o $(PROG) main.o f.o g.o

clean:
	rm -f $(PROG) f.o main.o g.o 

run: $(PROG)
	./$(PROG)
