.global integral_asm_k

# Liczy wartosc funkcji integral_asm_k(start, end, parts) = (end - start)/k
.type integral_asm_k @function
integral_asm_k:
	
	# odlozenie wskaznika na stos
	push	%rbp
	mov	%rsp, %rbp
	
integral_asm_k_start:
	
	movlpd  %xmm0, (%rsp)
	fldl    (%rsp)		# ST(0) = start

	movlpd  %xmm1, (%rsp)
	fldl    (%rsp)		# ST(0) = end | ST(1) = start
	
	movlpd  %xmm2, (%rsp)
	fldl   (%rsp)           # ST(0) = parts | ST(1) = end | ST(2) = start
	
        fxch   %st(1)           # ST(0) = end | ST(1) = parts | ST(2) = start
	fsub   %st(2)           # ST(0) = end - start | ST(1) = parts | ST(2) = start
	fdiv   %st(1)           # ST(0) = (end - start)/parts | ST(1) = parts | ST(2) = start

integral_asm_k_return:

	fstpl	(%rsp)
	movsd	(%rsp), %xmm0
	
integral_asm_k_end:

	# poniesienie wskaznika na stos
	mov %rbp, %rsp
	pop %rbp

ret

