#SYSCALL32 = 0x80                # nr wywołania systemowego
#EXIT = 1                # nr funkcji restartu (=1)
#WRITE = 4               # nr funkcji „pisz”
#STDOUT = 1              # nr wejścia standardowego
#READ = 3		# nr ufnkcji czytaj
#BUFFOR_TEXT_SIZE = 254  # dlugosc bufora
#STDIN = 0

#EXIT = 1


STDIN = 0           # Wejscie
STDOUT = 1          # Wyjscia

SYS_READ = 0        # fn - wczytywanie wejscia do bufora

BUFFOR_SIZE = 255   # Dlugosc bufora danych

MASK_LETTER = 0x1f # maska litera
MASK_DIGIT = 0x10  # maska cyfra

.data
BUFFOR: .space BUFFOR_SIZE
komunikat: .ascii "Hello World\n"       # tekst komunikatu,
rozmiar = . - komunikat                 # obliczenie liczby znaków komunikatu

.text
.globl _start

# --- Makra ---

# Odczyt z konsoli
.macro cnread buffor, buffor_size
    mov $SYS_READ, %rax
    mov $STDIN, %rdi
    mov \buffor, %rsi
    mov \buffor_size, %rdx
    syscall
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

_start:

# wczytanie z wejscia
cnread $BUFFOR, $BUFFOR_SIZE

# wskaznik na buffor znaduje sie w %ecx
# dlugosc bufora znajduje sie w %edx

xor %eax, %eax # zerowania %eax, w tym %ah i %al
xor %ebx, %ebx # zerowanie %ebx w %bl

loop:

# jezeli doszedl do ostatniego znaku w buforze - koniec petli
cmp %ebx, %edx
je loop_end

# jezeli odlozyl juz 8 znak na stosie - koniec petli
cmp $8, %ah
je loop_end

# pobranie znaku i zwiekszenie licznika o 1 
loop_inc:

movb (%ecx, %ebx, 1), %al
inc %ebx

# pobrano znak NULL - koniec ciagu
cmp $0, %al
je loop_end

loop_check_digit:

# idz do nastepnego wykonania petli jesli znak przed '0' w tablicy ascii
cmpb $'0', %al
jnge loop_push_char

# idz odloz znak na stosie jesli znak jest przed '9' lub '9' - oznacza ze to znak cyfry
cmpb $'9', %al
jl loop_push_char

loop_check_letter:

# idz do nastepnego wykonania jesli znak wczesniejszy niz A
cmpb $'A', %al
jnge loop

# idz odloz znak na stosie (to jest miedzy A i F wlacznie)
cmpb $'F', %al
jl loop_push_char

# nie jest to znak z przedzialu [0-9:A-F]
jmp loop

loop_push_char:

pushq %rax
inc %ah #liczba wczytanych liczb

jmp loop

loop_end:

# Wczytywanie liczby ze stosu do pamieci

# zapisanie ilosci wczytanych liczb do ecx (skopiowanie wartosci)
movb %ah, %cl # w %cl ilosc wczytanych liczb

xor %ch, %ch # licznik drugiej petli (sprawdza liczbe podniesionych liczb)

xor %rax, %rax # tutaj bedzie wynik
xor %rbx, %rbx # wyzerowanie %rbx (do rbx bede wyciaga wartosci ze stacka)

# Rozpoczecie petli
load_number:

cmpb %cl, %ch
je load_number_end

# Pobranie jednej liczby ze stosu
load_number_get_from_stack:

popq %rbx

cmp $'9', %rbx
jg load_number_is_letter

# pobrany znak jest cyfra
load_number_is_digit:

andb $0x0F, %bl
jmp load_number_add_to_rax

# pobrany znak jest litera (trzeba obciac gorny bit i dodac 10 zeby byla liczba hex)
load_number_is_letter:

andb $0x0F, %bl
addb $10, %bl
jmp load_number_add_to_rax

# przesuniecie od 4 bity
movq $16, %rdx
mulq %rdx

load_number_add_to_rax:

# przygotowanie 64 bitowej liczby z wartoscia znaku na ostatnich 4 bitach
xor %rdx, %rdx
movb %bl, %dl

# dodanie wartosci wczytanego znaku
add %rdx, %rax

# inkremetacja licznika i skok do nastepnego wykonania petli
inc %ch
jmp load_number

load_number_end:

sysexit
#movl $EXIT, %eax        # numer funkcji (=1) do %eax
#int $SYSCALL32          # syscall – ogólne wywołanie funkcji

