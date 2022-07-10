# aplb.jl

# About
Julia bindings (libblastrampoline) to Arm Performance Libraries (BLAS). 
This package is linking <libarmpl.so> usually symlinked to <libarmpl_ilp64_mp.so>.
Example location of <libarmpl.so> / <libarmpl_ilp64_mp.so>: </opt/arm/armpl_22.0.2_gcc-11.2/lib]>.
We are using _ilp64 which means 64-bit Ints (i), longs (l) and pointers (p) and _mp implies the OpenMP threaded version.
Currently only Unix, 64 bit operating systems are supported. (Other option is lp64 for 32-bit ints, again, currently not supported).

# Requirements
The package requires:
    - Arm Performance Libraries present on the system
      (for details about installation procedure please see:
      https://developer.arm.com/downloads/-/arm-performance-libraries);
and
    - <LD_LIBRARY_PATH> environmental variable set to
      a directory containing <libarmpl_ilp64_mp.so>
      i.e. LD_LIBRARY_PATH=/opt/arm/armpl_22.0.2_gcc-11.2/lib julia."

# Install
import Pkg; Pkg.add(url="https://github.com/JuliaArm/ArmPL.jl")
or
] add https://github.com/JuliaArm/ArmPL.jl

# Usage
julia> using ArmPL

=> ArmPL sets number of BLAS threads to maximum automaticly,
   based on default values of <OMP_NUM_THREADS> environmental variable,
   this environmental variable can be controlled manualy and 
   desired number of BLAS threads can be provided i.e. at the time of julia start:
   <OMP_NUM_THREADS=1 LD_LIBRARY_PATH=/opt/arm/armpl_22.0.2_gcc-11.2/lib julia -t auto>.

# Special thanks
OP, CB, 

# Licence
ArmPL.jl is released under the terms of the MIT "Expat" License.

# Legal disclaimers
This account is a private GitHub account. 
Package naming try to follow best Julia Language Community practices. 
All registered trademarks, copyrigths and intellectual property rights belong to their respected owners.

# Contact
juliaarm@proton.me 

[Please use with caution. Major purposes: friends making, serious questions. 
Due to time constraints not all messages may be answered immediately. 
Please be advised that questions explicitly related to this particular Julia package 
should be addressed by Julia Discourse chanell and any potential issuess by GitHub chanell.]

not by any means 