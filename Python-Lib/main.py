#%%
from Model.model import Model
from Simulation.simulation import Sim
from MPPI.mppi import Mppi
import torch
import matplotlib.pyplot as plt
import time

if __name__ == '__main__':

    model       =   Model()


    sim         =   Sim(model)


    mppi        =   Mppi(sim, model)

    current    =   time.time()
    for i in range(len(sim.t)):

        sim.XHist[:, i] = sim.X.T
        sim.UHist[:, i] = sim.U.T


        mppi.RunMppi(sim.X, mppi.uHorizon, model, sim)
        sim.U = mppi.uHorizon[:, 0].reshape(sim.nu, 1)
        sim.X = sim.X + model.Dynamics(sim.X, sim.U) * sim.dt
        for j in range(mppi.N - 1):
            mppi.uHorizon[:, j] = mppi.uHorizon[:, j + 1]
        mppi.uHorizon[:, mppi.N - 1] = sim.U0


plt.plot(sim.t.cpu(), sim.XHist[1,:].cpu())
plt.plot(sim.t.cpu(), sim.XHist[0,:].cpu())
