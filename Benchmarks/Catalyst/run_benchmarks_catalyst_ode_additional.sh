#!/bin/bash

echo "Starts benchmark runs on the multistate model."
time julia catalyst_make_benchmark.jl multistate TRBDF2 1 5 9 NoLinSolver
time julia catalyst_make_benchmark.jl multistate TRBDF2 1 5 9 KrylovJL_GMRES
time julia catalyst_make_benchmark.jl multistate KenCarp4 1 5 9 NoLinSolver
time julia catalyst_make_benchmark.jl multistate KenCarp4 1 5 9 KrylovJL_GMRES
time julia catalyst_make_benchmark.jl multistate QNDF 1 5 9 NoLinSolver
time julia catalyst_make_benchmark.jl multistate QNDF 1 5 9 KrylovJL_GMRES
time julia catalyst_make_benchmark.jl multistate FBDF 1 5 9 NoLinSolver
time julia catalyst_make_benchmark.jl multistate FBDF 1 5 9 KrylovJL_GMRES
time julia catalyst_make_benchmark.jl multistate Rosenbrock23 1 5 9 NoLinSolver
time julia catalyst_make_benchmark.jl multistate Rosenbrock23 1 5 9 KrylovJL_GMRES

echo "Starts benchmark runs on the multisite2 model."
time julia catalyst_make_benchmark.jl multisite2 TRBDF2 1 5 9 NoLinSolver
time julia catalyst_make_benchmark.jl multisite2 TRBDF2 1 5 9 KrylovJL_GMRES
time julia catalyst_make_benchmark.jl multisite2 KenCarp4 1 5 9 NoLinSolver
time julia catalyst_make_benchmark.jl multisite2 KenCarp4 1 5 9 KrylovJL_GMRES
time julia catalyst_make_benchmark.jl multisite2 QNDF 1 5 9 NoLinSolver
time julia catalyst_make_benchmark.jl multisite2 QNDF 1 5 9 KrylovJL_GMRES
time julia catalyst_make_benchmark.jl multisite2 FBDF 1 5 9 NoLinSolver
time julia catalyst_make_benchmark.jl multisite2 FBDF 1 5 9 KrylovJL_GMRES
time julia catalyst_make_benchmark.jl multisite2 Rosenbrock23 1 5 9 NoLinSolver
time julia catalyst_make_benchmark.jl multisite2 Rosenbrock23 1 5 9 KrylovJL_GMRES

echo "Starts benchmark runs on the egfr_net model."
time julia catalyst_make_benchmark.jl egfr_net TRBDF2 1 3 7 NoLinSolver
time julia catalyst_make_benchmark.jl egfr_net TRBDF2 1 3 7 KrylovJL_GMRES
time julia catalyst_make_benchmark.jl egfr_net KenCarp4 1 3 7 NoLinSolver
time julia catalyst_make_benchmark.jl egfr_net KenCarp4 1 3 7 KrylovJL_GMRES
time julia catalyst_make_benchmark.jl egfr_net QNDF 1 3 7 NoLinSolver
time julia catalyst_make_benchmark.jl egfr_net QNDF 1 3 7 KrylovJL_GMRES
time julia catalyst_make_benchmark.jl egfr_net FBDF 1 3 7 NoLinSolver
time julia catalyst_make_benchmark.jl egfr_net FBDF 1 3 7 KrylovJL_GMRES
time julia catalyst_make_benchmark.jl egfr_net Rosenbrock23 1 3 7 NoLinSolver
time julia catalyst_make_benchmark.jl egfr_net Rosenbrock23 1 3 7 KrylovJL_GMRES

echo "Starts benchmark runs on the BCR model."
time julia catalyst_make_benchmark.jl BCR TRBDF2 1 3 7 NoLinSolver autodifffalse
time julia catalyst_make_benchmark.jl BCR TRBDF2 1 3 7 KrylovJL_GMRES autodifffalse
time julia catalyst_make_benchmark.jl BCR KenCarp4 1 3 7 NoLinSolver autodifffalse
time julia catalyst_make_benchmark.jl BCR KenCarp4 1 3 7 KrylovJL_GMRES autodifffalse
time julia catalyst_make_benchmark.jl BCR QNDF 1 3 7 NoLinSolver autodifffalse
time julia catalyst_make_benchmark.jl BCR QNDF 1 3 7 KrylovJL_GMRES autodifffalse
time julia catalyst_make_benchmark.jl BCR FBDF 1 3 7 NoLinSolver autodifffalse
time julia catalyst_make_benchmark.jl BCR FBDF 1 3 7 KrylovJL_GMRES autodifffalse
time julia catalyst_make_benchmark.jl BCR Rosenbrock23 1 3 7 NoLinSolver autodifffalse
time julia catalyst_make_benchmark.jl BCR Rosenbrock23 1 3 7 KrylovJL_GMRES autodifffalse

echo "Starts benchmark runs on the fceri_gamma2 model."
time julia catalyst_make_benchmark.jl fceri_gamma2 TRBDF2 1 3 7 NoLinSolver autodifffalse
time julia catalyst_make_benchmark.jl fceri_gamma2 TRBDF2 1 3 7 KrylovJL_GMRES autodifffalse
time julia catalyst_make_benchmark.jl fceri_gamma2 KenCarp4 1 3 7 NoLinSolver autodifffalse
time julia catalyst_make_benchmark.jl fceri_gamma2 KenCarp4 1 3 7 KrylovJL_GMRES autodifffalse
time julia catalyst_make_benchmark.jl fceri_gamma2 QNDF 1 3 7 NoLinSolver autodifffalse
time julia catalyst_make_benchmark.jl fceri_gamma2 QNDF 1 3 7 KrylovJL_GMRES autodifffalse
time julia catalyst_make_benchmark.jl fceri_gamma2 FBDF 1 3 7 NoLinSolver autodifffalse
time julia catalyst_make_benchmark.jl fceri_gamma2 FBDF 1 3 7 KrylovJL_GMRES autodifffalse
time julia catalyst_make_benchmark.jl fceri_gamma2 Rosenbrock23 1 3 7 NoLinSolver autodifffalse
time julia catalyst_make_benchmark.jl fceri_gamma2 Rosenbrock23 1 3 7 KrylovJL_GMRES autodifffalse   