# Module 1 Slide Outline: Ballistic-Diffusive Heat Conduction

Purpose: convert `module1_ballistic_diffusive_heat_conduction.pdf` into a physics-lecture-style slide sequence. This is not the final slide deck; it is the structure to use when building the PowerPoint later.

## Slide 1 - Why ordinary heat conduction breaks down

**Main question:** When does Fourier heat conduction stop being physically reliable?

**Core message:** Fourier law is local. Nanoscale and ultrafast heat transport can be nonlocal because heat carriers travel finite distances before scattering.

**Equation to show:**

```tex
\mathbf{q}=-k\nabla T
```

**Figure idea:** A device length `L` compared to mean free path `Lambda`. Show `Lambda << L` versus `Lambda ~ L`.

**Speaker emphasis:** The failure is not that Fourier law is useless. The failure is that its assumptions break when the carrier mean free path and the device length are comparable.

---

## Slide 2 - Heat carriers, scattering time, and mean free path

**Main question:** What is actually moving the energy?

**Core message:** Heat is transported by microscopic carriers such as phonons, electrons, or molecules. A carrier moves with group velocity `v`, scatters after a characteristic time `tau`, and travels a mean free path `Lambda`.

**Equations to show:**

```tex
\Lambda=v\tau
```

```tex
\mathrm{Kn}=\frac{\Lambda}{L}
```

**Figure idea:** Carrier trajectories with several scattering events in a large device, and nearly collisionless trajectories in a small device.

**Speaker emphasis:** The Knudsen number is the organizing parameter for Module 1.

---

## Slide 3 - Temperature is subtle outside local equilibrium

**Main question:** Can every small region be assigned a true temperature?

**Core message:** True thermodynamic temperature requires local equilibrium. In a ballistic or quasi-ballistic regime, the carrier distribution can be directional and nonequilibrium. The useful quantity is often an equivalent internal-energy temperature.

**Equation to show:**

```tex
\Delta u = C\Delta T
```

**Figure idea:** Compare an isotropic equilibrium carrier distribution against a directional nonequilibrium distribution near a boundary.

**Speaker emphasis:** This point matters later because boundary-emitted temperature is not necessarily the same as the equivalent temperature inside the film.

---

## Slide 4 - Distribution function and Boltzmann transport equation

**Main question:** What is the microscopic equation behind the model?

**Core message:** Instead of starting from temperature, start from the carrier distribution function `f(t,r,k)`. The Boltzmann transport equation tracks streaming and scattering.

**Equation to show:**

```tex
\frac{\partial f}{\partial t}+\mathbf{v}\cdot\nabla_{\mathbf{r}}f
=-\frac{f-f_0}{\tau}
```

**Figure idea:** Streaming through space plus relaxation toward local equilibrium.

**Speaker emphasis:** The relaxation-time approximation compresses complicated collision physics into one characteristic relaxation time.

---

## Slide 5 - Fourier conduction as the diffusive limit

**Main question:** How does the familiar heat equation emerge?

**Core message:** When the mean free path is much smaller than the device size, carriers scatter many times and lose directional memory. The flux becomes locally proportional to the temperature gradient.

**Equations to show:**

```tex
\mathbf{q}=-k\nabla T
```

```tex
C\frac{\partial T}{\partial t}=\nabla\cdot(k\nabla T)+\dot{q}_e
```

**Figure idea:** Many randomizing scattering events over a length `L`.

**Speaker emphasis:** Fourier law is a valid limit, not a fundamental microscopic law.

---

## Slide 6 - Why Fourier fails at small scales

**Main question:** What exactly goes wrong mathematically and physically?

**Core message:** The parabolic heat equation predicts an instantaneous nonzero response everywhere. Physically, heat carriers move at finite speed.

**Equation to show:**

```tex
G(x,t)=\frac{1}{\sqrt{4\pi\alpha t}}\exp\left(-\frac{x^2}{4\alpha t}\right)
```

**Figure idea:** Gaussian heat-kernel tails extending everywhere for any `t > 0`.

**Speaker emphasis:** Infinite propagation speed is negligible at macroscale but can dominate early-time nanoscale predictions.

---

## Slide 7 - Cattaneo fixes speed but not ballistic memory

**Main question:** Does adding a flux relaxation time solve the problem?

**Core message:** Cattaneo conduction introduces finite flux response time, but it still treats all heat flux as a single local continuum field. It does not represent boundary-originating ballistic particles.

**Equation to show:**

```tex
\tau\frac{\partial \mathbf{q}}{\partial t}+\mathbf{q}=-k\nabla T
```

**Figure idea:** Compare a smooth ballistic arrival picture with a continuum thermal-wave picture.

**Speaker emphasis:** Finite propagation speed is necessary but not sufficient.

---

## Slide 8 - Ballistic-diffusive split

**Main question:** How do we keep the essential Boltzmann physics without solving full phase space?

**Core message:** Split the carrier intensity into a boundary-originating ballistic component and an internally scattered medium component.

**Equation to show:**

