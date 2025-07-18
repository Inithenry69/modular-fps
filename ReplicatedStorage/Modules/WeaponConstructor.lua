-- @ScriptType: ModuleScript



export type WeaponType = {
	name : string;
	model : Model;
	firetype : string; -- auto / semi
	firerate : number;	
}

local ViewmodelModule = require(script.Viewmodel)


local Weapon = {}
Weapon.__index = Weapon


function Weapon.New(WeaponProperties : WeaponType)
	local self = setmetatable({}, Weapon)
		
	self.WeaponProperties = WeaponProperties
	
	return self	
end

-- equip
function Weapon:Setup()
	
	local WeaponModel = self.WeaponProperties.model
	
	for 	
	
end

-- update
function Weapon:Update()
		
end

	-- viewmodel

	-- fire

-- reload

return Weapon
