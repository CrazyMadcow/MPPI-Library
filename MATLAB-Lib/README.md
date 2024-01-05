# How to use MPPI MATLAB library

MATLAB library is divided by MPPI core and platform folder.

You do not need to modify MPPI core folder, but platform folder is need to be defined.

## MPPI core

MPPI core is composed with 4 code base

* [initMPPI.m](https://github.com/CrazyMadcow/MPPI-Library/blob/main/MATLAB-Lib/MPPI/initMPPI.m): Initialize simulation variables, parameters of MPPI, and variables of MPPI

* [dynamics.m](https://github.com/CrazyMadcow/MPPI-Library/blob/main/MATLAB-Lib/MPPI/dynamics.m): Dynamics which used in MPPI algorithm. 

* [MPPI.m](https://github.com/CrazyMadcow/MPPI-Library/blob/main/MATLAB-Lib/MPPI/MPPI.m): Main algorithm of MPPI. It roll outs random control inputs, propagates roll out particles, calculate cost value of each particle, and obtain new control inputs

* [plotResult.m](https://github.com/CrazyMadcow/MPPI-Library/blob/main/MATLAB-Lib/MPPI/plotResult.m): plot of results based on each platform plot files

## platform

platform should be defined before you use MPPI library

platform name should be defined in main folder
