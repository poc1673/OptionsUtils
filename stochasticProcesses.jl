# Peter Caya
# 2022-08-23
# Stochastic processes binomial_implementation

#################################################################################################### 
# Function Name: BrownianMotion
# Description: Generate a vector of Brownian motion.
# Inputs 
# [1] x0 - Starting point for the variable.
# [2] steps - The number of time steps to take.
# [3] drift - The drift term.
# [4] variance - The variance term for the equation
# Outputs: 
# [1] BrownianVector - A vector of results for Brownian motion.
# ####################################################################################################

using Random, Distributions, Plots
function BrownianMotion(x0,steps,drift = 0.0, variance = 1.0)
    BrownianVector = [x0]
    StNormal = Normal( drift,variance ) 
    for i in 2:steps
        append!(BrownianVector,BrownianVector[i-1]+rand(StNormal,1)[1])
    end
    return BrownianVector
end

#################################################################################################### 
# Function Name: simulateEpsilon
# Description: Calculate the ε term that is used in Brownian motion. This is the inverse normal Distributions
# of a randomly chosen variable from the uniform distribution.
# Inputs: None 
# Outputs: 
# [1] ε - A numeric value for epsilon
# ####################################################################################################
function simulateEpsilon()
    return quantile(Normal(), rand(Uniform(),1) )[1]
end

#################################################################################################### 
# Function Name: geometricBrownian
# Description: This function will take an expected return and volatility from the user and then
# generate a stochastic process for a specified period of time/time-steps.
# This follows the expression ΔS = µSΔt+σε(Δt)^.5
# Inputs 
# [1] µ - the expected rate of return
# [2] σ - a numeric type which is the volatility
# [3] t - the time period for the process to run in years
# [4] steps - the number of time steps
# Outputs: 
# [1] stockResults - a vector containing steps iterations of geometric Brownian motion
# ####################################################################################################
function geometricBrownian(µ,σ,t,steps,S0 = 100.0)
    Δt = t/steps
    stockResults = [S0]
    for i in 1:steps
        ε = simulateEpsilon()
        ΔS = µ*stockResults[i]*Δt+σ*(Δt)^.5*stockResults[i]*ε
        push!(stockResults,  ΔS+stockResults[i] )
    end
    return stockResults
end 