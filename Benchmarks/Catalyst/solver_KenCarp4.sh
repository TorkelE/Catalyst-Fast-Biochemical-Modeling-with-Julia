#!/bin/bash

echo "Starts benchmark runs on the multistate model."
time julia catalyst_make_benchmark.jl multistate KenCarp4 1 5 9 NoLinSolver
time julia catalyst_make_benchmark.jl multistate KenCarp4 1 5 9 KrylovJL_GMRES

echo "Starts benchmark runs on the multisite2 model."
time julia catalyst_make_benchmark.jl multisite2 KenCarp4 1 5 9 NoLinSolver
time julia catalyst_make_benchmark.jl multisite2 KenCarp4 1 5 9 KrylovJL_GMRES

echo "Starts benchmark runs on the egfr_net model."

time julia catalyst_make_benchmark.jl egfr_net KenCarp4 1 3 7 NoLinSolver
time julia catalyst_make_benchmark.jl egfr_net KenCarp4 1 3 7 KrylovJL_GMRES

echo "Starts benchmark runs on the BCR model."
time julia catalyst_make_benchmark.jl BCR KenCarp4 1 3 7 NoLinSolver autodifffalse
time julia catalyst_make_benchmark.jl BCR KenCarp4 1 3 7 KrylovJL_GMRES autodifffalse

echo "Starts benchmark runs on the fceri_gamma2 model."
time julia catalyst_make_benchmark.jl fceri_gamma2 KenCarp4 1 3 7 NoLinSolver autodifffalse
time julia catalyst_make_benchmark.jl fceri_gamma2 KenCarp4 1 3 7 KrylovJL_GMRES autodifffalse