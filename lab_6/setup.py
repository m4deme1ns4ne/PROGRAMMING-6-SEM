from setuptools import setup, Extension
from Cython.Build import cythonize

extensions = [
    Extension("ferma_fact", ["ferma_fact.pyx"])
]

setup(
    name="ferma_fact",
    ext_modules=cythonize(extensions),
    script_args=['build_ext', '--inplace']
)