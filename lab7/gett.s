.global getT

.type getT @function
getT:

	# odlozenie wskaznika na stos
	push	%rbp
	mov	%rsp, %rbp

	cmp $0, %rdi
	je getT_option1
	jne getT_option2 

getT_option1:

	mov $0, %rax
        cpuid           # serializacja (?)
        rdtsc           # odczyt zegara

	jmp getT_to64

getT_option2:

	rdtscp		# odczyt zegara

getT_to64:

	shl $32, %rdx   # gorne bity
        add %rdx, %rax  # dodwanie do rax
	
	# poniesienie wskaznika na stos
	mov %rbp, %rsp
	pop %rbp

ret

