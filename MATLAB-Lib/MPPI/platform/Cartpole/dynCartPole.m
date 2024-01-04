function model   =   dynCartPole(model)


% X = [x, theta, xdot, thetaDot];

mc      =   model.param.mc;
mp      =   model.param.mp;
l       =   model.param.l;
g       =   model.param.g;
tau     =   model.param.tau;

% X = [x, theta, xDot, thetaDot]
% U = u;

model.fa                    =   @(x) [x(3,:); 
                                      x(4,:);
                                      (1./(mc+mp*sin(x(2,:)).^2)).*(x(5,:) + (mp*sin(x(2,:)).*(l*x(4,:).^2 + g*cos(x(2,:)))));
                                      (1./(l*(mc+mp*sin(x(2,:)).^2))).*(-x(5,:).*cos(x(2,:)) - mp*l*(x(4,:).^2).*cos(x(2,:)).*sin(x(2,:)) - (mc+mp)*g*sin(x(2,:)))];

model.fc                    =   @(x) [-(1/tau)*x(5,:)];

model.Gc                    =   @(x) [1/tau];
                    
end