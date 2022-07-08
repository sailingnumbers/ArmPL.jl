# versions.jl

@info "Check julia version"
using InteractiveUtils
  InteractiveUtils.versioninfo()
  @info "Sys.BINDIR" Sys.BINDIR
  @info "Sys.STDLIB" Sys.STDLIB
  
@info "Check versions of packages"
  using Pkg
  @info "Pkg.status()" Pkg.status("BenchmarkTools")
  @info "Pkg.status()" Pkg.status("Hwloc")
  @info "Pkg.status()" Pkg.status("ThreadPinning")
  @info "Pkg.status()" Pkg.status("STREAMBenchmark")
  @info "Pkg.status()" Pkg.status("BandwidthBenchmark")

