# Introduction
This repository contains the source code for generating microlensing magnification maps on GPUs. We utilize Inverse Polygon Mapping (IPM, [Mediavilla et al. 2006][https://ui.adsabs.harvard.edu/abs/2006ApJ...653..942M/abstract], [Mediavilla et al. 2011][https://ui.adsabs.harvard.edu/abs/2011ApJ...741...42M/abstract]), combined with the Fast Multipole Method ([Greengard and Rokhlin 1987][https://ui.adsabs.harvard.edu/abs/1987JCoPh..73..325G/abstract]) as suggested and used by [Jiménez-Vicente and Mediavilla 2022][https://ui.adsabs.harvard.edu/abs/2022ApJ...941...80J/abstract] for CPUs. The bulk of the code is written using NVIDIA's CUDA. You will need a CUDA installation to compile and run the code.

In addition to a command line program, we also provide a wrapper for our code that allows it to be used with python once the relevant library is compiled.

Compilation has been tested with the GNU compiler version 12.2.0 and the CUDA HPC SDK version 23.9.