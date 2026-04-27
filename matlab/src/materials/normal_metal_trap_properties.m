function props = normal_metal_trap_properties(materialName)
%NORMAL_METAL_TRAP_PROPERTIES Effective trap properties.
switch lower(materialName)
    case {'cu','copper','copper_trap'}
        props = struct('material','copper','k',400,'trapRemovalRate',5.0e7);
    case {'au','gold','gold_trap'}
        props = struct('material','gold','k',318,'trapRemovalRate',3.0e7);
    otherwise
        props = struct('material','generic_normal_trap','k',100,'trapRemovalRate',1.0e7);
end
end
