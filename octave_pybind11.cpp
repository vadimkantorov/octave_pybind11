#include <memory>
#include <string>
#include <iostream>

#include <pybind11/pybind11.h>
#include <pybind11/numpy.h>

#include <octave/oct.h>
#include <octave/octave.h>
#include <octave/parse.h>
#include <octave/interpreter.h>
#include <octave/builtin-defun-decls.h>
#include <octave/Matrix.h>

class OctavePybind11Interpreter {
private:
    octave::interpreter interpreter;
public:
    OctavePybind11Interpreter()
    {
        // Inhibit reading history file by calling: interpreter.initialize_history (false);
        // Set custom load path here if you wish by calling: interpreter.initialize_load_path (false);
        // Perform final initialization of interpreter, including executing commands from startup files by calling: interpreter.initialize(); if (! interpreter.initialized ()) { std::cerr << "Octave interpreter initialization failed!" << std::endl; exit (status); }
        // You may skip this step if you don't need to do anything between reading the startup files and telling the interpreter that you are ready to execute commands. Tell the interpreter that we're ready to execute commands:
        int status = interpreter.execute ();
        if (status != 0)
            throw pybind11::value_error("creating embedded Octave interpreter failed!");
    }

    double norm(pybind11::array_t<double, pybind11::array::f_style | pybind11::array::forcecast> numpy_array) const
    {
        if (numpy_array.ndim() != 2)
            throw pybind11::value_error("Input NumPy array must be 2-dimensional.");

        try
        {
            size_t rows = numpy_array.shape(0);
            size_t cols = numpy_array.shape(1);
            const double* src_ptr = numpy_array.data();
            
            Matrix octave_matrix(rows, cols);
            double* dst_ptr = (double*)octave_matrix.data();
            std::memcpy(dst_ptr, data_ptr, sizeof(double) * rows * cols);

            octave_value_list in;
            in(0) = octave_matrix; 
            in(1) = "fro"; 
            octave_value_list out = octave::Fnorm(in, 1); //octave_value_list out = octave::feval ("gcd", in, 1); 
            double norm_of_the_matrix = out(0).double_value ();

            return norm_of_the_matrix;
        }
        catch (const octave::exit_exception& ex)
        {
            throw pybind11::value_error("Octave interpreter exited with status = " + std::to_string(ex.exit_status()));
        }
        catch (const octave::execution_exception&)
        {
            throw pybind11::value_error("error encountered in Octave evaluator!");
        }
    }

};

PYBIND11_MODULE(octave_pybind11, m)
{
    pybind11::class_<OctavePybind11Interpreter, std::shared_ptr<OctavePybind11Interpreter>>(m, "OctavePybind11Interpreter")
        .def(pybind11::init<>()) // Default constructor
        .def("norm", &OctavePybind11Interpreter::norm)
        ;
}
