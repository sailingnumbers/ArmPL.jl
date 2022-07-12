# benchmarks.jl

println(cray_fg_color(r, g, b),"
#############################################
# SET OF BASIC BLAS BENCHMARKS:
#############################################")
using LinearAlgebra
using BenchmarkTools
@info "clear GC", GC.gc();

println(cray_fg_color(r, g, b),"
# BLAS BENCHMARKS - peakflops")
@info "pekflops() ", peakflops()
@info "clear GC", GC.gc();

println(cray_fg_color(r, g, b),"
# BLAS BENCHMARKS - matrix 1_000 x 1_000")
A = rand(1000,1000); B = rand(1000,1000);
# to do: print results
benchmark = @benchmark $A * $B;
display(benchmark)
@info "clear GC", GC.gc();

println(cray_fg_color(r, g, b),"
# BLAS BENCHMARKS - matrix 10_000 x 10_000")
C = rand(10000,10000); D = rand(10000,10000);
# to do: print results
benchmark = @benchmark $C * $D;
display(benchmark)
@info "clear GC", GC.gc();

println(cray_fg_color(r, g, b),"
# BLAS BENCHMARKS - axpy!(sqrt(pi), 10, 10")
n = [10^k for k in 1:1]
x, y = [rand(ni) for ni in n], [rand(ni) for ni in n]
α = sqrt(pi)
# to do: print results
benchmark = @benchmark LinearAlgebra.BLAS.axpy!(α, x, y);
display(benchmark)
@info "clear GC", GC.gc();

println(cray_fg_color(r, g, b),"
# BLAS BENCHMARKS - axpy!(sqrt(pi), 100, 100")
n = [10^k for k in 2:2]
x, y = [rand(ni) for ni in n], [rand(ni) for ni in n]
α = sqrt(pi)
# to do: print results
benchmark = @benchmark LinearAlgebra.BLAS.axpy!(α, x, y);
display(benchmark)
@info "clear GC", GC.gc();

println(cray_fg_color(r, g, b),"
# BLAS BENCHMARKS - axpy!(sqrt(pi), 1000, 1000")
n = [10^k for k in 3:3]
x, y = [rand(ni) for ni in n], [rand(ni) for ni in n]
α = sqrt(pi)
# to do: print results
benchmark = @benchmark LinearAlgebra.BLAS.axpy!(α, x, y);
display(benchmark)
@info "clear GC", GC.gc();

println(cray_fg_color(r, g, b),"
# BLAS BENCHMARKS - axpy!(sqrt(pi), 10_000, 10_000")
n = [10^k for k in 4:4]
x, y = [rand(ni) for ni in n], [rand(ni) for ni in n]
α = sqrt(pi)
# to do: print results
benchmark = @benchmark LinearAlgebra.BLAS.axpy!(α, x, y);
display(benchmark)
@info "clear GC", GC.gc();

println(cray_fg_color(r, g, b),"
# BLAS BENCHMARKS - axpy!(sqrt(pi), 100_000, 100_000")
n = [10^k for k in 5:5]
x, y = [rand(ni) for ni in n], [rand(ni) for ni in n]
α = sqrt(pi)
# to do: print results
benchmark = @benchmark LinearAlgebra.BLAS.axpy!(α, x, y);
display(benchmark)
@info "clear GC", GC.gc();

println(cray_fg_color(r, g, b),"
# BLAS BENCHMARKS - axpy!(sqrt(pi), 1_000_000, 1_000_000")
n = [10^k for k in 6:6]
x, y = [rand(ni) for ni in n], [rand(ni) for ni in n]
α = sqrt(pi)
# to do: print results
benchmark = @benchmark LinearAlgebra.BLAS.axpy!(α, x, y);
display(benchmark)
@info "clear GC", GC.gc();

println(cray_fg_color(r, g, b),"
# BLAS BENCHMARKS - axpy!(sqrt(pi), 10_000_000, 10_000_000")
n = [10^k for k in 7:7]
x, y = [rand(ni) for ni in n], [rand(ni) for ni in n]
α = sqrt(pi)
# to do: print results
benchmark = @benchmark LinearAlgebra.BLAS.axpy!(α, x, y);
display(benchmark)
@info "clear GC", GC.gc();

println(cray_fg_color(r, g, b),"
# BLAS BENCHMARKS - axpy!(sqrt(pi), 100_000_000, 100_000_000")
n = [10^k for k in 8:8]
x, y = [rand(ni) for ni in n], [rand(ni) for ni in n]
α = sqrt(pi)
# to do: print results
benchmark = @benchmark LinearAlgebra.BLAS.axpy!(α, x, y);
display(benchmark)
@info "clear GC", GC.gc();

# println(cray_fg_color(r, g, b),"
# # BLAS BENCHMARKS - axpy! - sum of times for vectors from 10 to 100_000_000")
# n = [10^k for k in 1:8]
# x, y = [rand(ni) for ni in n], [rand(ni) for ni in n]
# α = sqrt(pi)
# # to do: print results
# benchmark = @benchmark LinearAlgebra.BLAS.axpy!(α, x, y);
# display(benchmark)
# @info "clear GC", GC.gc();






println(Crayon(foreground = :white),"
# BLAS BENCHMARKS - JULIA IMPLEMENTATION of axpy! - muladd(sqrt(pi), x[10], y[10])")
n = [10^k for k in 1:1]
x, y = [rand(ni) for ni in n], [rand(ni) for ni in n]
α = sqrt(pi)
function axpy!(α, x, y)
        @simd for i in eachindex(x, y)
            @inbounds y[i] = muladd(α, x[i], y[i])
       return y
    end
end
benchmark = @benchmark axpy!(α, x, y);
display(benchmark)
@info "clear GC", GC.gc();

println(Crayon(foreground = :white),"
# BLAS BENCHMARKS - JULIA IMPLEMENTATION of axpy! - muladd(sqrt(pi), x[100], y[100])")
n = [10^k for k in 2:2]
x, y = [rand(ni) for ni in n], [rand(ni) for ni in n]
α = sqrt(pi)
function axpy!(α, x, y)
        @simd for i in eachindex(x, y)
            @inbounds y[i] = muladd(α, x[i], y[i])
       return y
    end
end
benchmark = @benchmark axpy!(α, x, y);
display(benchmark)
@info "clear GC", GC.gc();

println(Crayon(foreground = :white),"
# BLAS BENCHMARKS - JULIA IMPLEMENTATION of axpy! - muladd(sqrt(pi), x[1000], y[1000])")
n = [10^k for k in 3:3]
x, y = [rand(ni) for ni in n], [rand(ni) for ni in n]
α = sqrt(pi)
function axpy!(α, x, y)
        @simd for i in eachindex(x, y)
            @inbounds y[i] = muladd(α, x[i], y[i])
       return y
    end
end
benchmark = @benchmark axpy!(α, x, y);
display(benchmark)
@info "clear GC", GC.gc();

println(Crayon(foreground = :white),"
# BLAS BENCHMARKS - JULIA IMPLEMENTATION of axpy! - muladd(sqrt(pi), x[10_000], y[10_000])")
n = [10^k for k in 4:4]
x, y = [rand(ni) for ni in n], [rand(ni) for ni in n]
α = sqrt(pi)
function axpy!(α, x, y)
        @simd for i in eachindex(x, y)
            @inbounds y[i] = muladd(α, x[i], y[i])
       return y
    end
end
benchmark = @benchmark axpy!(α, x, y);
display(benchmark)
@info "clear GC", GC.gc();

println(Crayon(foreground = :white),"
# BLAS BENCHMARKS - JULIA IMPLEMENTATION of axpy! - muladd(sqrt(pi), x[100_000], y[100_000])")
n = [10^k for k in 5:5]
x, y = [rand(ni) for ni in n], [rand(ni) for ni in n]
α = sqrt(pi)
function axpy!(α, x, y)
        @simd for i in eachindex(x, y)
            @inbounds y[i] = muladd(α, x[i], y[i])
       return y
    end
end
benchmark = @benchmark axpy!(α, x, y);
display(benchmark)
@info "clear GC", GC.gc();

println(Crayon(foreground = :white),"
# BLAS BENCHMARKS - JULIA IMPLEMENTATION of axpy! - muladd(sqrt(pi), x[1_000_000], y[1_000_000])")
n = [10^k for k in 6:6]
x, y = [rand(ni) for ni in n], [rand(ni) for ni in n]
α = sqrt(pi)
function axpy!(α, x, y)
        @simd for i in eachindex(x, y)
            @inbounds y[i] = muladd(α, x[i], y[i])
       return y
    end
end
benchmark = @benchmark axpy!(α, x, y);
display(benchmark)
@info "clear GC", GC.gc();

println(Crayon(foreground = :white),"
# BLAS BENCHMARKS - JULIA IMPLEMENTATION of axpy! - muladd(sqrt(pi), x[10_000_000], y[10_000_000])")
n = [10^k for k in 7:7]
x, y = [rand(ni) for ni in n], [rand(ni) for ni in n]
α = sqrt(pi)
function axpy!(α, x, y)
        @simd for i in eachindex(x, y)
            @inbounds y[i] = muladd(α, x[i], y[i])
       return y
    end
end
benchmark = @benchmark axpy!(α, x, y);
display(benchmark)
@info "clear GC", GC.gc();

println(Crayon(foreground = :white),"
# BLAS BENCHMARKS - JULIA IMPLEMENTATION of axpy! - muladd(sqrt(pi), x[100_000_000], y[100_000_000])")
n = [10^k for k in 8:8]
x, y = [rand(ni) for ni in n], [rand(ni) for ni in n]
α = sqrt(pi)
function axpy!(α, x, y)
        @simd for i in eachindex(x, y)
            @inbounds y[i] = muladd(α, x[i], y[i])
       return y
    end
end
benchmark = @benchmark axpy!(α, x, y);
display(benchmark)
@info "clear GC", GC.gc();


































# println(Crayon(foreground = :white),"
# # JULIA IMPLEMENTATION of axpy!")
# function axpy!(α, x, y)
#         @simd for i in eachindex(x, y)
#             @inbounds y[i] = muladd(α, x[i], y[i])
#        endSLURMSLURM
#        return y
#     end
# benchmark = @benchmark axpy!(α, x, y);
# display(benchmark)
# @info "clear GC", GC.gc();


# function custom_threaded_axpy!(α, x, y)
#         Threads.@threads for i = 1:length(c)
#                 c[i] = α*x[i]+y[i]
#         end
#         return nothing
# end

# # Julia axpy!
# a = 2.0
# b = Float64.(collect(1:100_000_000)) # create a big array of FloatsSLURMSLURM
# c = Float64.(collect(1:100_000_000)) # create a big array of Floats

# # custom axpy!, multithreaded / single threaded / @inbounds

# function custom_threaded_axpy!(a,b,c)
#         Threads.@threads for i = 1:length(c)
#                 c[i] = a*b[i]+c[i]
#         end
#         return nothing
# end

# # function custom_non_threaded_axpy!(a,b,c)
# #         for i = 1:length(c)
# #                 c[i] = a*b[i]+c[i]
# #         end
# #         return nothing
# # end

# function threaded_inbounds_axpy!(a,b,c)
#         Threads.@threads for i = 1:length(c)
#                 @inbounds c[i] = a*b[i]+c[i]
#         end
#         return nothing

# # giordano
# function axpy!(a, x, y)
#         @simd for i in eachindex(x, y)
#             @inbounds y[i] = muladd(a, x[i], y[i])
#        end
#        return y
#     end
# axpy!(a, x, y)

# n = [10^k for k in 1:6]
# x, y = [rand(ni) for ni in n], [rand(ni) for ni in n]
# α = sqrt(pi)

# function axpy!(α, x, y)
#         @simd for i in eachindex(x, y)
#             @inbounds y[i] = muladd(α, x[i], y[i])
#        end
#        return y
#     end


# @btime axpy!(α, x, y)

# α = sqrt(pi)
# for k in 1:6
#         n = 10^k

# end

#         x, y = [rand(ni) for ni in n], [rand(ni) for ni in n]
#         @benchmark LinearAlgebra.BLAS.axpy!(α, x, y)
# end;

# α = sqrt(pi)