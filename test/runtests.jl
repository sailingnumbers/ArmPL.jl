
# to run julia with 1 cpu core and desired number of blas threads:
# OPENBLAS_NUM_THREADS=# BLIS_NUM_THREADS=# OMP_NUM_THREADS=# LD_LIBRARY_PATH=/opt/arm/armpl_22.0.2_gcc-11.2/lib ./julia -t 1
# or 
# OPENBLAS_NUM_THREADS=1 BLIS_NUM_THREADS=1 OMP_NUM_THREADS=1 LD_LIBRARY_PATH=/opt/arm/armpl_22.0.2_gcc-11.2/lib ./julia -t auto

# By default armpl will just use OMP_NUM_THREADS if there is nested parallelism then it can use that but obviously that’s a bit more complex to tune. 

# libarmpl.so – usually simlinked to libarmpl_mp_ilp64.so
# _mp = implies the OpenMP threaded version
# _ilp64 = Means we are using 64-bit Ints (i), longs (l) and pointers (p), other option is lp64 for 32-bit ints. 


# # install packages
# using Pkg
#   Pkg.add("BenchmarkTools")
#   Pkg.add("Hwloc")
#   Pkg.add("ThreadPinning")
#   Pkg.add("DataFrames")
#   Pkg.add("UnicodePlots")
#   Pkg.add("STREAMBenchmark")
#   Pkg.add(url="https://github.com/carstenbauer/BandwidthBenchmark.jl")
#   Pkg.add("Crayons")

include("versions.jl")
include("machine.jl")

include("armpl_blas.jl")
include("thread_pinning.jl")
include("benchmarks.jl")

include("openblas_blas.jl")
include("thread_pinning.jl")
include("benchmarks.jl")

include("blisblas_blas.jl")
include("thread_pinning.jl")
include("benchmarks.jl")

include("summary.jl")

# include("")
# include("")
# include("")
