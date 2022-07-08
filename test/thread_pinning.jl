# thread pinning

println("
###############################################
# THREAD PINNING - only Unix systems supported
###############################################")
# (option) change thread pinning (default, compact and spread)
using ThreadPinning
using DataFrames
using UnicodePlots

# to use default pinning do nothing, otherwise:
# @info "Start benchmarks with default thread pinning"

# uncomment following lines to set compact pinning
@info "Start benchmarks with compact thread pinning"
ThreadPinning.pinthreads(:compact)

# uncomment following lines to set spread pinning
# @info "Start benchmarks with spread thread pinning"
# ThreadPinning.pinthreads(:spread)

println("
###############################################
# THREAD PINNING - threadinfo
###############################################")
threadPinning.threadinfo(; blas=true, hints=true, color=true) 
# to check as blas hints might not be supported with ArmPLBLAS

println("
#################################################
# THREAD PINNING - Core 2 core latencies: results
#################################################")
latencies = ThreadPinning.bench_core2core_latency()

println("
#################################################
# THREAD PINNING - Core 2 core latencies: plot
print(UnicodePlots.heatmap(latencies, colorbar=true, colormap=:jet))
@info "GC.gc()" GC.gc() # clear gc