### Preparations ###

# Fetch packages.
import bionetgen
import json
import numpy
import statistics
import sys
import timeit

# Read input.
modelname = sys.argv[1]
method = sys.argv[2]
minT = float(sys.argv[3])
maxT = float(sys.argv[4])
nT = int(sys.argv[5])
num_sims = int(sys.argv[6])
sparse = False
if len(sys.argv) == 8:
    sparse == 'sparse'


# Benchmarking parameters
n = num_sims
lengs = numpy.logspace(minT, maxT, num=nT)

# Benchmarking functions.
def make_benchmark(model,n):
    def benchmark_func():
        bionetgen.run(model, suppress=True)
    durations = timeit.Timer(benchmark_func).repeat(repeat=n, number=1)
    return durations

# Serialises a benchmarking output using JSON.
def serialize(benchmarks,lengs,filename):
    with open('../Benchmarking_results/%s.json'%(filename) , "w") as write:
        json.dump({"benchmarks": benchmarks, "medians": list(1000*numpy.array(list(map(statistics.median, benchmarks)))), "lengs": lengs.tolist()} , write)


### Benchamrks ###

# Load model.
if (modelname == 'BCR') & (method == '"ssa"'):
    model = bionetgen.bngmodel(f'../Data/BCRSSA.xml')
    model.add_action('simulate', {'method':'"ssa"', 't_end':10000.0, 'n_steps':1000000})
else:
    model = bionetgen.bngmodel(f'../Data/{modelname}_no_obs.bngl')
model.actions[0].args['method'] = method
model.actions[0].args['atol'] = 1e-12
model.actions[0].args['rtol'] = 1e-6
if sparse:
    model.actions[0].args['sparse'] = 1


# Benchmark ODE simulations.
benchmarks = [-1.0] * len(lengs)
for i in range(0,len(lengs)):
    model.actions[0].args['t_end'] = lengs[i]
    model.actions[0].args['n_steps'] = 10
    benchmarks[i] = make_benchmark(model,n)
if sparse:
    serialize(benchmarks,lengs,f'bionetgen_sparse_{method[1:4]}_{modelname}')
else:
    serialize(benchmarks,lengs,f'bionetgen_{method[1:4]}_{modelname}')




