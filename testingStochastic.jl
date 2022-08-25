include("stochasticProcesses.jl")
print("A")
endVal = 52
plot(1:(endVal+1),geometricBrownian( .15, .3,1.0, endVal))

#using DifferentialEquations, Plots, Bridge
#μ = 1.0
#σ = .8
#GB = GeometricBrownianMotionProcess(μ, σ, 0.0, 1.0)
#BB.dt = 1.0