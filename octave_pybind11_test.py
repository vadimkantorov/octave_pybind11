import numpy as np
import octave_pybind11

interp = octave_pybind11.OctavePybind11Interpreter()

# if not column-major, pybind11 will copy-convert to column-major. on C++ side, will memcpy-in a temp Octave matrix object
myarr = np.array([[1.0, 2.0], [3.0, 4.0]], dtype = np.float64, order = 'F')

print(np.linalg.norm(myarr, "fro")) # 5.477225575051661
print(interp.norm(myarr))           # 5.477225575051661
