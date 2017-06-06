PROG=simd

$(PROG):
	gcc -g -m64 -Os -c simd.s
	gcc -g -m64 -Os -c main.c
	gcc -g -m64 -o $(PROG) main.o simd.o

clean:
	rm -f $(PROG) simd.o main.o

run: $(PROG)
	./$(PROG)
