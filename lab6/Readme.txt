f(x) = x^2

Oszacować metodą prostokatów całkę od A do B: z f(x) po dx

A
S f(x) dx
B

Metoda prostokątów.

Wynik: float: calka_sum(A, B, k)

/\y      f(x)
|     _/
|   _/ []
| _/ [][]
|/ [][][]
|----------->x


\/ - epsilon
E f(A + k/c h) * k

k = B-A/h
