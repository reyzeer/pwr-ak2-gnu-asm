.global simd

.type simd @function
simd:
	
	# odlozenie wskaznika na stos
	push	%rbp
	mov	%rsp, %rbp
	
	movq $0xFFFF, (%rsp)
	movd (%rsp), %mm0
        movd (%rsp), %mm1

        paddb %mm0, %mm1
        
        movd %mm1, (%rsp)
        
        mov (%rsp), %rax

simd_end:

	# poniesienie wskaznika na stos
	mov %rbp, %rsp
	pop %rbp

ret

