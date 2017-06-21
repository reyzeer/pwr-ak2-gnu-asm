PROG=cache

$(PROG):
	#gcc -g -m64 -Os -c integral_asm.s
	#gcc -g -m64 -Os -c integral_asm_k.s
	gcc -g -m64 -c gett.s
	gcc -g -m64 -c main.c
	gcc -g -m64 -o $(PROG) main.o gett.o #integral_asm.o integral_asm_k.o

clean:
	rm -f $(PROG) main.o gett.o #integral_asm.o integral_asm_k.o 

run: $(PROG)
	./$(PROG)
