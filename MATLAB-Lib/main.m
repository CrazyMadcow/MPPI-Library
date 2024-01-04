clear all;
% clc;

addpath('MPPI/')
platform        =   'Cartpole';
initMPPI



tic
for i=1:sim.nT

    % Control Input Calculation
    mppi                =   MPPI(sim, model, mppi);
    sim.u               =   mppi.uHorizon(:,1);

    % Dynamics propagation
    sim.xDot            =   dynamics(sim.x, sim.u, model, sim);
    sim.x               =   sim.x + sim.xDot*sim.dt;
        
    % Control sequence ressemble
    for j=1:mppi.N-1
        mppi.uHorizon(:,j) = mppi.uHorizon(:,j+1);
    end
    mppi.uHorizon(:,end)  =   sim.u0;

    % Buffer save
    sim.uHist(:,i)      =   sim.u;
    sim.xHist(:,i+1)    =   sim.x;
    
      
end
toc

plotResult;