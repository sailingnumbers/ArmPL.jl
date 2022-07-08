module aplb

import LinearAlgebra.BLAS
function __init__()
  if  "LD_LIBRARY_PATH" in keys(ENV) && # check if <LD_LIBRARY_PATH> is set AND
    # check if <libarmpl_ilp64_mp.so> is present in <LD_LIBRARY_PATH>:
    isfile(joinpath(ENV["LD_LIBRARY_PATH"], "libarmpl_ilp64_mp.so"))
    println("Thanks for using Julia bindings to Arm Performance Libraries (BLAS).")
    # link <libarmpl_ilp64_mp.so> instead of default libblas.so; AND
    # clear out all previous mappings before setting new ones 
      # (change to false if layering of libraries is required); AND
    # verbose output:
    println("Linking => ", joinpath(ENV["LD_LIBRARY_PATH"], "libarmpl_ilp64_mp.so"))
    BLAS.lbt_forward("libarmpl_ilp64_mp.so", clear=true, verbose=true)
    # print current BLAS configuration:
    println("BLAS configuration => ", BLAS.get_config())
    # BLAS.set_num_threads() and BLAS.get_num_threads() are vendor-specific APIs
      # and in this case are not supported by libblastrampoline, however,
      # <libarmpl_ilp64_mp.so> sets number of maximum BLAS threads automaticly.
  else
    @error "
    Basic requirements to use <ArmPLBLAS> are not met.
    Please check if:
    - Arm Performance Libraries are present on the system
      (for details about installation procedure please see:
      https://developer.arm.com/downloads/-/arm-performance-libraries);
    and / or if
    - <LD_LIBRARY_PATH> environmental variable is set to
      a directory containing <libarmpl_ilp64_mp.so>
      i.e. LD_LIBRARY_PATH=/opt/arm/armpl_22.0.2_gcc-11.2/lib julia -t 1."
  end
end

end # module
