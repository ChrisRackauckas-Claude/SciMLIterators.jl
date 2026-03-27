# SciMLIterators.jl

[![Build Status](https://github.com/SciML/SciMLIterators.jl/workflows/CI/badge.svg)](https://github.com/SciML/SciMLIterators.jl/actions?query=workflow%3ACI)
[![codecov](https://codecov.io/gh/SciML/SciMLIterators.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/SciML/SciMLIterators.jl)

Iterator utilities for [SciML](https://sciml.ai/) solution and integrator objects. Provides convenience iterators for stepping through ODE/SDE/DDE solutions and integrators.

## Installation

```julia
using Pkg
Pkg.add("SciMLIterators")
```

## Usage

```julia
using OrdinaryDiffEq, SciMLIterators

# Define and solve an ODE
prob = ODEProblem((u, p, t) -> -u, 1.0, (0.0, 1.0))
sol = solve(prob, Tsit5())

# Iterate over (u, t) tuples from a solution
for (u, t) in tuples(sol)
    println("t = $t, u = $u")
end

# Iterate over (u, t) tuples from an integrator (stepping on-demand)
integrator = init(prob, Tsit5())
for (u, t) in tuples(integrator)
    println("t = $t, u = $u")
end

# Iterate over intervals (uprev, tprev, u, t)
integrator = init(prob, Tsit5())
for (uprev, tprev, u, t) in intervals(integrator)
    println("Step from t=$tprev to t=$t")
end

# Evaluate at specific time points
integrator = init(prob, Tsit5())
for (u, t) in TimeChoiceIterator(integrator, 0.0:0.1:1.0)
    println("t = $t, u = $u")
end
```

## API

- `tuples(sol)` - Array of `(u, t)` tuples from a solution
- `tuples(integrator)` - Iterator yielding `(u, t)` at each integrator step
- `intervals(integrator)` - Iterator yielding `(uprev, tprev, u, t)` at each step
- `TimeChoiceIterator(integrator, ts)` - Iterator evaluating the integrator at specified times `ts`
