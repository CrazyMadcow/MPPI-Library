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
    sim.nx                      =   0;
    sim.nu                      =   0;
    sim.x0                      =   [0;0;0;0;0];
    sim.u0                      =   0;
    sim.x                       =   sim.x0;
    sim.u                       =   sim.u0;
    sim.xDot                    =   zeros(sim.nx,1);
    
    % Model init
    model.param.value1          =   0;
    model.param.value2          =   0;
    model                       =   dyn[platform name](model);
    model                       =   cost[platform name](model);
    
    % MPPI init
    mppi.lambda                 =   0; % learning rate
    mppi.variance               =   0; % system variance
    mppi.nu                     =   0; % amplitude of variance for search
    mppi.K                      =   0; % number of samples
    mppi.N                      =   0; % number of finite horizon
    ```
* dyn[plaform name]

    It define dynamics equation of the system. A dynamics should be defined with $\dot{X} =  [fa;fc] + [0;Gc]*u$, its necessary skeleton code is shown as follows
    ```MATLAB
    function model   =   dyn[platform name](model)
    
    model.fa                    =   @(x) [-x(1,:)*x(2,:); 
                                          -x(2,:)]^2; % input-independent dynamics
    
    model.fc                    =   @(x) [-(1/tau)*x(3,:)]; % input-dependent dynamics
    
    model.Gc                    =   @(x) [1/tau]; % control effectiveness matrix
                        
    end
    ```

* cost[plaform name]

    It define running cost of the mppi algorithm. Its necessary skeleton code is shown as follows
    ```MATLAB
    function model   =   costCartPole(model)
    
    model.L         =   @(x, model)   k1*x(1,:)^2 + k2*x(2,:)^3;
                        
    end
    ```
  
