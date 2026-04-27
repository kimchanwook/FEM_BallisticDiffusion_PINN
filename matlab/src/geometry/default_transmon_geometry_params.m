function p = default_transmon_geometry_params()
%DEFAULT_TRANSMON_GEOMETRY_PARAMS Baseline hard-coded planar transmon geometry.
% All dimensions are SI units.
p = struct();
p.substrate.material = 'sapphire';
p.substrate.length = 3.0e-3;
p.substrate.width = 3.0e-3;
p.substrate.thickness = 0.50e-3;

p.film.material = 'aluminum_superconductor';
p.film.thickness = 100e-9;
p.pad.length = 600e-6;
p.pad.width = 300e-6;
p.pad.gap = 60e-6;

p.lead.width = 8e-6;
p.lead.length = 40e-6;
p.junction.effectiveLength = 1.0e-6;
p.junction.effectiveWidth = 1.0e-6;
p.junction.effectiveThickness = p.film.thickness;

p.trap.material = 'copper_trap';
p.trap.length = 100e-6;
p.trap.width = 10e-6;
p.trap.thickness = 80e-9;
p.trap.distanceFromJunction = 80e-6;
p.trap.side = 'left';

p.heatSink.enabled = true;
p.heatSink.material = 'copper_trap';
p.heatSink.length = 300e-6;
p.heatSink.width = 300e-6;
p.heatSink.thickness = 1.0e-6;

p.qp.superconductorDiffusivity = 2.0e-3;       % m^2/s, effective baseline
p.qp.substrateEffectiveDiffusivity = 1.0e-14;  % QPs do not diffuse through substrate in first model
p.qp.backgroundRemovalRate = 1.0e4;            % 1/s
p.qp.trapRemovalRate = 5.0e7;                  % 1/s
p.qp.junctionSourceRate = 1.0e22;              % arbitrary density source scale for first tests
end
