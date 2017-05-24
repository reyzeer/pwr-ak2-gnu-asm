SYSCALL32 = 0x80                # nr wywołania systemowego
EXIT = 1                # nr funkcji restartu (=1)
WRITE = 4               # nr funkcji „pisz”
STDOUT = 1              # nr wejścia standardowego
READ = 3		# nr ufnkcji czytaj		
BUFFOR_TEXT_SIZE = 254  # dlugosc bufora
STDIN = 0
MASK_LETTER = 0x1f # maska litera
MASK_DIGIT = 0x10  # maska cyfra

.data
BUFFOR_TEXT: .space BUFFOR_TEXT_SIZE
komunikat: .ascii "Hello World\n"       # tekst komunikatu,
rozmiar = . - komunikat                 # obliczenie liczby znaków komunikatu

.text
.globl _start

_start:

# wczytanie z wejscia
movl $READ, %eax
movl $STDIN, %ebx
movl $BUFFOR_TEXT, %ecx
movl $BUFFOR_TEXT_SIZE, %edx
int $SYSCALL32

# wskaznik na buffor znaduje sie w %ecx
# dlugosc bufora znajduje sie w %edx

# licznik bedzie w %bl

xor %ebx, %ebx # zerowanie %ebx w %bl

loop:

movb (%ecx, %ebx, 1), %al
inc %ebx

cmp %ebx, %edx
jne loop

#movl $BUFFOR_TEXT_SIZE, %ecx	# rozmiar bufora
#movl $BUFFOR_TEXT, %ebx		# buffor na tekst
#movl $READ, %eax		# nr funckcji read
#int $SYSCALL32			# syscall - przerwanie systemowe - wywolanie funkcji

# wypisanie na ekran
movl $BUFFOR_TEXT_SIZE, %edx     # rozmiar bufora w bajtach ($rozmiar) do %edx
movl $BUFFOR_TEXT, %ecx   # adres startowy bufora ($komunikat) do %ecx
movl $STDOUT, %ebx      # nr wejścia do %ebx (STDOUT=1)
movl $WRITE, %eax       # nr funkcji do %eax (=4)
int $SYSCALL32          # syscall – ogólne wywołanie funkcji

movl $EXIT, %eax        # numer funkcji (=1) do %eax
int $SYSCALL32          # syscall – ogólne wywołanie funkcji
