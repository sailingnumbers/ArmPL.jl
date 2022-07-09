
# to run julia with 1 cpu core and maximum number of blas threads:
# OPENBLAS_NUM_THREADS=# BLIS_NUM_THREADS=# LD_LIBRARY_PATH=/opt/arm/armpl_22.0.2_gcc-11.2/lib ./julia -t 1

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
include("thread_pinning.jl")

include("armpl_blas.jl")
include("benchmarks.jl")

include("openblas_blas.jl")
include("benchmarks.jl")

include("blisblas_blas.jl")
include("benchmarks.jl")

# include("")
# include("")
# include("")
# include("")
