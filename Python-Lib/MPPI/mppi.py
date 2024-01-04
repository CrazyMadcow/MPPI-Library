import torch
from MPPI import initParameter
import numpy as np
import time

class Mppi():
    def __init__(self, sim, model):
        try:
            initParameter.InitParameterCartpole(self, sim)
            eval('initParameter.InitParameter' + model.platform + '(self, sim)')

            self.invVar = self.variance.inverse()

            self.uHorizon = sim.U0 * torch.ones((sim.nu, self.N), device=sim.device)
            self.xDelta = torch.zeros((sim.nx, self.K, self.N), device=sim.device)
            self.uDelta = torch.zeros((sim.nu, self.K, self.N), device=sim.device)

            self.S = torch.zeros(1, self.K, device=sim.device)
            self.xDeltaDot = torch.zeros((sim.nx, self.K, self.N), device=sim.device)

            print("MPPI Initialized! - " + model.platform)

        except:
            print("Wrong Platform!")
            pass

    def AdditionalRunningCost(self, u, uDelta):
        # SAdd    =   torch.zeros(1,u.shape[-1], device = sim.device).to(u.device)

        SAdd = 0.5 * self.lamb * (u * self.invVar * u + 2 * u * self.invVar * uDelta + (
                    1 - 1 / self.nu) * uDelta * self.invVar * uDelta)

        return SAdd

    def RunMppi(self, X, uHorizon, model, sim):

        self.S = 0 * self.S

        current = time.time()
        # seed the control input
        self.uDelta = torch.sqrt(self.variance * self.nu) * torch.randn(self.uDelta.shape, device=sim.device)
        # print(time.time() - current)

        current = time.time()
        # propagation
        self.xDelta[:, :, 0] = X
        for i in range(self.N - 1):
            self.xDeltaDot[:, :, i] = model.Dynamics(self.xDelta[:, :, i], uHorizon[:, i] + self.uDelta[:, :, i])
            self.xDelta[:, :, i + 1] = self.xDelta[:, :, i] + self.xDeltaDot[:, :, i] * sim.dt
        # print(time.time() - current)


        current = time.time()
        # cost calculation
        for i in range(self.N - 1):
            self.S = self.S + model.L(model, self.xDelta[:, :, i]) * sim.dt
            self.S = self.S + self.AdditionalRunningCost(self.uHorizon[:, i], self.uDelta[:, :, i]) * sim.dt
        rho = self.S.min()
        # print(rho)
        # print(time.time() - current)


        current = time.time()
        # update control Input
        for i in range(self.N):
            numSum = 0;
            denSum = 0;
            numSum = (torch.exp(-(1 / self.lamb) * (self.S - rho)) * self.uDelta[:, :, i]).sum()
            denSum = (torch.exp(-(1 / self.lamb) * (self.S - rho))).sum()
            self.uHorizon[:, i] = self.uHorizon[:, i] + (numSum / denSum)
        # print(time.time() - current)