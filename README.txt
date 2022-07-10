# aplb.jl

# About
Julia bindings (libblastrampoline) to Arm Performance Libraries (BLAS). This package is linking <libarmpl.so> usually symlinked to <libarmpl_ilp64_mp.so>. Example location of <libarmpl.so> / <libarmpl_ilp64_mp.so>: </opt/arm/armpl_22.0.2_gcc-11.2/lib]>. As stated, we are using _ilp64 which means 64-bit Ints (i), longs (l) and pointers (p) and _mp implies the OpenMP threaded version. Currently only Unix, 64 bit operating systems are supported. (Other option is lp64 for 32-bit ints, again, currently not supported). Please also be advised that such components of Arm Performance Libraries like <libamath.so> [faster transcendental math functions (sin, cos, pow)] and <libastring.so> [faster string processing operations] are currently not supported.

# Requirements
The package requires:
  - Unix, 64 bit operating system;
  - Arm Performance Libraries present on the system
    (for details about installation procedure please see:
    https://developer.arm.com/downloads/-/arm-performance-libraries);
  - <LD_LIBRARY_PATH> environmental variable set to
    a directory containing <libarmpl_ilp64_mp.so>
    i.e. LD_LIBRARY_PATH=/opt/arm/armpl_22.0.2_gcc-11.2/lib julia."

# Install
julia> import Pkg; Pkg.add(url="https://github.com/JuliaArm/ArmPL.jl")
or
] add https://github.com/JuliaArm/ArmPL.jl

# Usage
julia> using ArmPL

  - ArmPL.jl [<libarmpl.so> / <libarmpl_ilp64_mp.so>] sets number of BLAS threads to maximum automaticly,
    based on default values of operating system <OMP_NUM_THREADS> environmental variable,
    <OMP_NUM_THREADS> environmental variable can be (also) controlled manualy and 
    desired number of BLAS threads can be provided i.e. at the time of Julia start:
    <OMP_NUM_THREADS=1 LD_LIBRARY_PATH=/opt/arm/armpl_22.0.2_gcc-11.2/lib julia -t auto>;
  
  Additional usage information:
  - in case processed Julia code is parallel, restrrict ArmPL.jl and Julia threads to 1 and 
    add desired number of processes e.g. start julia with: 
    OMP_NUM_THREADS=1 LD_LIBRARY_PATH=/opt/arm/armpl_22.0.2_gcc-11.2/lib julia -p 80 -t 1 and then:
    julia>  using Distributed
            @everywhere begin
              using ArmPL
              <your code>
            end
  - in case of single threaded Julia code calling expensive BLAS operations, restrrict Julia to 1 thread and 
    let ArmPL.jl to handle maximum number of BLAS threads automaticly (as indicated above) i.e. 
    LD_LIBRARY_PATH=/opt/arm/armpl_22.0.2_gcc-11.2/lib julia -t 1
    or set it manually (as also indicated above) i.e.
    <OMP_NUM_THREADS=80 LD_LIBRARY_PATH=/opt/arm/armpl_22.0.2_gcc-11.2/lib julia -t 1
  - in case of calling ArmPL.jl from different threads in parallel, restrict ArmPL.jl to 1 thread i.e.
    <OMP_NUM_THREADS=1 LD_LIBRARY_PATH=/opt/arm/armpl_22.0.2_gcc-11.2/lib julia -t 80

# Tests

# Licence
ArmPL.jl is released under the terms of the MIT "Expat" License.

# Legal disclaimers
This account is a private GitHub account. Package naming tries to follow best Julia Language Community practices. All registered trademarks, copyrigths and intellectual property rights belong to their respected owners.

# Contact
juliaarm at proton dot me [Please use with caution. Major purposes: friends making, serious questions. Due to time constraints not all messages may be answered immediately. Please be advised that any potential questions explicitly related to the usage of this particular Julia package should be addressed by Julia Discourse chanell and any potential issuess by GitHub chanell.]

# Special thanks
OP, CB, CE, MG, MF, CG, JL, JH