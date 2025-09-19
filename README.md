# Example of binding `octave::Interpreter` and `norm` in pybind11

```bash
sudo apt-get install octave octave-dev
pip install pybind11 --user --break-system-packages
make octave_pybind11.so

LD_PRELOAD="/usr/lib/x86_64-linux-gnu/octave/8.4.0/liboctinterp.so.11 /usr/lib/x86_64-linux-gnu/octave/8.4.0/liboctave.so.10" python3 octave_pybind11_test.py
# make test
```

# References
- https://gitlab.com/gnu-octave/octave-pythonic/-/issues/140
- https://octave.sourceforge.io/octave/function/norm.html
- https://docs.octave.org/v10.2.0/Standalone-Programs.html
- https://pybind11.readthedocs.io/en/stable/compiling.html
- https://pybind11.readthedocs.io/en/stable/advanced/pycpp/numpy.html
- https://stackoverflow.com/questions/42645228/cast-numpy-array-to-from-custom-c-matrix-class-using-pybind11
- https://github.com/scipy/scipy/issues/19235
- https://docs.octave.org/doxygen/10/d3/d3f/classMatrix.html#acaf692a40d2760ebb8918779561f7441
- https://stackoverflow.com/questions/77253804/how-to-read-a-mat-file-using-liboctave-and-access-struct-elements
