# How to use MPPI MATLAB library

MATLAB library is divided by MPPI core and platform folder.

You do not need to modify MPPI core folder, but platform folder is need to be defined.

## MPPI core

MPPI core is composed with 4 code base

* [initMPPI.m](https://github.com/CrazyMadcow/MPPI-Library/blob/main/MATLAB-Lib/MPPI/initMPPI.m)

  Initialize simulation variables, parameters of MPPI, and variables of MPPI

* [dynamics.m](https://github.com/CrazyMadcow/MPPI-Library/blob/main/MATLAB-Lib/MPPI/dynamics.m)

  Dynamics which used in MPPI algorithm. 

* [MPPI.m](https://github.com/CrazyMadcow/MPPI-Library/blob/main/MATLAB-Lib/MPPI/MPPI.m)

  Main algorithm of MPPI. It roll outs random control inputs, propagates roll out particles, calculate cost value of each particle, and obtain new control inputs

* [plotResult.m](https://github.com/CrazyMadcow/MPPI-Library/blob/main/MATLAB-Lib/MPPI/plotResult.m)

  Plot of results based on each platform plot files

## platform

platform should be defined before you use MPPI library and followings are needed for using MPPI with platform

  - platform name: it should be defined in main code in string type
  - platform code: platform is composed with 4 base codes (init[plaform name] / dyn[plaform name] / cost[plaform name] / plot[plaform name])

* init[plaform name]

    It initialize parameters for simulation, platform model, and MPPI. Its necessary skeleton code is shown as follows
    ```MATLAB
    % Simulation init
    sim.nx                      =   5;
    sim.nxa                     =   4;
    sim.nu                      =   1;
    sim.x0                      =   [0;0;0;0;0]; % [x, theta, xDot, thetaDot]'
    sim.u0                      =   0;
    sim.x                       =   sim.x0;
    sim.u                       =   sim.u0;
    sim.xDot                    =   zeros(sim.nx,1);
    
    % Model init
    model.param.mc              =   1; % cart mass
    model.param.mp              =   0.01; % ball mass
    model.param.l               =   1; % road length
    model.param.g               =   9.81; % gravity
    model.param.tau             =   0.05;
    model                       =   dynCartPole(model);
    model                       =   costCartPole(model);
    
    % MPPI init
    mppi.lambda                 =   0.1;
    mppi.variance               =   0.1^2;
    mppi.nu                     =   50;
    mppi.R                      =   1;
    mppi.K                      =   1000; % number of samples
    mppi.N                      =   100; % number of finite horizon
    ```
