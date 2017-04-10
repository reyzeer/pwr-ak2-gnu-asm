# pwr-ak2-gnu-asm

# GNU Assembler

Poniższy kurs będzie dotyczył programowania przy pomocy języka niskiego poziomu, jakim jest język assembler.

## Środowisko pracy

### Linux

TODO

mkdir | cd | ls | hexdump

### LAK

TODO ssh | scp

### Repozytorium
TODO svn

## Pierwszy program

TODO

```

```

### Składnia

####

#### System call - x64

Stałe:
- Wejście: `STDIN = 0`
- Wyjście: `STDOUT = 1`

Source: [System call - x64](http://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/)

| %rax | System call |  %rdi           | %rsi       | %rdx         |
|------|-------------|-----------------|------------|--------------|
| 0    |  sys_read   | unsigned int fd |	char *buf |	size_t count |

#### Przykład użycia

```
STDIN = 0
SYS_READ = 0
BUFFOR_SIZE = 254

.data
BUFFOR: .space BUFOR_SIZE

.text
.global _start

_start:

mov $SYS_READ, %rax
mov $STDIN, %rdi
mov $BUFFOR, $rsi
mov $BUFFOR_SIZE, $rdx

movl $READ, %eax
movl $STDIN, %ebx
movl $BUFFOR_TEXT, %ecx
movl $BUFFOR_TEXT_SIZE, %edx
int $SYSCALL32

```

#### Makra

```assembly
# wypisywanie na konsoli
.macro write str, str_size
	mov $STDOUT, %rdi
	mov $WRITE, %rax
	mov \str, %rsi
	mov \str_size, %rdx
	syscall
.endm
```

### Rozkazy
