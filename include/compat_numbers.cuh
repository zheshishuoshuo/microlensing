#pragma once
#if defined(__CUDACC__)
  #include <cuda/std/numbers>
  namespace nst = cuda::std::numbers;
#else
  #include <numbers>
  namespace nst = std::numbers;
#endif
// Fallback to avoid device-side variable-template issues
template <typename T>
__host__ __device__ constexpr T nst_pi_v() { return (T)3.14159265358979323846; }
template <typename T>
__host__ __device__ constexpr T nst_inv_pi_v() { return (T)0.31830988618379067154; } // 1/pi
#if defined(__CUDACC__) || !defined(__cpp_lib_math_constants)
  #define NSTD_PI_V(T)      nst_pi_v<T>()
  #define NSTD_INV_PI_V(T)  nst_inv_pi_v<T>()
#else
  #define NSTD_PI_V(T)      nst::pi_v<T>
  #define NSTD_INV_PI_V(T)  nst::inv_pi_v<T>
#endif
