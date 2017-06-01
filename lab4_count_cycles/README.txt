Liczenie szybkosci wykonywania instrukcji w procesorze.

 Zapoznać się z rozkazami:
 - cpuid - w zaleznosci od wartosci rejestru rax ten rozkaz wykonuje rozne operacje, na potrzeby tego laboratorium interesuje nas zachowanie dla wartosci %rax = 0) - czysci to potoki!,
 - rdtscp - kopiuje wartosci licznika do rejestrow %rax i %rxb (licnzik to liczba 332 bitowa bez znaku),
 - rdtsc,
 
 Sprawdzenie jakie paramtery pracy ma procesor (czestotoliwosc - tj. liczba rozkazow na sekunde):
 lscpu - 
 cat proc/cpuid - 
 
Flagi dla gcc:
- gcc -m64 - program 64 bitowy,
- gcc -v - verbose - wyświetla działanie kompilatora gcc,
- gcc -Os - optymalizacja komilowanego kodu do wzgledem rozmiaru (jak najmniej bajtow),
- gcc -podglad wykonywanego kodu w assemblerze

Cykle procesora sa zliczane od samego poczatku dzialania komputera.
Dla procesorow 64 bitowych pojawia sie tutuaj problem kompatybilnosci w stosunku do proecsorow 32 bitowych.
Liczba jest rozbijana na 2 32-bitowe czesci - ogarnac to.

Wyliczanie roznicy czasu powinno polegac na:
1. Pobranie wartosci liczby wykonanych cykli.
2. Zapisanie tej wartosci.
3. Pobranie wartosic liczby wykonanych cykli po raz drugi.
4. Obliczenie roznicy.

Funckja pobierajaca i zapisujaca ma byc uruchamiana z poziomu jezyka C.

Wystapi jedo rozgalezienie:
if ->
    cpuid
    rdtsc
else ->
    rdtscp

    
https://godbolt.org/ - na tej stronie mozna podjerzec jaki kod ASM zostanie wygenrowany na podstawie kodu C++ dla roznych kompilatorow.

Parametry cpu w laptopie:
Architecture:          x86_64
Tryb(y) pracy CPU:     32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                4
On-line CPU(s) list:   0-3
Wątków na rdzeń:    2
Rdzeni na gniazdo:     2
Socket(s):             1
Węzłów NUMA:        1
ID producenta:         GenuineIntel
Rodzina CPU:           6
Model:                 61
Model name:            Intel(R) Core(TM) i7-5500U CPU @ 2.40GHz
Wersja:                4
CPU MHz:               2400.292
CPU max MHz:           3000,0000
CPU min MHz:           500,0000
BogoMIPS:              4789.33
Wirtualizacja:         VT-x
Cache L1d:             32K
Cache L1i:             32K
Cache L2:              256K
Cache L3:              4096K
NUMA node0 CPU(s):     0-3

Wyświetlenie fibonnaciego z poprzedniego kodu.
