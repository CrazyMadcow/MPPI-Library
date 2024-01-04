function XDot   =   dynamics(X, u, model, sim)



fa                  =   model.fa(X);
fc                  =   model.fc(X);
Gc                  =   model.Gc(X);

% if isempty(param.controlMax)~=0
%     u               =   min(u, param.controlMax);
%     u               =   max(u, -param.controlMax);
% end

XDot(1:sim.nxa,:)                     =   fa;
XDot(sim.nxa+1:sim.nx,:)            =   fc + Gc * u;
                    
end