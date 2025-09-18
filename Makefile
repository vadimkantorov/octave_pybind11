PYTHON = python3
PYBIND11_INCLUDES := $(shell $(PYTHON) -m pybind11 --includes)
CXXFLAGS := -O3 -Wall -shared -std=c++11 -fPIC $(PYBIND11_INCLUDES)

# SUFFIX := $(shell python3-config --extension-suffix)
# PYTHON_CFLAGS := $(shell python3-config --cflags)
# PYTHON_LIBS := $(shell python3-config --libs)

octave_pybind11.so: octave_pybind11.cpp
	mkoctfile -v --link-stand-alone $(CXXFLAGS) $< -o $@ # $(CXX) $(CXXFLAGS) $< -o $@
	#
	#g++ -c -Wdate-time -D_FORTIFY_SOURCE=3 -fPIC -I/usr/include/octave-8.4.0/octave/.. -I/usr/include/octave-8.4.0/octave  -pthread -fopenmp -g -O2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -ffile-prefix-map=/build/octave-GcaGjM/octave-8.4.0=. -flto=auto -ffat-lto-objects -fstack-protector-strong -fstack-clash-protection -Wformat -Werror=format-security -fcf-protection -fdebug-prefix-map=/build/octave-GcaGjM/octave-8.4.0=/usr/src/octave-8.4.0-1build5  -O3 -Wall -shared -std=c++11 -fPIC  -I/usr/include/python3.12 -I/home/vadimkantorov/.local/lib/python3.12/site-packages/pybind11/include  octave_pybind11.cpp -o /tmp/oct-j661Qv.o
	#g++ -Wdate-time -D_FORTIFY_SOURCE=3 -I/usr/include/octave-8.4.0/octave/.. -I/usr/include/octave-8.4.0/octave  -pthread -fopenmp -g -O2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -ffile-prefix-map=/build/octave-GcaGjM/octave-8.4.0=. -flto=auto -ffat-lto-objects -fstack-protector-strong -fstack-clash-protection -Wformat -Werror=format-security -fcf-protection -fdebug-prefix-map=/build/octave-GcaGjM/octave-8.4.0=/usr/src/octave-8.4.0-1build5 -rdynamic  -O3 -Wall -shared -std=c++11 -fPIC -o octave_pybind11.so  /tmp/oct-j661Qv.o    -fPIC  -L/usr/lib/x86_64-linux-gnu  -L/usr/lib/x86_64-linux-gnu -L/usr/lib/x86_64-linux-gnu/octave/8.4.0 -loctinterp -loctave

clean:
	-rm -f octave_pybind11.so

test:
	LD_PRELOAD="/usr/lib/x86_64-linux-gnu/octave/8.4.0/liboctinterp.so.11 /usr/lib/x86_64-linux-gnu/octave/8.4.0/liboctave.so.10" $(PYTHON) octave_pybind11_test.py
	#
	#$(PYTHON) octave_pybind11_test.py # ImportError: liboctinterp.so.11: cannot open shared object file: No such file or directory
	#LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/octave/8.4.0/ $(PYTHON) octave_pybind11_test.py # error: /usr/lib/x86_64-linux-gnu/octave/8.4.0/oct/x86_64-pc-linux-gnu/__init_gnuplot__.oct: failed to load | Incompatible version or missing dependency? | /usr/lib/x86_64-linux-gnu/octave/8.4.0/oct/x86_64-pc-linux-gnu/__init_gnuplot__.oct: undefined symbol: _ZTI17octave_base_value | error: called from | /usr/lib/x86_64-linux-gnu/octave/8.4.0/oct/x86_64-pc-linux-gnu/PKG_ADD at line 4 column 5 | as if liboctinterp.so.11 did not get loaded
