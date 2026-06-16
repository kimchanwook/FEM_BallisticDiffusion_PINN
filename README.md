# FEM_BallisticDiffusion_PINN

MATLAB project for finite-element modeling of ballistic-diffusive heat transport and quasiparticle diffusion/trapping in a planar superconducting transmon-like geometry, with a physics-informed neural-network surrogate layer for later acceleration.  `This work was conducted with the assistance of a large language model (LLM)`

## Project logic

1. Validate Gang Chen-style ballistic-diffusive heat conduction on a 1D thin-film problem, with Module 1 now including a detailed FEM derivation from strong form to weak form, element matrices, assembly, boundary conditions, time stepping, and field reconstruction.
2. Introduce cryogenic superconducting material physics through an expanded textbook-style Module 2 note: normal-metal preliminaries, phonons, electron-phonon coupling, Cooper instability, BCS gap derivation, quasiparticles, diffusion, recombination, traps, photon absorption, pair breaking, electron-phonon relaxation, Rothwarf-Taylor-type nonequilibrium dynamics, and a detailed FEM implementation chain from strong form to weak form, shape functions, element matrices/vectors, assembly, boundary conditions, nonlinear solves, and field reconstruction.
3. Hard-code a 3D planar transmon geometry in MATLAB using cuboid regions and a tensor-product hexahedral FEM mesh.
4. Use FEM simulations to generate data for a physics-informed surrogate/PINN.

## Main entry points

```matlab
matlab/setup_project_paths
matlab/main_module1_bd_1d_validation
matlab/main_module3_transmon_3d_fem
matlab/cases/case_trap_distance_sweep
matlab/main_module4_train_pinn_surrogate
```

## Documentation

The main roadmap is `project_plan.pdf`. Module physics notes live in `docs/physics_notes/`.

## Notes on the Josephson junction representation

The Josephson tunnel barrier is not directly meshed at nanometer thickness in this first build. It is represented as an effective junction-sensitive volume and source/metric region. This avoids an extreme multiscale mesh while preserving the design question: how do traps, pads, substrate, and heat sinks affect quasiparticle density near the junction?
