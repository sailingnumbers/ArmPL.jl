
# # install packages
# using Pkg
#   Pkg.add("BenchmarkTools")
#   Pkg.add("Hwloc")
#   Pkg.add("ThreadPinning")
#   Pkg.add("DataFrames")
#   Pkg.add("UnicodePlots")
#   Pkg.add("STREAMBenchmark")
#   Pkg.add(url="https://github.com/carstenbauer/BandwidthBenchmark.jl")





@info "Check basic machine specs"
  @info "Sys.CPU_NAME" Sys.CPU_NAME
  @info "Sys.MACHINE" Sys.MACHINE
  @info "Sys.ARCH" Sys.ARCH   
  println("Sys.CPU_THREADS ", Sys.CPU_THREADS)
  @info "Number of threads" Threads.nthreads()
  @info "Sys.total_memory" Sys.total_memory()
  @info "Sys.free_memory" Sys.free_memory()
  @info "Sys.loadavg" Sys.loadavg()
  @info "Sys.KERNEL" Sys.KERNEL
  @info "Sys.islinux" Sys.islinux()
  @info "Sys.isunix" Sys.isunix()
  @info "Sys.isbsd()" Sys.isbsd()
  @info "Sys.isfreebsd" Sys.isfreebsd()
  @info "Sys.iswindows" Sys.iswindows()
  @info "Sys.isapple()" Sys.isapple()
  @info "Sys.SC_CLK_TCK" Sys.SC_CLK_TCK


@info "Check topology"
using Hwloc
  @info "Basic topology info" Hwloc.topology_info()
  println()
  @info "Detailed topology info" Hwloc.topology()




println("#############################################")
# (option) change blas (armplblas or OpenBLAS)

  # set armplblas defined at the top
    @info "RESULTS: ARM PERFORMANCE LIBRARIES BLAS"
    using Main.armplblas

  # @info "RESULTS: OpenBLAS"
    # change to OpenBLAS (usually in /opt/julia/lib/julia/):
    # BLAS.lbt_forward("libopenblas64_.0.3.13.so", clear=true, verbose=true)
    # println("BLAS CONFIGURATION => ", BLAS.get_config())
    # println("Current # of BLAS => ", BLAS.get_num_threads())
    # println("Set BLAS # of threads => ", BLAS.set_num_threads(1))
  println("#############################################")

  println("")

println("#############################################")
# (option) change threads pinning (default, compact and spread)
@info "THREADS PINNING"
@info "Note: ThreadPinning supports only Unix systems"
    using ThreadPinning
    using DataFrames
    using UnicodePlots

  # @info "Start benchmarks with default thread pinning"
  # to use default pinning do nothing, otherwise please see below.

  # uncomment to set compact pinning
    @info "Start benchmarks with compact thread pinning"
    ThreadPinning.pinthreads(:compact)

  # uncomment to set spread pinning
    # @info "Start benchmarks with spread thread pinning"
    # ThreadPinning.pinthreads(:spread)
  println("#############################################")

  println("")

@info "Pinning threadinfo" ThreadPinning.threadinfo(; blas=true, hints=true, color=true) # to check as blas hints might not be supported with armplblas

@info "Benchmark results: Core 2 core latencies: results" 
  latencies = ThreadPinning.bench_core2core_latency()

@info "Benchmark results: Core 2 core latencies: plot" 
  print(UnicodePlots.heatmap(latencies, colorbar=true, colormap=:jet))
  @info "GC.gc()" GC.gc() # clear gc



# basic blas benchmarks
using LinearAlgebra
using BenchmarkTools
  @info "GC.gc()" GC.gc() # clear gc
@info "Results: matrix multiplcation: 1000 x 1000"
  A = rand(1000,1000); B = rand(1000,1000);
  @benchmark $A * $B
  @info "GC.gc()" GC.gc() # clear gc

@info "Results: matrix multiplcation: 10000 x 10000"
 C = rand(10000,10000); D = rand(10000,10000);
 @benchmark $C * $D
  @info "GC.gc()" GC.gc() # clear gc

@info "Results: using axpy!" # thx @mforets
  n = [10^k for k in 1:6]
  x, y = [rand(ni) for ni in n], [rand(ni) for ni in n]
  α = sqrt(pi)
  @benchmark LinearAlgebra.BLAS.axpy!(α, x, y)
  @info "GC.gc()" GC.gc() # clear gc

@info "Basic peakflops"
  peakflops()
  @info "GC.gc()" GC.gc() # clear gc
@info "Results: BandwidthBenchmark"

a = 2.0
b = Float64.(collect(1:100_000_000)) # create a big array of Floats
c = Float64.(collect(1:100_000_000)) # create a big array of Floats

using BandwidthBenchmark
@info "Results: Measurement of memory bandwidth using streaming kernels"
  results = BandwidthBenchmark.bwbench(#= ; verbose=true =#)

@info "Results: Measurment of memory bandwidth for an increasing number of threads"
  df = DataFrame(BandwidthBenchmark.bwscaling(#= ; verbose=true =#), :auto)
  print(UnicodePlots.lineplot(df[!,:x1], df[!,:x2], title = "Memory bandwidth (bwscaling) - (1:max_nthreads) [lineplot])", xlabel = "# of cores", ylabel = "MFlops/s", border=:dotted))
  print(UnicodePlots.barplot(
          df[!,:x1], 
          df[!,:x2],
          title = "Memory bandwidth (bwscaling) - (1:max_nthreads) [barplot]"
          ))
  @info "GC.gc()" GC.gc() # clear gc

@info "Results: Scaling of the floating point performance (flopsscaling) for increasing number of threads (triad kernel based)"
  df = DataFrame(BandwidthBenchmark.flopsscaling(), :auto)
  print(UnicodePlots.lineplot(df[!,:x1], df[!,:x2], title = "Scalling of floating point performance (flopsscaling) [lineplot]", xlabel = "# of cores", ylabel = "MFlops/s", border=:dotted))
  print(UnicodePlots.barplot(
          df[!,:x1], 
          df[!,:x2],
          title = "Scalling of floating point performance (flopsscaling) [barplot]"
          ))
  @info "GC.gc()" GC.gc() # clear gc



using STREAMBenchmark
  @info "Results: Estimating achievable (maximal) memory bandwidth (both single and multithreaded)"
    STREAMBenchmark.benchmark()

  @info "Results: Maximal memory bandwidth with regard to the number of threads"
    y = STREAMBenchmark.scaling_benchmark()
    print(UnicodePlots.lineplot(1:length(y), y, title = "Bandwidth Scaling", xlabel = "# cores", ylabel = "MB/s", border = :dotted#= , canvas = AsciiCanvas =#))
    @info "GC.gc()" GC.gc() # clear gc

  @info "Results: Vector lengths (default is four times the size of the outermost cache)"
    STREAMBenchmark.vector_length_dependence()