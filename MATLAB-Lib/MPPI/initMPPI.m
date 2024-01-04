% Add path
addpath('MPPI/platform/')
addpath(strcat('MPPI/platform/',platform))

% Init model
try
    eval(strcat('init',platform));
catch
    disp('Wrong platform!');
end


% Init simulation
sim.dt                      =   0.02; % dt of simulation
sim.tf                      =   3;
sim.t                       =   0:sim.dt:sim.tf;
sim.nT                      =   sim.tf/sim.dt;
sim.xHist                   =   zeros(sim.nx,sim.nT+1);
sim.uHist                   =   zeros(sim.nu,sim.nT);
sim.costHist                =   zeros(1,sim.nT);
sim.xHist(:,1)              =   sim.x0;



% Init MPPI
mppi.S              =   gpuArray(zeros(1,mppi.K));
mppi.uDeltaHorizon  =   gpuArray(zeros(sim.nu, mppi.K, mppi.N));
mppi.uDelta         =   gpuArray(zeros(sim.nu, mppi.K, mppi.N));
mppi.xHorizon       =   gpuArray(zeros(sim.nx, mppi.K, mppi.N));
mppi.uHorizon       =   gpuArray(zeros(sim.nu, mppi.N));
mppi.variance       =   gpuArray(mppi.variance);
mppi.nu             =   gpuArray(mppi.nu);
mppi.lambda         =   gpuArray(mppi.variance);

