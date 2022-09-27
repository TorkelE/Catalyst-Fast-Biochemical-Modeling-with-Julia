### Preparations ###

# Activate local environment.
import Pkg
Pkg.activate(".")

# Fetch packages.
using BenchmarkTools
using DifferentialEquations
using JSON
using JumpProcesses
using LSODA
using ModelingToolkit
using OrdinaryDiffEq
using ReactionNetworkImporters
using RecursiveFactorization
using Sundials

# Declares a serilization function.
function serialize_benchmarks(benchmarks,lengs,methodName)
    medians = map(bm -> median(bm.times)/1000000, benchmarks)
    open("../Benchmarking_results/catalyst_$(methodName)_$(modelName).json","w") do f
        JSON.print(f, Dict("benchmarks"=>benchmarks, "medians"=>medians, "lengs"=>lengs))
    end
end

# Reads input selection.
modelName,methodName,minT,maxT,nT = ARGS[1:5]

# Sets benchmarking lengths
lengs = 10 .^(range(parse(Float64,minT),stop=parse(Float64,maxT),length=parse(Int64,nT))); 

# Sets the method.
solver = Dict(["lsoda" => lsoda, "CVODE_BDF" => CVODE_BDF, "TRBDF2" => TRBDF2, "KenCarp4" => KenCarp4, "QNDF" => QNDF, "FBDF" => FBDF, "Rosenbrock23" => Rosenbrock23, "Tsit5" => Tsit5, "BS5" => BS5, "VCABM" => VCABM, "Vern6" => Vern6, "Vern7" => Vern7, "Vern8" => Vern8, "Vern9" => Vern9, "Direct" => Direct, "SortingDirect" => SortingDirect, "RSSA" => RSSA, "RSSACR" => RSSACR])[methodName]
methodType = Dict(["lsoda" => :ODE, "CVODE_BDF" => :ODE , "TRBDF2" => :ODE , "KenCarp4" => :ODE , "QNDF" => :ODE, "FBDF" => :ODE, "Rosenbrock23" => :ODE, "Tsit5" => :ODE, "BS5" => :ODE, "VCABM" => :ODE, "Vern6" => :ODE, "Vern7" => :ODE, "Vern8" => :ODE, "Vern9" => :ODE, "Direct" => :Jump , "SortingDirect" => :Jump , "RSSA" => :Jump , "RSSACR" => :Jump])[methodName]

# Load model.
if (modelName=="BCR") && (methodType == :Jump)
    model = loadrxnetwork(BNGNetwork(), "../Data/postequil_c3.net");
else
    model = loadrxnetwork(BNGNetwork(), "../Data/$(modelName)_no_obs.net");
end

### Benchmarking ###

# Benchmark model.
if methodType == :ODE
    # Read additional ODE options.
    linsolName = ARGS[6]
    jac = in("jac", ARGS)
    sparse = in("sparse", ARGS)
    autodiff = !in("autodifffalse", ARGS)
    linsolver = Dict(["NoLinSolver" => nothing, "KLU" => :KLU, "LapackDense" => :LapackDense, "GMRES" => :GMRES, "KLUFactorization" => KLUFactorization(), "KrylovJL_GMRES" => KrylovJL_GMRES()])[linsolName]

    # Declares beginning of benchmark.
    println("\n-----     Beginning benchmarks for $(modelName) using $(methodName) with jac=$(jac),  with sparse=$(sparse), and with linsolver=$(linsolName).     -----")

    # Run ODE benchmark.
    oprob = ODEProblem(convert(ODESystem,model.rn),Float64[],(0.0,0.0),Float64[],sparse=sparse,jac=jac)
    if isnothing(linsolver)
        solver = solver(autodiff=autodiff)
    elseif methodName=="CVODE_BDF"
        solver = solver(linear_solver=linsolver,autodiff=autodiff)
    else
        solver = solver(linsolve=linsolver,autodiff=autodiff)
    end
    abstol = (in(methodName,["QNDF", "FBDF"]) ? 1e-6 : 1e-12); 
    benchmarks = map(leng -> (op_interal = remake(oprob,tspan=(0.0,leng)); (@benchmark solve($op_interal,$solver,abstol=abstol,reltol=1e-6));), lengs);
    jac && (methodName=methodName*"_jac"); sparse && (methodName=methodName*"_sparse");  
    serialize_benchmarks(benchmarks,lengs,"$(methodName)_$(linsolName)")

elseif methodType == :Jump
    # Declares beginning of benchmark.
    println("\n-----     Beginning benchmarks for $(modelName) using $(methodName)     -----")

    # Run jump benchmark.
    if (modelName=="BCR") && (methodType == :Jump)
        dprob = DiscreteProblem(model.rn,JSON.parsefile("../Data/BCR_SSA_u0.json"),(0.0,0.0),model.p); 
    else
        dprob = DiscreteProblem(model.rn,model.u₀,(0.0,0.0),model.p); dprob = remake(dprob,u0=Int64.(dprob.u0));
    end
    jprob = JumpProblem(model.rn,dprob,solver(),save_positions=(false,false))
    benchmarks = map(leng -> (jp_internal = remake(jprob,tspan=(0.0,leng)); (@benchmark solve($jp_internal,$(SSAStepper())));), lengs);
    serialize_benchmarks(benchmarks,lengs,methodName)
end

# Proclaims benchmark over.
println("-----     Benchmark finished.     -----")