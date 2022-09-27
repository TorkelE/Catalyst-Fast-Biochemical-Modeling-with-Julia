### Preparations ###

# Fetch packages.
import sys, os, numpy, libsbml, gillespy2
import matplotlib.pyplot as plt
import json
import statistics
import timeit
import numpy
from gillespy2 import TauHybridSolver, NumPySSASolver, ODESolver, ODECSolver, TauLeapingSolver, SSACSolver

# Read input.
modelname = sys.argv[1]
method = sys.argv[2]
minT = float(sys.argv[3])
maxT = float(sys.argv[4])
nT = int(sys.argv[5])
num_sims = int(sys.argv[6])

# Benchmarking parameters
n = num_sims
lengs = numpy.logspace(minT, maxT, num=nT)

# Benchmarking functions.
def make_ODE_benchmark(model,n,leng):
    def benchmark_func():
        model.run(solver=ODESolver,t=leng,increment=1.0,integrator='lsoda',integrator_options={"atol":10e-12,"rtol":10e-6})
    durations = timeit.Timer(benchmark_func).repeat(repeat=n, number=1)
    return durations
def make_Gillespie_benchmark(model,n,leng):
    def benchmark_func():
        model.run(solver=SSACSolver,t=leng,increment=1.0)
    durations = timeit.Timer(benchmark_func).repeat(repeat=n, number=1)
    return durations

# Serialises a benchmarking output using JSON.
def serialize(benchmarks,lengs,filename):
    with open('../Benchmarking_results/%s.json'%(filename) , "w") as write:
        json.dump({"benchmarks": benchmarks, "medians": list(1000*numpy.array(list(map(statistics.median, benchmarks)))), "lengs": lengs.tolist()} , write)


### Benchamrks ###

# Load model.
model = gillespy2.core.import_SBML(f'../Data/{modelname}_no_obs.xml')[0]

# Benchmark ODE simulations.
benchmarks = [-1.0] * len(lengs)
for i in range(0,len(lengs)):
    if method == 'lsoda':
        benchmarks[i] = make_ODE_benchmark(model,n,lengs[i])
    elif method == 'ssa':
        benchmarks[i] = make_Gillespie_benchmark(model,n,lengs[i])
    else:
        print("Unknown method provided")
serialize(benchmarks,lengs,f'gillespy2_{method}_{modelname}')




