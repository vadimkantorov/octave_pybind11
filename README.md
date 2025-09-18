# Example of binding `octave::Interpreter` in pybind11

```bash
sudo apt-get install octave octave-dev

pip install pybind11 --user --break-system-packages

make octave_pybind11.so

python3 octave_pybind11_test.py
```

# References
- https://docs.octave.org/v10.2.0/Standalone-Programs.html
- https://pybind11.readthedocs.io/en/stable/compiling.html
- https://pybind11.readthedocs.io/en/stable/advanced/pycpp/numpy.html
- https://stackoverflow.com/questions/42645228/cast-numpy-array-to-from-custom-c-matrix-class-using-pybind11
