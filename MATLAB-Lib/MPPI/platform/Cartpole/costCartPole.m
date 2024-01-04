function model   =   costCartPole(model)

k1              =   100;
k2              =   500;
k3              =   1;
k4              =   1;


model.L         =   @(x, model)   (k1*(x(1,:)).^2 + k2*(1+cos(x(2,:))).^2 + k3*x(3,:).^2 + k4*x(4,:).^2);