import time
from concurrent.futures import ThreadPoolExecutor
import matplotlib.pyplot as plt
from ferma_fact import fermat_factorization

TEST_LST = [101, 9973, 104729, 101909, 609133,
            1300039, 9999991, 99999959, 99999971,
            3000009, 700000133]

def use_threads(data):
    with ThreadPoolExecutor() as exec:
        return list(exec.map(fermat_factorization, data))

if __name__ == "__main__":
    start = time.time()
    results = use_threads(TEST_LST)
    t = time.time() - start

    print(f"Потоки (с with nogil) заняли {t:.3f} сек.")
    for n, (p, q) in zip(TEST_LST, results):
        print(f"  {n} = {p} × {q}")
