function Jstep = compute_junction_exposure_metric(mesh, nodalDensity, dt)
%COMPUTE_JUNCTION_EXPOSURE_METRIC One-step integral of density over JJ region.
Jstep = 0;
for e = 1:size(mesh.elements,1)
    if mesh.elementRegion.isJunction(e)
        nbar = mean(nodalDensity(mesh.elements(e,:)));
        Jstep = Jstep + mesh.elementVolumes(e)*nbar*dt;
    end
end
end
