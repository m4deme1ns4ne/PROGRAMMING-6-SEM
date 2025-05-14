# ferma_fact.pyx
# cython: language_level=3
from libc.math cimport isqrt
cimport cython

@cython.cfunc
@cython.nogil
cdef int is_perfect_square_nogil(long n) nogil:
    """
    Проверка целочисленного корня без GIL.
    """
    cdef long root = isqrt(n)
    return root * root == n

cpdef tuple fermat_factorization(long N):
    """
    Разложение числа N на множители методом Ферма.
    Основной цикл — в with nogil.
    """
    cdef long x, y_squared, y, p, q

    # Быстрый выход для чётных N (работает под GIL, очень быстро)
    if N % 2 == 0:
        return (2, N // 2)

    x = isqrt(N) + 1

    # Входим в «чистый» C-код без GIL
    with nogil:
        while True:
            y_squared = x * x - N
            if is_perfect_square_nogil(y_squared):
                y = isqrt(y_squared)
                p = x - y
                q = x + y
                break
            x += 1

    # Возвращаем Python-кортеж (GIL автоматически подтягивается)
    return (p, q)
