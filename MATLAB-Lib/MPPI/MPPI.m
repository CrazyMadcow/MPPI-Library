function mppi    =   MPPI(sim, model, mppi)
    
   
    % Cost initialize
    mppi.S                  =   0*mppi.S;
    
    % Seed the random noise walk
    mppi.uDeltaHorizon      =   sqrt( mppi.variance * mppi.nu ) * randn(size(mppi.uDeltaHorizon),"gpuArray");
    mppi.uDelta             =   repmat(gpuArray(reshape(mppi.uHorizon,[sim.nu,1,mppi.N])),[1,mppi.K,1]) + mppi.uDeltaHorizon;
    mppi.xHorizon(:,:,1)    =   ones(sim.nx,mppi.K,1).*sim.x;

    % Propagation dynamics
    for j=1:mppi.N-1
        mppi.xDotHorizon        =   dynamics(mppi.xHorizon(:,:,j), mppi.uDelta(:,:,j), model, sim);
        mppi.xHorizon(:,:,j+1)  =   mppi.xHorizon(:,:,j) + mppi.xDotHorizon*sim.dt;
    end
    
    % Cost calculation
    for j=1:mppi.N-1
        mppi.S(1,:)             =   mppi.S(1,:) + model.L(mppi.xHorizon(:,:,j+1))*sim.dt;
        mppi.S(1,:)             =   mppi.S(1,:) + (1/2) * mppi.lambda * ( mppi.uDelta(:,:,j).*inv(mppi.variance).*mppi.uDelta(:,:,j) + -(1/mppi.nu)*(mppi.uDeltaHorizon(:,:,j).*inv(mppi.variance).*mppi.uDeltaHorizon(:,:,j)) )*sim.dt;
    end

    % Policy update
    rho                     =   min(mppi.S);
    numSum          =   sum(exp(-(1/mppi.lambda)*(mppi.S(1,:)-rho)).*mppi.uDeltaHorizon(:,:,:));
    denSum          =   sum(exp(-(1/mppi.lambda)*(mppi.S(1,:)-rho)));
    mppi.uHorizon    =   mppi.uHorizon + reshape((numSum./denSum),[sim.nu,mppi.N]);


end