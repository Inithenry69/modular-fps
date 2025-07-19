-- @ScriptType: ModuleScript



local Viewmodel = {}
Viewmodel.__index = Viewmodel

local UserInputService = game:GetService("UserInputService")

local SpringModule = require(game:GetService("ReplicatedStorage").Modules.SpringModule)
local ViewmodelModel = game:GetService("ReplicatedStorage").Assets.Viewmodel:Clone()

local Camera = workspace.CurrentCamera


function Viewmodel.New(WeaponModel)
	
	local self = setmetatable({}, Viewmodel)
	
	self.WeaponModel = WeaponModel
	self.AnimationFolder = WeaponModel.Settings
	
	-- springs
	self.SwayingSpring = SpringModule.new()
	self.RecoilSpring = SpringModule.new()
	
	return self
	
end

function Viewmodel:Equip()
	
	ViewmodelModel.Parent = Camera
	
	local WeaponHandle = self.WeaponModel.Components.Handle
	local HRPMotor = ViewmodelModel:WaitForChild("HumanoidRootPart").Handle
	
	HRPMotor.Part1 = WeaponHandle
	
	self.WeaponModel.Parent = ViewmodelModel
	
	------------------------------------------------------------------------------------------
	
	ViewmodelModel.AnimationController:LoadAnimation(self.AnimationFolder.Idle):Play()
end

function Viewmodel:Update(dt)
	
	local MouseDelta = UserInputService:GetMouseDelta()
	
	self.SwayingSpring:shove(Vector3.new(-MouseDelta.X / 500, MouseDelta.Y / 200, 0))
	
	local UpdatedSwayingSpring = self.SwayingSpring:update(dt)
	
	ViewmodelModel.PrimaryPart.CFrame = Camera.CFrame *
		CFrame.new(UpdatedSwayingSpring.X, UpdatedSwayingSpring.Y, 0)
		
end

return Viewmodel
