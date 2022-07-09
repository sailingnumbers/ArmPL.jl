
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
include("blas.jl")
include("thread_pinning.jl")
include("benchmarks.jl")

# include("")
# include("")
# include("")
# include("")
