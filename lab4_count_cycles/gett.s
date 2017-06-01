.global getT

.type getT @function
getT:

	# w 64 bit argumenty w funkcji sa odkladane kolejno w rejestrach rdi, rsi, etc, tj. w systemowych

	# pobranie argumentu odloznego na poziomie jezyka C
	#mov 2*8(%rbp), %rdx # tutaj dorzuca cos C
	#mov 1*8(%rbp), %r9
	#mov 2*8(%rbp), %r9
	#mov 3*8(%rbp), %r9
	
		

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
ret

