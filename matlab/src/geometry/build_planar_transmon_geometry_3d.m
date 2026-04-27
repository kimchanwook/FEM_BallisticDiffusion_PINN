function geom = build_planar_transmon_geometry_3d(p)
%BUILD_PLANAR_TRANSMON_GEOMETRY_3D Create cuboid regions for a planar transmon.
% Coordinate convention: substrate top surface is z = 0, film extends to z > 0.
regions = struct('name',{},'material',{},'min',{},'max',{},'role',{});
add = @(name, mat, mn, mx, role) struct('name',name,'material',mat,'min',mn,'max',mx,'role',role);

subMin = [-p.substrate.length/2, -p.substrate.width/2, -p.substrate.thickness];
subMax = [ p.substrate.length/2,  p.substrate.width/2, 0];
regions(end+1) = add('substrate', p.substrate.material, subMin, subMax, 'substrate');

z0 = 0; z1 = p.film.thickness;
padY = [-p.pad.width/2, p.pad.width/2];
leftX  = [-(p.pad.gap/2 + p.pad.length), -p.pad.gap/2];
rightX = [ p.pad.gap/2, (p.pad.gap/2 + p.pad.length)];
regions(end+1) = add('left_capacitor_pad', p.film.material, [leftX(1), padY(1), z0], [leftX(2), padY(2), z1], 'superconductor_pad');
regions(end+1) = add('right_capacitor_pad', p.film.material, [rightX(1), padY(1), z0], [rightX(2), padY(2), z1], 'superconductor_pad');

leadY = [-p.lead.width/2, p.lead.width/2];
regions(end+1) = add('left_junction_lead', p.film.material, [-p.pad.gap/2, leadY(1), z0], [-p.junction.effectiveLength/2, leadY(2), z1], 'superconductor_lead');
regions(end+1) = add('right_junction_lead', p.film.material, [ p.junction.effectiveLength/2, leadY(1), z0], [ p.pad.gap/2, leadY(2), z1], 'superconductor_lead');

jjMin = [-p.junction.effectiveLength/2, -p.junction.effectiveWidth/2, z0];
jjMax = [ p.junction.effectiveLength/2,  p.junction.effectiveWidth/2, z1];
regions(end+1) = add('effective_josephson_junction_region', p.film.material, jjMin, jjMax, 'junction_sensitive');

% Trap placement. Baseline trap sits on the selected pad at a distance from JJ.
if strcmpi(p.trap.side, 'left')
    trapCenterX = -p.trap.distanceFromJunction;
else
    trapCenterX = p.trap.distanceFromJunction;
end
trapCenterY = 0.35*p.pad.width;
trapMin = [trapCenterX-p.trap.length/2, trapCenterY-p.trap.width/2, z0];
trapMax = [trapCenterX+p.trap.length/2, trapCenterY+p.trap.width/2, p.trap.thickness];
regions(end+1) = add('normal_metal_qp_trap', p.trap.material, trapMin, trapMax, 'trap');

if p.heatSink.enabled
    hsMin = [-p.heatSink.length/2, -p.heatSink.width/2, -p.substrate.thickness-p.heatSink.thickness];
    hsMax = [ p.heatSink.length/2,  p.heatSink.width/2, -p.substrate.thickness];
    regions(end+1) = add('backside_heat_sink', p.heatSink.material, hsMin, hsMax, 'heat_sink');
end

geom = struct();
geom.params = p;
geom.regions = regions;
end
