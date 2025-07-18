-- @ScriptType: ModuleScript



local Viewmodel = {}
Viewmodel.__index = Viewmodel

local ViewmodelModel = game:GetService("ReplicatedStorage").Assets.Viewmodel

function Viewmodel.New()
	
	local self = setmetatable({}, Viewmodel)
		
	return self
	
end

return Viewmodel
