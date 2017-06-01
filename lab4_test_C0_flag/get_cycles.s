SYSCALL32 = 0x80		# nr wywołania systemowego
EXIT = 1		# nr funkcji restartu (=1)
WRITE = 4		# nr funkcji „pisz”
STDOUT = 1		# nr wejścia standardowego

.text
.globl main

main:

	mov $0, %rax
	cpuid		# serializacja (?)
	rdtsc		# odczyt zegara

	rdtscp

	#mov $1, %rax
	#mov $1, %rdx	

	shl $32, %rdx	# gorne bity
	add %rdx, %rax	# dodwanie do rax

	movl $EXIT, %eax	# numer funkcji (=1) do %eax
	int $SYSCALL32		# syscall – ogólne wywołanie funkcji
