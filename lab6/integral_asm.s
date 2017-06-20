.global integral_asm

# Liczy wartosc funkcji f(x) = sqrt(x^2+1)-1
.type integral_asm @function
integral_asm:
	
	# odlozenie wskaznika na stos
	#push	%rbp
	#mov	%rsp, %rbp
	
	call   integral_asm_k

	# mov k to %xmm1 [k(127-64), k(63-0)]
	#movddup %xmm0, %xmm1

integral_asm_end:
	#fstpl	(%rsp)
	#movsd	(%rsp), %xmm0

	# poniesienie wskaznika na stos
	#mov %rbp, %rsp
	#pop %rbp

ret
