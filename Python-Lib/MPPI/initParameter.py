import torch




def InitParameterCartpole(mppi, sim):
    mppi.lamb = 0.1
    mppi.variance = torch.tensor([[0.01]], device=sim.device)
    mppi.nu = 100
    mppi.R = torch.diag(torch.tensor([1, 1, 1], device=sim.device))
    mppi.K = 1000
    mppi.N = 100