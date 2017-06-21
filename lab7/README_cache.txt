- Głębokość pamięci cache L1, L2, L3 (L3 bliżej ramu sprawdzić),
- Linia pamięci cache,
- Jak działa pamięć cache,
- Policzymy ile linii ma pamięc cache,

Plik rejestru = na tym operuje każdy program. (Na tym operujes procesor, najszybszy element pamięci w procesorze).
- Żre sporo prądu i jest mało tej pamięci,

Biblioteka taśmowa:
- 2.5.h - czas dostępu,
L3->L2->L1(najbliżej pliku rejstru)

Każdy rdzeń może mieć oddzielny plik rejestru.

Rdzeń 1 <-> L1 \
                |- L2 \
Rdzeń 2 <-> L1 /       |
                        |- L3
Rdzeń 3 <-> L1 \       |
                |- L2 /
Rdzeń 4 <-> L1 /

Z cache pobieramy adresy liniami.

Pamięc L jest podzielona na kod i dane.

/- Kod
L
\- Dane

0    -----------> 1023
1024 -----------> 2047

1. Odczytanie ile bajtów ma jedna linia cache.
lscpu
cat /proc/cpuinfo

for (i = 0; i < Y; i++) {
    rdtsc
    tmp = tab[i];
    rdtsc
}

rdtsc

2. Macierz kwadratowa

    A       A
[][][][] [][][][]
[][][][] [][][][]
[][][][] [][][][]
[][][][] [][][][]
