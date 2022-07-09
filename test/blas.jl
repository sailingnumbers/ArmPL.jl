# blas.jl

println(Crayon(background = (0, 145, 189)),"
#############################################
# SET BLAS
#############################################")
# (option) change blas (aplb or OpenBLAS)

# set aplb
  @info "ARM PERFORMANCE LIBRARIES BLAS"
  using aplb

# @info "OpenBLAS"
  # set BLAS to OpenBLAS (usually in /opt/julia/lib/julia/):
  # BLAS.lbt_forward("libopenblas64_.0.3.13.so", clear=true, verbose=true)
  # println("BLAS CONFIGURATION => ", BLAS.get_config())
  # println("Current # of BLAS => ", BLAS.get_num_threads())
  # println("Set BLAS # of threads => ", BLAS.set_num_threads(1))
  
println("")