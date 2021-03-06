# blisblas_blas.jl

println(cray_fg_color(r, g, b),"
#############################################
# SET BLAS
#############################################")
# (option) change blas (ArmPL or OpenBLAS)

# set ArmPL
  # @info "ARM PERFORMANCE LIBRARIES BLAS"
  # using ArmPL

# @info "OpenBLAS"
#   # set BLAS to OpenBLAS (usually in /opt/julia/lib/julia/):
#   BLAS.lbt_forward("libopenblas64_.0.3.13.so", clear=true, verbose=true)
#   println("BLAS CONFIGURATION => ", BLAS.get_config())
#   println("Current # of BLAS threads => ", BLAS.get_num_threads())
#   # println("Set BLAS # of threads => ", BLAS.set_num_threads(1))

@info "BLISBLAS"
  using BLISBLAS
  println("BLAS CONFIGURATION => ", BLAS.get_config())
  println("Current # of BLAS threads => ", BLAS.get_num_threads())
  # println("Set BLAS # of threads => ", BLAS.set_num_threads(1))
  
println("")