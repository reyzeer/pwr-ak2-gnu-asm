# Hello-World

## Uruchomienie pierwszego programu:

```
as hello.s -o hello.o
ld hello.o -o hello
```

1. Pierwsze polecenie kompiluje kod z pliku hello.s i zapisuje w postaci hello.o .
2. Drugie polecenie konsoliduje program z pliku hello.o i zapisuje jako plik wykonywalny hello.

System operacyjny - oprogramowanie zarzadzajace systemem komputerowym. (Zarzadzanie zadan, przyedzialanie zasobow, narzedzai do synchronizacja zadan i komunikacji miedzy nimi, obsluga sprzetu)

Proces - to program w stanie uruchomionym, (system tworzy i usuwana procesy/ wstrzymuje i przywraca)

Plik to ciag bitow

Budowana rejestrow (pliki graficzne)

Konsolidacja - (linkowanie - ang. linkowanie) - laczenie skompilowanych modulow w celu uzyskania pliku wykonywalnego

Dynamiczne linkowanie - polega na laczeniu skompilowanych modulow, ktore nie znaduja sie w pliku wykonywalne ale znajduja sie w innych plikach na dysku (pamieci), w pliku wykonywalnym jest zapisana tylko nazwa pliku lub identyfikator, ktory umozliwia udostepnie danych w momencie uruchamiana programu

as - narzedzie do kompilowania kodu assemblera
ld-linux | ld - narzedzie do dynamicznego linkowania w systemie linuks
 
Proces - pojedynczy egzemplarz wykonywanego programu,
Sklad procesu:
- kod programu
- licznik rozkazow,
- stos programu
- sekcja danych

Kazdy proces dostaje zasoby:
- czas procesora,
- pamiec,
- dostep do urzadzen wyjscia-wejscia,
- pliki,

Nazwy funkcji systemowych mozna znalezc pod sciezka:
/usr/include/asm-generic/unistd.h

Numery funkcji systemowych 32 bitowych:
http://asm.sourceforge.net/syscall.html

Numery funkcji systemowych 64 bitowych:
https://filippo.io/linux-syscall-table/

Aby umozliwc precyzjyne przegladanie pracy programu przy pomocy debuggera gdb, potrzeba skompilowac go
za pomoca programy `gcc` z flaga `-g`.
Przyklad:

```
gcc -g -o hello hello.s
```
Dla poprawnego laczenia programu z programeme startowym z jezyka C, nalezy zmienic etykiete programu z
.global _start na .global main

Uruchomienie gdb:
gdb (nazwa programu)

Wazne polecenia w gdb:
- b[reak] - ustawienie pulapki
- r[un] - uruchomienie programu
- s[tep], n[ext] - robi pojedynczy krok (instrukcje) | biegnie do kolejne pulapki
- inf[o] - wyswietla informacje o wykonywanym programie 
	inf[o] reg[isters]

objdump -R (nazwa_pliku_wykonywalnego)
Analiza pliku

objdump -S (nazwa_pliku_wykonywalnego)
Deasemblacja


