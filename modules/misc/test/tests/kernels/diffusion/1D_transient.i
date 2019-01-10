# This test solves a 1D transient heat equation
# The error is caclulated by comparing to the analytical solution
# The problem setup and analytical solution are taken from "Advanced Engineering
# Mathematics, 10th edition" by Erwin Kreyszig.
# http://www.amazon.com/Advanced-Engineering-Mathematics-Erwin-Kreyszig/dp/0470458364
# It is Example 1 in section 12.6 on page 561

[Mesh]
  type = GeneratedMesh
  dim = 1
  nx = 160
  xmax = 80
[]

[Variables]
  [./T]
  [../]
[]

[ICs]
  [./T_IC]
    type = FunctionIC
    variable = T
    function = '100*sin(pi*x/80)'
  [../]
[]

[Kernels]
  [./diff]
    type = CoefDiffusion
    variable = T
    coef = 0.9
    function = 0.05
  [../]
  [./dt]
    type = CoefTimeDerivative
    variable = T
    Coefficient = 0.82064
  [../]
[]

[BCs]
  [./left]
    type = DirichletBC
    variable = T
    boundary = left
    value = 0
  [../]
  [./right]
    type = DirichletBC
    variable = T
    boundary = right
    value = 0
  [../]
[]

[Preconditioning]
  [./full]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Transient
  dt = 1e-2
  end_time = 1
[]

[Postprocessors]
  [./error]
    type = NodalL2Error
    function = '100*sin(pi*x/80)*exp(-0.95/(0.092*8.92)*pi^2/80^2*t)'
    variable = T
    outputs = console
  [../]
[]

[Outputs]
  exodus = true
[]
