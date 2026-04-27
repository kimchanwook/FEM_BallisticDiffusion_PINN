function mesh = tag_material_regions_3d(mesh, geom, matDB)
%TAG_MATERIAL_REGIONS_3D Tag each element by cuboid region and role.
numElem = size(mesh.elements,1);
labels = repmat({'void_or_unassigned'}, numElem, 1);
role = repmat({'none'}, numElem, 1);
isJunction = false(numElem,1);
isTrap = false(numElem,1);
isSuperconductor = false(numElem,1);
for e = 1:numElem
    c = mesh.elementCenters(e,:);
    for r = 1:numel(geom.regions)
        reg = geom.regions(r);
        if all(c >= reg.min) && all(c <= reg.max)
            if isfield(matDB, reg.material)
                mat = matDB.(reg.material);
                labels{e} = mat.label;
            else
                labels{e} = reg.material;
            end
            role{e} = reg.role;
            if contains(reg.role, 'junction'); isJunction(e) = true; end
            if contains(reg.role, 'trap'); isTrap(e) = true; end
            if contains(reg.role, 'superconductor') || contains(reg.role, 'junction')
                isSuperconductor(e) = true;
            end
        end
    end
end
% If the mesh is too coarse to place a center inside the small effective JJ,
% force the nearest top-film element to carry the junction-sensitive tag. This
% keeps first-pass coarse meshes usable while preserving the metric definition.
if ~any(isJunction)
    jjIdx = find(strcmp({geom.regions.role}, 'junction_sensitive'), 1);
    if ~isempty(jjIdx)
        c0 = (geom.regions(jjIdx).min + geom.regions(jjIdx).max)/2;
        [~, eNear] = min(sum((mesh.elementCenters - c0).^2, 2));
        isJunction(eNear) = true;
        isSuperconductor(eNear) = true;
        labels{eNear} = 'superconductor_effective_junction';
        role{eNear} = 'junction_sensitive';
    end
end
if ~any(isTrap)
    trapIdx = find(strcmp({geom.regions.role}, 'trap'), 1);
    if ~isempty(trapIdx)
        c0 = (geom.regions(trapIdx).min + geom.regions(trapIdx).max)/2;
        [~, eNear] = min(sum((mesh.elementCenters - c0).^2, 2));
        isTrap(eNear) = true;
        labels{eNear} = 'normal_metal_trap_effective';
        role{eNear} = 'trap';
    end
end

mesh.elementMaterialLabels = labels;
mesh.elementRegion.role = role;
mesh.elementRegion.isJunction = isJunction;
mesh.elementRegion.isTrap = isTrap;
mesh.elementRegion.isSuperconductor = isSuperconductor;
end
