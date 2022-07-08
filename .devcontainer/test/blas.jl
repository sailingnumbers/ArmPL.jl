# blas.jl

println("
#############################################
# SET BLAS
#############################################")
# (option) change blas (armplblas or OpenBLAS)

# set ArmPLBLAS
  @info "RESULTS: ARM PERFORMANCE LIBRARIES BLAS"
  using ArmPLBLAS

# @info "RESULTS: OpenBLAS"
  # in case of a need, change to OpenBLAS (usually in /opt/julia/lib/julia/):
  # BLAS.lbt_forward("libopenblas64_.0.3.13.so", clear=true, verbose=true)
  # println("BLAS CONFIGURATION => ", BLAS.get_config())
  # println("Current # of BLAS => ", BLAS.get_num_threads())
  # println("Set BLAS # of threads => ", BLAS.set_num_threads(1))
  
println("")