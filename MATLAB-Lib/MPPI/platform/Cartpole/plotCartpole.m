figure
plot(sim.t,sim.xHist(1,:))
hold on
plot(sim.t,sim.xHist(2,:))
xlabel('time(sec)');
legend('x','\theta')

figure
plot(sim.t(1:end-1), sim.uHist(1,:));
title('Control Input');
ylabel('Control Input');
xlabel('time(sec)')