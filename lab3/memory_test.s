STDIN = 0           # Wejscie konsoli (plik)
STDOUT = 1          # Wyjscia konsoli (plik)

SYS_READ = 0        # fn - wczytywanie danych z pliku (np. z wejscia konsoli)
SYS_WRITE = 1	    # fn - zapisanie danych do pliku (np. do pliku wyjscia konsoli)

BUFFOR_SIZE = 255   # Dlugosc bufora danych

MASK_LETTER = 0x1f # maska litera
MASK_DIGIT = 0x10  # maska cyfra

.data
BUFFOR: .space BUFFOR_SIZE

.text
.global _start

# --- Makra ---

# Zapis do konsoli
.macro cnwrite buffor, buffor_size
    mov $SYS_WRITE, %rax
    mov $STDOUT, %rdi
    mov \buffor, %rsi
    mov \buffor_size, %rdx
    syscall
.endm

_start:

	# Zerowanie rcx
	xor %rcx, %rcx	

	# Adres na buffor do %rax
	mov $BUFFOR, %rax

	movb $0x12, (%rcx, %rax, 1)

	inc %rcx

	movb $0x34, (%rcx, %rax, 1)

	inc %rcx

	movb $0x56, (%rcx, %rax, 1)

	cnwrite $BUFFOR, $BUFFOR_SIZE

program_end:
	sysexit

