# funkcje systemowy
EXIT = 1		# nr funkcji restartu (=1)
READ = 0		# nr funkcji odczytu wejscia (=0)
WRITE = 1		# nr funkcji "pisz"
STDIN = 0		# nr wejscia standardowego (klawiatura) do %rdi
STDOUT = 1		# nr wyjscia standardowego

#status: .word 0

f0:	.float 0.0
f1:     .float 10.0
f2:     .float 9.0

error_precision: .ascii "Blad precyzji.\n"
error_precisionLen = . - error_precision

error_underflow: .ascii "Blad niedomiaru.\n"
error_underflowLen = . - error_underflow

error_overflow: .ascii "Blad nadmiaru.\n"
error_overflowLen = . - error_overflow

error_zeroDivide: .ascii "Blad nie dziel przez zero.\n"
error_zeroDivideLen = . - error_zeroDivide

error_denormalOperand: .ascii "Zdenormalizowany operand.\n"
error_denormalOperandLen = . - error_denormalOperand

error_invalidOperation: .ascii "Bledna operacja.\n"
error_invalidOperationLen = . - error_invalidOperation

.data

.text
.globl main

# --- MAKRA ---

# wypisywanie na konsoli
.macro write str, str_size
	#mov $STDOUT, %rdi
	#mov $WRITE, %rax
	#mov \str, %rsi
	#mov \str_size, %rdx
	#syscall
	mov \str, %rdi
        call printf
.endm

# wczytywanie danych z konsoli
.macro read buff, buff_size
	mov $READ, %rax
	mov $STDIN, %rdi
	mov \buff, %rsi
	mov \buff_size, %rdx
	syscall
.endm

# koniec programu
.macro program_end
	sysexit
.endm

# do funkcji - odkladanie rejestrow na stos - wskaznik kontekstu
.macro begin

	push %rbp
	mov %rsp, %rbp

	push %rax
	push %rbx
	push %rcx
	push %rdx
	push %rsi
	push %rdi
	push %r8
	push %r9
	push %r10
	push %r11
	push %r12
	push %r13
	push %r14
	push %r15

.endm

# do funkcji - podnoszenie rejestrow ze stosu - odtworzenie starego wskaznika kontekstu
.macro end

	pop %r15
	pop %r14
	pop %r13
	pop %r12
	pop %r11
	pop %r10
	pop %r9
	pop %r8
	pop %rdi
	pop %rsi
	pop %rdx
	pop %rcx
	pop %rbx
	pop %rax

	mov %rbp, %rsp
	pop %rbp

.endm

# Uzyte rejestry: %rax
.type printStan @function
printStan:

	fnstsw %ax
 
printStan_error_precision:
	test $0b100000, %ax
	jz printStan_error_underflow
	write error_precision, error_precisionLen

printStan_error_underflow:
	test $0b10000, %ax
	jz printStan_error_overflow
	write error_underflow, error_underflowLen

printStan_error_overflow:
	test $0b1000, %ax
	jz printStan_error_zeroDivide
	write error_overflow, error_overflowLen

printStan_error_zeroDivide:
	test $0b100, %ax
	jz printStan_error_denormalOperand
	#write error_zeroDivide, error_zeroDivideLen
	write error_zeroDivide, error_zeroDivideLen
	#mov $error_zeroDivide, %rdi
	#call printf

printStan_error_denormalOperand:
	test $0b10, %ax
	jz printStan_error_invalidOperation
	write error_denormalOperand, error_denormalOperandLen

printStan_error_invalidOperation:
	test $0b1, %ax
	jz printStan_end
	write error_invalidOperation ,error_invalidOperationLen

printStan_end:
ret

# --- Poczatek programu ---
main:
	
	fld f1
	fdiv f2 
	fadd f0 

	fnstsw %ax

	#movw $0, %ax
	#fnstsw %ax
	#addb $0b11000000, %al
	finit
	#fldcw %ax
	
	fnstsw %ax
	
	#fldcw %ax	
	#fldcw
	#fnstcw %ax
	
	call printStan
	
	fdiv f2

	call printStan

	#fld f1
	#fld f2



# Koniec programu
program_end

