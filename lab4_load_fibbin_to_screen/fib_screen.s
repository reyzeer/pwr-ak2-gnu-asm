STDIN = 0           # Wejscie konsoli (plik)
STDOUT = 1          # Wyjscia konsoli (plik)

SYS_READ = 0        # fn - wczytywanie danych z pliku (np. z wejscia konsoli)
SYS_WRITE = 1	    # fn - zapisanie danych do pliku (np. do pliku wyjscia konsoli)

BUFFOR_SIZE = 4096   # Dlugosc bufora danych

.data
BUFFOR: .space BUFFOR_SIZE

FILE_NAME: .ascii "fib.bin"
FILE_NAME_STR_LEN = . - FILE_NAME

.text
.global main

# --- Makra ---

# Zapis do konsoli
.macro cnwrite buffor, buffor_size
    mov $SYS_WRITE, %rax
    mov $STDOUT, %rdi
    mov \buffor, %rsi
    mov \buffor_size, %rdx
    syscall
.endm

main:

	# --- odczyt pliku
	mov $2, %rax		# sys_open
	mov $FILE_NAME, %rdi
	mov $2, %rsi		#flagi
	syscall

	# --- mmap
 
	mov %rax, %r8  # fd - file descriptor
	
	mov $9, %rax		# sys_mmap
	mov $0, %rdi		# adres - pobranie z pliku wejscia
	mov $2048, %rsi		# rozmiar pliku
	mov $3, %rdx		# prot - PROT_WRITE Pages may be written.
	mov $1, %r10		# flags
	mov $0, %r9		# offset 0
	syscall

	# wskazniki
	mov %rax, %r8 # adres na mape 
	mov $BUFFOR, %r9 # adres na buffor

	# liczniki
	mov $2048, %rcx
	xor %r10, %r10

	xor %rax, %rax
	xor %rdx, %rdx 

read_file:

	cmp $0, %rcx
	je program_end

	xor %rax, %rax
	movb (%rcx, %r8, 1), %al
	cmp $0, %al
	je zero

	mov $16, %rdx
	divb %dl

	cmp $10, %al
	jl digit_first

	addb $'A', %al
	subb $10, %al
	jmp secend_byte

digit_first:
	addb $'0', %al

	jmp secend_byte

secend_byte:

	cmp $10, %ah
	jl digit_second

	addb $'A', %ah
	subb $10, %ah
	jmp copy_to_rregs

digit_second:
	addb $'0', %ah

copy_to_rregs:
	
	movb %al, %r12b
	shr $8, %ax
	movb %al, %r11b

	jmp save_in_buffor

zero:

	movb $'0', %r11b
	movb $'0', %r12b

save_in_buffor:

	movb %r12b, (%r10, %r9, 1)
	inc %r10
	movb %r11b, (%r10, %r9, 1)
	inc %r10
	
	dec %rcx
	
	jmp read_file
	
program_end:

	cnwrite $BUFFOR, $BUFFOR_SIZE

