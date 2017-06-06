.global g

# Liczy wartosc funkcji g(x) = x^2/sqrt(x^2+1)
.type g @function
g:
	
	# odlozenie wskaznika na stos
	push	%rbp
	mov	%rsp, %rbp

	# Argumenty:
	# %xmm0 - wartosc x

	movsd	%xmm0, (%rsp)
	fldl	(%rsp)		# ST(0) = x
	fld	%st		# ST(0) = x | ST(1) = x

	fmul	%st(1), %st 	# ST(0) = x^2
	fld	%st		# ST(0) = x^2 | ST(1) = x^2 | ST(2) = x
	fld1			# ST(0) = 1 | ST(1) = x^2 | ST(2) = x^2 | ST(3) = x
	fadd	%st(1)		# ST(0) = x^2+1 | ST(1) = x^2 | ST(2) = x^2 | ST(3) = x	
	fsqrt			# ST(0) = sqrt(x^2+1) | ST(1) = x^2 | ST(2) = x^2 | ST(3) = x
	fxch	%st(1)		# ST(0) = x^2 | ST(1) = sqrt(x^2+1) | ST(2) = x^2 | ST(3) = x	
	fdiv	%st(1)	

g_end:
	fstpl	(%rsp)
	movsd	(%rsp), %xmm0

	# poniesienie wskaznika na stos
	mov %rbp, %rsp
	pop %rbp

ret

