STDIN = 0           # Wejscie
STDOUT = 1          # Wyjscia

SYS_READ = 0        # fn - wczytywanie wejscia do bufora

BUFFOR_SIZE = 255   # Dlugosc bufora danych

MASK_LETTER = 0x1f # maska litera
MASK_DIGIT = 0x10  # maska cyfra

.data
BUFFOR: .space BUFFOR_SIZE

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

# --- Funkcje ---

# Konwencja dla dla latwiejszego uzywania funkcji.
# Wewnatrz funkcji bede odczytywal wartosci ze stosu odwrotnie do zalozonej kolejnosci ich wprowadzania.
# Tj. jesli zakladam ze funkcja ma argumentu: arg1, arg2
# to najpierw odkladam na stos arg1, potem arg2
# natomist wewnatrz funkcji podnosze najpierw arg2, a nastepnie arg1

# Odklada wartosc zapisana w HEX na stos
# @arg char *buf - buffor
# @arg int size - wielkosc bufora
.type loadHex @function
loadHex:
    begin

loadHex_start:

    mov 16(%rbp), %r8 # pobranie dlugosci bufora
    mov 24(%rbp), %rsi # pobranie

    xor %rbx, %rbx # pobieranie znakow
    xor %rcx, %rcx # licznik
    xor %rax, %rax #wynik

loadHex_getChars:

    # --- warunki petli ---

    #odlozono 8 znakow
    cmp $8, %rcx # licznik == 8
    je loadHex_end

    #koniec bufora
    cmp %rcx, %r8 # licznik == dlugosc bufora
    je loadHex_end

    # --- warunki petli - koniec ---

    #pobierz znak z bufora
    movb (%rcx, %rsi, 1), %bl
    inc %rcx

    # --- warunki petli ---

    cmp $0, %bl # pobrano znak NULL - koniec ciagu
    je loadHex_end

    # --- warunki petli - koniec ---

loadHex_getChars_isDigit:

    # Czy %al nalezy do [0-9]

    # jezeli znak przed znakiem '0', to %al nie nalezy do [0-9]
    cmpb $'0', %bl
    jl loadHex_getChars

    # jezeli znak przed lub rowny znakowi '9', to %al nalezy do [0-9]
    cmpb $'9', %bl
    jl loadHex_getChars_getDigitValue

loadHex_getChars_isHexLetter:

    # Czy %al nalezy do [A-F:a-f]

    # jezeli znak przed znakiem 'A', to %al nie nalezy do [A-F:a-f]
    cmpb $'A', %bl
    jl loadHex_getChars

    # jezeli znak przed znakiem 'F', to %al nalezy do [A-F:a-f]
    cmpb $'F', %bl
    jl loadHex_getChars_getLetterValue

    # jezeli znak przed znakiem 'a', to %al nie nalezy do [A-F:a-f]
    cmpb $'a', %bl
    jl loadHex_getChars

    # jezeli znak przed znakiem 'f', to %al nalezy do [A-F:a-f]
    cmpb $'f', %bl
    jl loadHex_getChars_getLetterValue

loadHex_getChars_getDigitValue:

    # wyciganie wartosci ze znaku cyfry | 00001111
    andb $0x0F, %bl
    jmp loadHex_getChars_pushValue

loadHex_getChars_getLetterValue:

    # wyciganie wartosci ze znaku litery | 00001111
    andb $0x0F, %bl
    addb $9, %bl

loadHex_getChars_pushValue:

    # Jesli istnieje kolejna litera mnozenie %rax przez podstawe systemu 16
    movq $16, %rdx
    mulq %rdx

    add %rbx, %rax
    jmp loadHex_getChars

loadHex_end:

    # odlozenie wyniku na stos
    mov %rax, 16(%rbp)

    end
ret

_start:

    # wczytanie z wejscia
    cnread $BUFFOR, $BUFFOR_SIZE

    push $BUFFOR
    push $BUFFOR_SIZE
    call loadHex

result:

    pop %rax

program_end:
    sysexit
