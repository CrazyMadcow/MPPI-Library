import torch

class Sim():
  def __init__(self, model):

    try:
      self.device   =   "cuda"
      self.nx       =   model.nx
      self.nu       =   model.nu
      self.t0       =   0
      self.tf       =   8
      self.dt       =   0.05
      # self.X0       =   torch.zeros((self.nx,1)).to(self.device)
      self.X0       =   torch.tensor([[0],[0],[0],[0],[0]], device = self.device)
      self.U0       =   torch.zeros((self.nu,1), device = self.device)

      print("Simulation Initialized! - " + model.platform)

    except:
      print("Wrong Platform!")
      pass


    self.t          =   torch.arange(self.t0,self.tf+self.dt,self.dt, device = self.device)
    self.nT         =   self.t.shape[0]

    self.X          =   self.X0
    self.U          =   self.U0
    self.XDot       =   torch.zeros((self.nx,1), device = self.device)

    self.XHist      =   torch.zeros((self.nx,self.nT), device = self.device)
    self.UHist      =   torch.zeros((self.nu,self.nT), device = self.device)
    self.costHist   =   torch.zeros((1,self.nT), device = self.device)


    self.XHist[:,0] =   self.X0.T


