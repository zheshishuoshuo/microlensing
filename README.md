# Introduction
This repository contains source code for 

1. generating microlensing magnification maps,
2. locating microlensing critical curves and caustics, and
3. determining the number of microlensing caustic crossings,

all on GPUs.

## Methods
We utilize Inverse Polygon Mapping (IPM, Mediavilla et al. [2006](https://ui.adsabs.harvard.edu/abs/2006ApJ...653..942M/abstract), [2011](https://ui.adsabs.harvard.edu/abs/2011ApJ...741...42M/abstract)), combined with the Fast Multipole Method (FMM, Greengard and Rokhlin [1987](https://ui.adsabs.harvard.edu/abs/1987JCoPh..73..325G/abstract)) as suggested and used by Jiménez-Vicente and Mediavilla ([2022](https://ui.adsabs.harvard.edu/abs/2022ApJ...941...80J/abstract)) for CPUs, in order to generate magnification maps. Areas of the IPM cells are calculated using the Sutherland-Hodgman ([1974](https://doi.org/10.1145/360767.360802)) algorithm.

We utilize Witt's ([1990](https://ui.adsabs.harvard.edu/abs/1990A&A...236..311W)) method to locate the microlensing critical curves and caustics, while taking advantage of the FMM again to decrease computation time for terms involving derivatives of the microlensing potential. In order to locate the roots of the parametric critical curve equation, we employ the [Aberth](https://doi.org/10.2307/2005621)-[Ehrlich](https://doi.org/10.1145/363067.363115) method, a cubically convergent algorithm that allows for simultaneous approximations of the roots of a polynomial. 

We use the fact that the caustics are clockwise oriented closed curves (under our chosen critical curve parametrization) to utilize the winding number in order to calculate the two dimensional map of the the number of caustic crossings (Wambsganss et al. [1992](https://ui.adsabs.harvard.edu/abs/1992A&A...258..591), Granot et al. [2003](https://ui.adsabs.harvard.edu/abs/2003ApJ...583..575G)). 


## Dependencies
The code is written to be independent of anything besides the C++ standard libraries and the Thrust libraries that come with CUDA. We implement IPM, the FMM, the Sutherland-Hodgman algorithm, and the Aberth-Ehrlich method ourselves.

The bulk of the code is written using NVIDIA's CUDA, and you will need a CUDA installation to compile and run it. We additionally require a C++20 compliant compiler.

## Repository layout
The `include` repository contains the bulk of the code, which is written mostly as templated objects and functions. The `src` directory contains files for creating executables and libraries (see the [python](## python) section below). The `bin` directory contains compilation output (see the section on [compiling](## Compiling)). The `microlensing` directory contains python code for ease of use (see once more the [python](## python) section below), while the root directory contains a couple example python notebooks outlining usage.

## Compiling
Compilation has been tested with the GNU compiler version 12.2.0 and the CUDA HPC SDK version 23.9.

First, clone the repository.
```
git clone https://github.com/weisluke/microlensing.git
```

Then, simply run 
```
source compile
```
to run the compilation file. This should create 5 executables and 4 libraries in the `bin` directory. 

## python

In addition to command line programs, we also provide wrappers for our code that allow them to be used with python once the relevant libraries are [compiled](## Compiling). This eases the need to save output from the executables to disk and then read them from disk; we directly copy from managed memory to a numpy array once magnification maps and other objects are created.

