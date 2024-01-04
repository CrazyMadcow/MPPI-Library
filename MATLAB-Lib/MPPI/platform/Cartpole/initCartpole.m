% Simulation init
sim.nx                      =   5;
sim.nxa                     =   4;
sim.nu                      =   1;
sim.x0                      =   [0;0;0;0;0]; % [x, theta, xDot, thetaDot]'
sim.u0                      =   0;
sim.xf                      =   [0;pi;0;0;0];
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