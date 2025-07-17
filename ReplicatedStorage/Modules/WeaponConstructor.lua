-- @ScriptType: ModuleScript



export type WeaponType = {
	name : string;
	model : Model;
	firetype : string; -- auto / semi
	firerate : number;	
}


local Weapon = {}
Weapon.__index = Weapon

function Weapon.New(WeaponProperties : WeaponType)
	local self = setmetatable({}, Weapon)
	
	self.WeaponProperties = WeaponProperties
	
	return self	
end

-- update

	-- viewmodel

	-- fire

-- reload

return Weapon
