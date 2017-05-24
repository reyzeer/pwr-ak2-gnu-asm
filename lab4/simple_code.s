SYSCALL32 = 0x80		# nr wywołania systemowego
EXIT = 1		# nr funkcji restartu (=1)
WRITE = 4		# nr funkcji „pisz”
STDOUT = 1		# nr wejścia standardowego

.data
komunikat: .ascii "Hello World\n"	# tekst komunikatu,
rozmiar = . - komunikat			# obliczenie liczby znaków komunikatu

.text
.globl _start

_start:
movl $rozmiar, %edx	# rozmiar bufora w bajtach ($rozmiar) do %edx
movl $komunikat, %ecx	# adres startowy bufora ($komunikat) do %ecx
movl $STDOUT, %ebx	# nr wejścia do %ebx (STDOUT=1)
movl $WRITE, %eax	# nr funkcji do %eax (=4)
int $SYSCALL32		# syscall – ogólne wywołanie funkcji

movl $EXIT, %eax	# numer funkcji (=1) do %eax
int $SYSCALL32		# syscall – ogólne wywołanie funkcji 

