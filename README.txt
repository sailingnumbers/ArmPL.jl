This is a very preliminary (testing and working) release.

# About:

    Julia bindings to Arm Performance Libraries (BLAS). 

    This package is using <libblastrampoline> to link <libarmpl.so> which is
    usually symlinked to <libarmpl_ilp64_mp.so>; _ilp64 means 64-bit Ints (i),
    longs (l) and pointers (p) and _mp implies the OpenMP threaded version.
    After system installation of Arm Performance Libraries, usual location of
    <libarmpl_ilp64_mp.so> is i.e. </opt/arm/armpl_22.0.2_gcc-11.2/lib>.

    Please be advised that such components of Arm Performance Libraries as
    <libamath.so> (faster transcendental math functions (sin, cos, pow)) and
    <libastring.so> (faster string processing operations) are currently not
    supported.


# Requirements:

    - Unix, 64 bit operating system;

    - Arm Performance Libraries present on the system,
      (for details about installation procedure please see:
      https://developer.arm.com/downloads/-/arm-performance-libraries);

    - <LD_LIBRARY_PATH> environmental variable set 
      to a directory containing <libarmpl_ilp64_mp.so> i.e.

      LD_LIBRARY_PATH=/opt/arm/armpl_22.0.2_gcc-11.2/lib julia.


# Install:

    julia> import Pkg; Pkg.add(url="https://github.com/JuliaArm/ArmPL.jl")
    
    or
    
    ] add https://github.com/JuliaArm/ArmPL.jl


# Usage:

    julia> using ArmPL


# Additional usage information:

  - ArmPL (<libarmpl_ilp64_mp.so>) sets number of BLAS threads to maximum automatically,
    based on default values of operating system <OMP_NUM_THREADS> environmental variable;
    <OMP_NUM_THREADS> environmental variable can be controlled manually and desired number 
    of BLAS threads can be provided i.e. at the time of Julia start;

  - in case processed Julia code is parallel, restrict ArmPL and Julia threads to 1 and 
    add desired number of processes e.g. start julia with: 
    
    OMP_NUM_THREADS=1 LD_LIBRARY_PATH=/opt/arm/armpl_22.0.2_gcc-11.2/lib julia -p 80 -t 1 
    
    and then:
    
    julia>  using Distributed
            @everywhere begin
              using ArmPL
              <your code>
            end

  - in case of single threaded Julia code calling expensive BLAS operations,
    restrict Julia to 1 thread and let ArmPL handle maximum number of
    BLAS threads automatically i.e.

    LD_LIBRARY_PATH=/opt/arm/armpl_22.0.2_gcc-11.2/lib julia -t 1 
    
    or set it manually i.e. 
    
    <OMP_NUM_THREADS=80 LD_LIBRARY_PATH=/opt/arm/armpl_22.0.2_gcc-11.2/lib julia -t 1>

  - in case of calling ArmPL from different threads in parallel, restrict ArmPL to 1 thread i.e.

    <OMP_NUM_THREADS=1 LD_LIBRARY_PATH=/opt/arm/armpl_22.0.2_gcc-11.2/lib julia -t 80>


# Tests:

  A suite of example tests for ArmPL, OpenBlas, BLISBLAS is included i.e. 
  core to core latencies, matrix multiplication, axpy!, memory bandwidth ... 
  
  To use:

  - clone the repository:
    git clone https://github.com/JuliaArm/ArmPL.jl

  - change directory:
    cd ArmPL.jl/test
  
  - start tests: 
    <OMP_NUM_THREADS=1 LD_LIBRARY_PATH=/opt/arm/armpl_22.0.2_gcc-11.2/lib 
    julia -t auto runtests.jl>


# Testing environment:

  The package was tested on Neoverse N1, Oracle Linux 8.5 / Ubuntu 20.04.4 LTS
  (Focal Fossa), Julia 1.7.3


# Licence:

  ArmPL is released under the terms of the MIT "Expat" License.


# Legal disclaimers:

  This account is a private GitHub account. Package naming tries to follow
  the best Julia Language Community practices. All registered trademarks,
  copyrights and intellectual property rights belong to their respected
  owners.


# Contact:

  juliaarm at proton dot me

  Please use with caution. Major purposes: friends making, serious questions. 
  Due to time constraints not all messages may be answered immediately.

  Please be advised that any potential questions explicitly related to the usage 
  of this Julia package should be addressed by Julia Discourse and any potential 
  issues by GitHub.


# Special thanks:

  OP, CB, CE, MG, MF, CG, JL, JH