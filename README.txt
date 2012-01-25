TH Tensor Library.
===============

TH Tensor Library is a fork of Torch-7 to separate the highly optimized C 
functions from the Lua parts, so that the C functions can be plugged into 
other projects.
TH includes GPU support for a subset of NVIDIA cards using NVIDIA CUDA library.
It also includes a OpenMP parallelizations for a small set of Linear algebra 
functions.

There is no documentation provided with this library, or with torch, for 
these functions. Any sparse documentation, if any, would be found in the code, 
usually in the .c and .cu files
Since C does not support templates, TH uses a macro based templating. 
Hence, if you would like to see the functions present in the library, 
you need to expand the headers to get the list of function signatures available.
Using gcc, this can be done using the gcc -E option.

Notes
============
All efforts will be made to keep them in sync with Torch-7's changes. If they 
seem out of date or if you have any questions on usage, 
you can email me at my-git-username@gmail.com

If you're looking for a C++ library that includes some of these optimizations,
you can look at http://eblearn.sourceforge.net
The TH optimizations in eblearn are experimental and not ready for daily use.
This message will be edited when they are ready for stable use.
