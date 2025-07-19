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

function Viewmodel:Equip()
	
	ViewmodelModel.Parent = Camera
	
	local WeaponHandle = self.WeaponModel.Components.Handle
	local HRPMotor = ViewmodelModel:WaitForChild("HumanoidRootPart").Handle
	
	HRPMotor.Part1 = WeaponHandle
	
	self.WeaponModel.Parent = ViewmodelModel
end

function Viewmodel:Update()
	
	ViewmodelModel.PrimaryPart.CFrame = Camera.CFrame
	
end

return Viewmodel
