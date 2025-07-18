-- @ScriptType: ModuleScript



local Viewmodel = {}
Viewmodel.__index = Viewmodel

local ViewmodelModel = game:GetService("ReplicatedStorage").Assets.Viewmodel:Clone()

local Camera = workspace.CurrentCamera


function Viewmodel.New(WeaponModel)
	
	local self = setmetatable({}, Viewmodel)
	
	self.WeaponModel = WeaponModel
	
	return self
	
end

function Viewmodel:Update()
	
	
	
end

return Viewmodel
