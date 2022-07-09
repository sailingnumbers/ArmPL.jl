# versions.jl

println("
#############################################
# CHECK JULIA VERSION
#############################################")
using InteractiveUtils
  InteractiveUtils.versioninfo()
  @info "Sys.BINDIR" Sys.BINDIR
  @info "Sys.STDLIB" Sys.STDLIB
  @info "Sys.CPU_THREADS " Sys.CPU_THREADS
  @info "Julia # of threads" Threads.nthreads()

println("
#############################################
# CHECK VERSIONS OF PACKAGES
#############################################")
using Pkg
  @info "Pkg.status()" Pkg.status("BenchmarkTools")
  @info "Pkg.status()" Pkg.status("Hwloc")
  @info "Pkg.status()" Pkg.status("ThreadPinning")
  @info "Pkg.status()" Pkg.status("STREAMBenchmark")
  @info "Pkg.status()" Pkg.status("BandwidthBenchmark")

println("")