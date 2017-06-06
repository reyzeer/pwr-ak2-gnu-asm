.global f

# Liczy wartosc funkcji f(x) = sqrt(x^2+1)-1
.type f @function
f:
	
	# odlozenie wskaznika na stos
	push	%rbp
	mov	%rsp, %rbp

	# Argumenty:
	# %xmm0 - wartosc x

	movsd	%xmm0, (%rsp)
	fldl	(%rsp)		# ST(0) = x
	fld	%st		# ST(1) = ST(0) = x | ST(0) = ST(0) = x

	fmul	%st(1), %st 	# ST(0) = ST(0) * ST(1) = x * x
	fld1			# ST(2) = ST(1) = x | ST(1) = ST(0) = x^2 | ST(0) = 1
	
	fadd	%st(1)		# ST(0) = ST(0) + ST(1) = x^2+1
	fsqrt			# ST(0) = sqrt(ST(0)) = sqrt(x^2+1)
	
	fld1			# ST(0) = 1 | ST(1) = sqrt(x^2+1) | ST(2) = x^2 | ST(3) = x

	fxch	%st(1)		# ST(0) = sqrt(x^2+1) | ST(1) = 1 | ST(2) = x^2 | ST(3) = x

	fsub	%st(1)		# ST(0) = sqrt(X^2+1)-1

f_end:
	fstpl	(%rsp)
	movsd	(%rsp), %xmm0

	# poniesienie wskaznika na stos
	mov %rbp, %rsp
	pop %rbp

ret

