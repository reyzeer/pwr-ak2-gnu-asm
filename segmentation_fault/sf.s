.text
.global main

.type myFunc @function
myFunc:

ret

main:

	# trzeba podniesc tyle ile sie odlozylo, inaczej segmentation fault
	push %rax
	call myFunc
	pop %rax

	# sysexit generuje segmentation fault
	# instrukcja zwrot sterowania
	#sysexit
