function E = compute_total_thermal_energy(mesh, nodalTemperature, rhoCpElem)
%COMPUTE_TOTAL_THERMAL_ENERGY Approximate integral rho*cp*T dV.
E = 0;
for e = 1:size(mesh.elements,1)
    Tbar = mean(nodalTemperature(mesh.elements(e,:)));
    E = E + rhoCpElem(e)*Tbar*mesh.elementVolumes(e);
end
end
