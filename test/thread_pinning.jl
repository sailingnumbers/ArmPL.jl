# thread_pinning.jl

println(cray_fg_color(r, g, b),"
###############################################
# THREAD PINNING
###############################################")
# (option) change thread pinning (default, compact and spread)
using ThreadPinning
using DataFrames
using UnicodePlots

# to use default pinning do nothing, 
# just uncomment following line to print info
# @info "Start benchmarks with default thread pinning"

# otherwise:

# uncomment following lines to set compact pinning
@info "Start benchmarks with compact thread pinning"
ThreadPinning.pinthreads(:compact)

# uncomment following lines to set spread pinning
# @info "Start benchmarks with spread thread pinning"
# ThreadPinning.pinthreads(:spread)

println(cray_fg_color(r, g, b),"
# THREAD PINNING - threadinfo")
print(ThreadPinning.threadinfo(; blas=true, hints=true, color=true))
# to check: as blas hints might not be supported ThreadPinning with ArmPL

println()

println(cray_fg_color(r, g, b),"
# THREAD PINNING - Core 2 core latencies: results
# TO DO: ┌ Error: Need at least two Julia threads.")
latencies = ThreadPinning.bench_core2core_latency();
display(latencies)

println(cray_fg_color(r, g, b),"
# THREAD PINNING - Core 2 core latencies: plot")
print(UnicodePlots.heatmap(latencies, colorbar=true, colormap=:jet))
@info "GC.gc()" GC.gc() # clear gc