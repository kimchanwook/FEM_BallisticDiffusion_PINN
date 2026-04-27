function db = default_material_database()
%DEFAULT_MATERIAL_DATABASE Reduced property database for first simulations.
% Values are placeholders for model development. Replace with measured or
% literature values before making quantitative claims.
db = struct();
db.sapphire = struct('label','substrate_sapphire','rho',3980,'cp',760,'k',35,'isSuperconductor',false,'isTrap',false);
db.high_resistivity_silicon = struct('label','substrate_silicon','rho',2330,'cp',700,'k',130,'isSuperconductor',false,'isTrap',false);
db.aluminum_superconductor = struct('label','superconductor_aluminum','rho',2700,'cp',900,'k',200,'Tc',1.2,'isSuperconductor',true,'isTrap',false);
db.tantalum_superconductor = struct('label','superconductor_tantalum','rho',16650,'cp',140,'k',57,'Tc',4.5,'isSuperconductor',true,'isTrap',false);
db.niobium_superconductor = struct('label','superconductor_niobium','rho',8570,'cp',265,'k',54,'Tc',9.2,'isSuperconductor',true,'isTrap',false);
db.copper_trap = struct('label','normal_metal_trap_copper','rho',8960,'cp',385,'k',400,'isSuperconductor',false,'isTrap',true);
db.gold_trap = struct('label','normal_metal_trap_gold','rho',19300,'cp',129,'k',318,'isSuperconductor',false,'isTrap',true);
end
