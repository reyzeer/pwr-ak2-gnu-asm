STDIN = 0           # Wejscie konsoli (plik)
STDOUT = 1          # Wyjscia konsoli (plik)

SYS_READ = 0        # fn - wczytywanie danych z pliku (np. z wejscia konsoli)
SYS_WRITE = 1	    # fn - zapisanie danych do pliku (np. do pliku wyjscia konsoli)

BUFFOR_SIZE = 1024   # Dlugosc bufora danych

MASK_LETTER = 0x1f # maska litera
MASK_DIGIT = 0x10  # maska cyfra

.data
BUFFOR: .space BUFFOR_SIZE
BUFFOR_TEMP: .space BUFFOR_SIZE # buffor tymczasowy do przechowywania drugiej liczby fibonnaciego

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

# Dodawanie bufforow
# @arg char *buf - buffor 1
# @arg char *buf - buffor 2
# @arg int size - rozmiar bufforow
# @return Wynik dodawania bufforow znajduje sie w bufforze 1
.type addBuffors @function
addBuffors:
	begin

addBuffors_getArgs:

	mov 32(%rbp), %r8 # buffor 1 
        mov 24(%rbp), %r9 # buffor 2
        mov 16(%rbp), %r10 # rozmiar bufforow

	xor %rcx, %rcx # zerowanie licznika

	# Dodanie najnizszych bajtow (Half-Adder)
	movb (%rcx, %r9, 1), %al # pobranie najnizszego bajta z drugiego buffora
	addb %al, (%rcx, %r8, 1)

	# dodano juz pierwszy element
	inc %rcx

addBuffors_start:

	cmp %rcx, %r10
	je addBuffors_end

	movb (%rcx, %r9, 1), %al # pobranie n-tego bajtu z buffora 2
	adcb %al, (%rcx, %r8, 1) # dodanie wartosci n-tego bajtu do buffora 1  

	inc %rcx

	jmp addBuffors_start

addBuffors_end:
	
	end
ret

# Odklada wartosc zapisana w HEX na stos
# @arg int fib_index - indeks liczby fibonacciego
# @arg char *buf - buffor - tutaj bedzie zapisana liczba fibonacciego
# @arg int size - wielkosc bufora
.type fibonacci @function
fibonacci:
	begin

fibonacci_getArgs:

	mov 16(%rbp), %r8 # indeks liczby fibonnaciego 
	mov 24(%rbp), %r9 # adres do bufora w ktorym zapisze liczbe fibonnaciego
	mov 32(%rbp), %r10 # ilosc bajtow w buforze

	# Zakladam ze buffor z %r8 jest wyzerowany
	# Wstawienie wartosci 1 do %BUFFOR_TEMP
	mov $BUFFOR_TEMP, %rax
	movb $1, (%rax)

fibonacci_start:

	cmp $0, %rbx
	je fibonacci_end
	

fibonacci_end:
	
	#mov %rax, 16(%rbp)

	end
ret

_start:

	mov $BUFFOR, %rax
	mov $BUFFOR_TEMP, %rbx	

	movb $0x05, (%rax)
	movb $0x05, (%rbx)

	push $BUFFOR
	push $BUFFOR_TEMP
	push $BUFFOR_SIZE
	call addBuffors

	cnwrite $BUFFOR, $BUFFOR_SIZE	

	# die
	je program_end

	# Wywolanie liczenia fibonacciego
	push $5
	push $BUFFOR
	push $BUFFOR_SIZE
	call fibonacci

	# Zapisanie obliczonej liczby do pliku wyjscia konsoli
	cnwrite $BUFFOR, $BUFFOR_SIZE

program_end:
	sysexit

