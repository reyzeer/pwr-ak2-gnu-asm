PROG=parallel

$(PROG):
	gcc -g -m64 -Os -c integral_asm.s
	gcc -g -m64 -Os -c integral_asm_k.s
	gcc -g -m64 -Os -c main.c
	gcc -g -m64 -o $(PROG) main.o integral_asm.o integral_asm_k.o

clean:
	rm -f $(PROG) integral_asm.o main.o integral_asm_k.o 

run: $(PROG)
	./$(PROG)
