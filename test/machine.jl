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