```tex
I_\omega = I_{b\omega}+I_{m\omega}
```

**Figure idea:** Rays from the boundary for `I_b`; scattered, nearly isotropic population inside the material for `I_m`.

**Speaker emphasis:** This is the central modeling idea of Gang Chen's ballistic-diffusive equation.

---

## Slide 9 - Ballistic component by characteristics

**Main question:** How does the ballistic component remember the boundary?

**Core message:** Boundary-originating carriers arrive at an interior point after a finite flight time and are attenuated by scattering probability.

**Equation to show:**

```tex
I_{b\omega}(t,\mathbf{r},\hat{\Omega})
=I_{w\omega}\left(t-\frac{s-s_0}{v},\mathbf{r}-(s-s_0)\hat{\Omega}\right)
\exp\left[-\int_{s_0}^{s}\frac{ds'}{v\tau_\omega}\right]
```

**Figure idea:** Ray from boundary to interior point with travel distance and retarded time annotated.

**Speaker emphasis:** This is the mathematical expression of nonlocal boundary memory.

---

## Slide 10 - Medium component by P1/diffusion closure

**Main question:** How is the scattered population simplified?

**Core message:** The internally scattered population is more isotropic than the ballistic population. Keep the isotropic term and first anisotropic correction.

**Equation to show:**

```tex
I_{m\omega}=J_{0\omega}+\mathbf{J}_{1\omega}\cdot\hat{\Omega}
```

**Figure idea:** Angular distribution becoming nearly isotropic after scattering.

**Speaker emphasis:** This is the approximation that makes the model FEM-friendly.

---

## Slide 11 - Final ballistic-diffusive PDE

**Main question:** What equation will be implemented numerically?

**Core message:** The scattered medium energy satisfies a Cattaneo-like PDE, but it is forced by the divergence of the ballistic flux.

**Equation to show:**

```tex
\tau\frac{\partial^2u_m}{\partial t^2}
+\frac{\partial u_m}{\partial t}
=\nabla\cdot\left(\frac{k}{C}\nabla u_m\right)
-\nabla\cdot\mathbf{q}_b
+\left(\dot{q}_e+\tau\frac{\partial\dot{q}_e}{\partial t}\right)
```

**Figure idea:** Block diagram: boundary rays compute `q_b`; FEM solves for `u_m`; total energy is `u = u_m + u_b`.

**Speaker emphasis:** The term `-div(q_b)` is the physics Fourier and Cattaneo miss.

---

## Slide 12 - Thin-film benchmark

**Main question:** How do we validate the model before using it in 3D geometry?

**Core message:** Reduce the equation to a 1D film, nondimensionalize it, and sweep Knudsen number.

**Equation to show:**

```tex
\frac{\partial^2\theta_m}{\partial {t^*}^2}
+\frac{\partial\theta_m}{\partial t^*}
=\frac{\mathrm{Kn}^2}{3}\frac{\partial^2\theta_m}{\partial\eta^2}
-\mathrm{Kn}\frac{\partial q_b^*}{\partial\eta}
```

**Figure idea:** Film from `eta=0` to `eta=1`, heated at the left boundary.

**Speaker emphasis:** This is the first numerical validation target for the project.

---

## Slide 13 - Finite arrival time in the thin film

**Main question:** How does the model enforce finite propagation speed?

**Core message:** At a given position and time, only carrier directions that could have physically arrived contribute.

**Equations to show:**

```tex
\mu_t=\frac{\eta}{\mathrm{Kn}\,t^*}
```

```tex
q_b^*(\eta,t^*)=\frac{1}{2}\int_{\mu_t}^{1}\mu\exp\left(-\frac{\eta}{\mu\mathrm{Kn}}\right)d\mu
```

**Figure idea:** Shallow-angle versus forward-angle paths from left boundary to a point in the film.

**Speaker emphasis:** The lower angular limit is the finite-flight-time physics.

---

## Slide 14 - Expected validation plots

**Main question:** What should the simulation show?

**Core message:** As `Kn` increases, the solution transitions from Fourier-like diffusion to ballistic-diffusive transport.

**Plots to generate:**

- `theta_m(eta,t*)`
- `theta_b(eta,t*)`
- `theta = theta_m + theta_b`
- `q_b*(eta,t*)`
- surface heat flux versus time
- comparison against Fourier and Cattaneo

**Speaker emphasis:** The goal is not just code output. The goal is to demonstrate the change in physical regime.

---

## Slide 15 - Why this matters for superconducting qubits

**Main question:** How does Module 1 connect to quasiparticle poisoning?

**Core message:** A local energy deposition event in a superconducting qubit chip may launch nonequilibrium phonons and energy carriers. Before local equilibrium is established, geometry, traps, heat sinks, and boundaries can strongly affect where energy goes.

**Figure idea:** Planar transmon with a local source near one pad, ballistic phonon paths through the substrate, and engineered trap or heat-sink regions.

**Speaker emphasis:** Module 1 provides the transport foundation. Later modules add superconductivity, quasiparticles, geometry, FEM, and PINN acceleration.
