
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

using Crayons
# function Crayons foreground
function cray_fg_color(r, g, b)
    Crayon(foreground = (r, g, b))
end

# set Crayons foreground
r=0; g=145; b=189
include("armpl_blas.jl")
include("thread_pinning.jl")
include("benchmarks.jl")

# set Crayons foreground
r=127; g=0; b=255
include("openblas_blas.jl")
include("thread_pinning.jl")
include("benchmarks.jl")

# set Crayons foreground
r=245; g=255; b=36
include("blisblas_blas.jl")
include("thread_pinning.jl")
include("benchmarks.jl")

include("summary.jl")

# include("")
# include("")
# include("")
