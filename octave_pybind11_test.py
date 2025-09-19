import numpy as np
import octave_pybind11

interp = octave_pybind11.OctavePybind11Interpreter()

myarr = np.array([[1.0, 2.0], [3.0, 4.0]], dtype = np.float64)

print(np.linalg.norm(myarr, "fro"))
print(interp.norm(myarr))
