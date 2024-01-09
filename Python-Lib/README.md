# How to use MPPI Python library

Python library is divided by MPPI core and Model folder.Library is coded as class.

Users should define initParameter.py in MPPI folder and platform.py in Model folder.

## MPPI core

MPPI class is defined with 2 functions, and Initparameter[platform name] functions should be defined in initPrameter.py for runMPPI

* [mppi.py](https://github.com/CrazyMadcow/MPPI-Library/blob/main/Python-Lib/MPPI/mppi.py)

  Initialize MPPI class. It initialize mppi parameters from initParameter.py, and RunMppi is the core algorithm

* [initPramter.py](https://github.com/CrazyMadcow/MPPI-Library/blob/main/Python-Lib/MPPI/initParameter.py)

  It initialize the mppi parameter for the platform. Its neccesary code in initParameter.py is shown as follow
  ```python
  import torch

  def InitParameterCartpole(mppi, sim):
      mppi.lamb = 0.1
      mppi.variance = torch.tensor([[0.01]], device=sim.device)
      mppi.nu = 50
      mppi.R = torch.diag(torch.tensor([1, 1, 1], device=sim.device))
      mppi.K = 2000
      mppi.N = 30
  ```

## Model

platform should be defined before you use MPPI library and followings are needed for using MPPI with platform

  - model.py: it initialize the model that will be used in MPPI algorithm. Users do not need to modify the code. Users need to define platform variable in string type for other platform
  - [platform name].py: Functions of the code should be defined for the model class. Necessary functions are Init[platform name] / StateDynamics[platform name] / ControlDynamics[platform name] / RunningCost[platform name]

* [platform name].py

    Necessary functions should be defined for each model, and its skeleton code is shown as below
    ```python
    def Init[platform name](model):
        model.param  =   0
        model.f      =   StateDynamics[platform name]
        model.G      =   ControlDynamics[platform name]
        model.Gc     =   ControlOnlyDynamics[platform name]
        model.L      =   RunningCost[platform name]
        model.platform  =   "[platform name]"
    
    
    def StateDynamics[platform name](model, X):
        f         =   torch.zeros((X.shape[0],X.shape[1]), device = X.device)
    
        mc        =   model.mc
        mp        =   model.mp
        l         =   model.l
        g         =   model.g
        tau       =   model.tau
    
        x         =   X[0,:]
        theta     =   X[1,:]
        xDot      =   X[2,:]
        thetaDot  =   X[3,:]
        F         =   X[4,:]
    
        f[0,:]    =   -X[0,:]*X[1,:]
        f[1,:]    =   -X[1,:]**2
        f[4,:]    =   -1/tau*X[2,:]
    
        return f
    
    
    def ControlDynamics[platform name](model, X):
        G         =   torch.zeros((model.nx,model.nu), device = X.device)
    
        for i in range(model.nu):
          G[model.nx-model.nu+i,i] = 1/tau
    
        return G
    
    
    def RunningCost[platform name](model,X):
    
        # L         =   torch.zeros(1,X.shape[-1]).to(X.device)

        k1        =   10
        k2        =   10
        k3        =   10
    
        L         =   k1*X[0,:]**2 + k2*X[1,:]**2 + k3*X[2,:]**2
    
        return L
    ```
  
