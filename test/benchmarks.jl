# benchmarks.jl

println("
#############################################
# SET OF BASIC BLAS BENCHMARKS:
#############################################")
using LinearAlgebra
using BenchmarkTools
@info "clear GC" GC.gc()

println("
#############################################
# BLAS BENCHMARKS - peakflops
#############################################")
@info "pekflops() ", peakflops()
@info "clear GC" GC.gc()

println("
#############################################
# BLAS BENCHMARKS - matrix 10 x 10
#############################################")
A = rand(10,10); B = rand(10,10);
# to do: print results
benchmark = @benchmark $A * $B
#@show(benchmark )
#@show(benchmark = @benchmark $A * $B)
@info "clear GC" GC.gc()

benchmarkable = @benchmarkable benchmark gcsample=false samples=100 seconds = 7200
    # run(benchmarkable)
    btime = run(benchmarkable)

    println()

    # println("N=$i")
    #@show btime
    display(btime)
    #dump(btime)

println("
#############################################
# BLAS BENCHMARKS - matrix 1000 x 10000
#############################################")
A = rand(1000,1000); B = rand(1000,1000);
# to do: print results
benchmark = @benchmark $A * $B
@show(benchmark )
@show(benchmark = @benchmark $A * $B)
@info "clear GC" GC.gc()

println("
#############################################
# BLAS BENCHMARKS - matrix 10000 x 10000
#############################################")
C = rand(10000,10000); D = rand(10000,10000);
# to do: print results
@benchmark $C * $D
@info "clear GC" GC.gc()

println("
#############################################
# BLAS BENCHMARKS - axpy!
#############################################")
n = [10^k for k in 1:6]
x, y = [rand(ni) for ni in n], [rand(ni) for ni in n]
α = sqrt(pi)
# to do: print results
@benchmark LinearAlgebra.BLAS.axpy!(α, x, y)
# thx MF
@info "clear GC" GC.gc()


# a = 2.0
# b = Float64.(collect(1:100_000_000)) # create a big array of Floats
# c = Float64.(collect(1:100_000_000)) # create a big array of Floats

println("
#############################################
# SET OF BANDWIDTHBENCHMARKS:
#############################################")
using BandwidthBenchmark

println("
##################################################################
# BANDWIDTHBENCHMARK - memory bandwidth using streaming kernels
##################################################################")
print(BandwidthBenchmark.bwbench(#= ; verbose=true =#))
@info "clear GC" GC.gc()

println("
#######################################################################
# BANDWIDTHBENCHMARK - memory bandwidth - increasing number of threads
#######################################################################")
df = DataFrame(BandwidthBenchmark.bwscaling(#= ; verbose=true =#), :auto)
print(UnicodePlots.lineplot(df[!,:x1], df[!,:x2], title = "Memory bandwidth (bwscaling) - (1:max_nthreads) [lineplot])", xlabel = "# of cores", ylabel = "MFlops/s", border=:dotted))
print(UnicodePlots.barplot(
        df[!,:x1], 
        df[!,:x2],
        title = "Memory bandwidth (bwscaling) - (1:max_nthreads) [barplot]"
        ))
@info "clear GC" GC.gc()

println("
#################################################################################
# BANDWIDTHBENCHMARK - floating point performance - increasing number of threads
# (triad kernel based scaling)
#################################################################################")
df = DataFrame(BandwidthBenchmark.flopsscaling(), :auto)
print(UnicodePlots.lineplot(
        df[!,:x1], df[!,:x2], 
        title = "Floating point performance (flopsscaling) - increasing number of threads [lineplot]", 
        xlabel = "# of cores", ylabel = "MFlops/s", 
        border=:dotted))
print(UnicodePlots.barplot(
        df[!,:x1], 
        df[!,:x2],
        title = "Floating point performance (flopsscaling) - increasing number of threads  [barplot]"
        ))
@info "clear GC" GC.gc()

println("
#############################################
# SET OF STREAMBenchmarks:
#############################################")
using BandwidthBenchmark

println("
#######################################################################
# STREAMBenchmark - maximal memory bandwidth (single and multithreaded)
#######################################################################")
using STREAMBenchmark
@info "Results: Estimating achievable (maximal) memory bandwidth (single and multithreaded)"
STREAMBenchmark.benchmark()

println("
#######################################################################
# STREAMBenchmark - maximal memory wrt the number of threads
#######################################################################")
y = STREAMBenchmark.scaling_benchmark()
print(UnicodePlots.lineplot(1:length(y), y, title = "Bandwidth Scaling", xlabel = "# cores", ylabel = "MB/s", border = :dotted#= , canvas = AsciiCanvas =#))
@info "GC.gc()" GC.gc() # clear gc

println("
#######################################################################
# STREAMBenchmark - vector lengths check
# (default is four times the size of the outermost cache)
#######################################################################")
STREAMBenchmark.vector_length_dependence()