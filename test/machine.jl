# machine.jl

println("
#############################################
# CHECK BASIC MACHINE SPECS
#############################################")

@info "Sys.CPU_NAME" Sys.CPU_NAME
@info "Sys.MACHINE" Sys.MACHINE
@info "Sys.CPU_THREADS " Sys.CPU_THREADS # same as in versions.jl
@info "Julia # of threads" Threads.nthreads() # same as in versions.jl
@info "Sys.total_memory" Sys.total_memory()
@info "Sys.free_memory" Sys.free_memory()
@info "Sys.loadavg" Sys.loadavg()
@info "Sys.ARCH" Sys.ARCH   
@info "Sys.KERNEL" Sys.KERNEL
@info "Sys.islinux" Sys.islinux()
@info "Sys.isunix" Sys.isunix()
@info "Sys.isbsd()" Sys.isbsd()
@info "Sys.isfreebsd" Sys.isfreebsd()
@info "Sys.iswindows" Sys.iswindows()
@info "Sys.isapple()" Sys.isapple()
@info "Sys.SC_CLK_TCK" Sys.SC_CLK_TCK

println("
#############################################
# CHECK TOPOLOGY
#############################################")
using Hwloc
  @info "Basic topology info" Hwloc.topology_info()
  println()
  @info "Detailed topology info" Hwloc.topology()

println()

println("
#############################################
# SET OF BANDWIDTHBENCHMARKS:
#############################################")
using BandwidthBenchmark

println("
# BANDWIDTHBENCHMARK - memory bandwidth using streaming kernels")
print(BandwidthBenchmark.bwbench(#= ; verbose=true =#))
@info "clear GC", GC.gc();

println("
# BANDWIDTHBENCHMARK - memory bandwidth - increasing number of threads")
df = DataFrame(BandwidthBenchmark.bwscaling(#= ; verbose=true =#), :auto)
print(UnicodePlots.lineplot(df[!,:x1], df[!,:x2], title = "Memory bandwidth (bwscaling) - (1:max_nthreads) [lineplot])", xlabel = "# of cores", ylabel = "MFlops/s", border=:dotted))
println()
print(UnicodePlots.barplot(
        df[!,:x1], 
        df[!,:x2],
        title = "Memory bandwidth (bwscaling) - (1:max_nthreads) [barplot]"
        ))
@info "clear GC", GC.gc();

println("
# BANDWIDTHBENCHMARK - floating point performance - increasing number of threads
# (triad kernel based scaling)")
df = DataFrame(BandwidthBenchmark.flopsscaling(), :auto)
print(UnicodePlots.lineplot(
        df[!,:x1], df[!,:x2], 
        title = "Floating point performance (flopsscaling) - increasing number of threads [lineplot]", 
        xlabel = "# of cores", ylabel = "MFlops/s", 
        border=:dotted))
println()
print(UnicodePlots.barplot(
        df[!,:x1], 
        df[!,:x2],
        title = "Floating point performance (flopsscaling) - increasing number of threads  [barplot]"
        ))
@info "clear GC", GC.gc();

println("
#############################################
# SET OF STREAMBenchmarks:
#############################################")
using STREAMBenchmark

println("
# STREAMBenchmark - maximal memory bandwidth (single and multithreaded)")
@info "Results: Estimating achievable (maximal) memory bandwidth (single and multithreaded)"
STREAMBenchmark.benchmark()

println("
# STREAMBenchmark - maximal memory wrt the number of threads")
y = STREAMBenchmark.scaling_benchmark()
print(UnicodePlots.lineplot(1:length(y), y, title = "Bandwidth Scaling", xlabel = "# cores", ylabel = "MB/s", border = :dotted#= , canvas = AsciiCanvas =#))
@info "GC.gc()" GC.gc() # clear gc

println("
# STREAMBenchmark - vector lengths check
# (default is four times the size of the outermost cache)")
STREAMBenchmark.vector_length_dependence()