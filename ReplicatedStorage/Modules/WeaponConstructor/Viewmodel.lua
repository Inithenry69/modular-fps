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
	self.WeaponProperties = require(WeaponModel.Settings)
	
	-- springs
	self.SwayingSpring = SpringModule.new()
	self.RecoilSpring = SpringModule.new()
	self.KickSpring = SpringModule.new()
	
	self.shots = 0
	
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
	local UpdatedRecoilSpring = self.RecoilSpring:update(dt)
	local UpdatedKickSpring = self.KickSpring:update(dt)
	
	-- update viewmodel
	ViewmodelModel.PrimaryPart.CFrame = Camera.CFrame 
	
	--kick
	ViewmodelModel.PrimaryPart.CFrame *= CFrame.new(UpdatedSwayingSpring.X, UpdatedSwayingSpring.Y, 0)
	ViewmodelModel.PrimaryPart.CFrame *= CFrame.new(0, 0, UpdatedKickSpring.Z)	
	
	-- update camera	
	Camera.CFrame = Camera.CFrame * CFrame.Angles(math.rad(UpdatedRecoilSpring.X), math.rad(UpdatedRecoilSpring.Y), 0)
end

function Viewmodel:Recoil(isSpray)
	
	local RECOILS = self.WeaponProperties.RECOILS
	
	if isSpray then
		
		self.shots += 1
		
		if self.shots >= #RECOILS then
			
			self.shots = 1
			
		end
		
		self.RecoilSpring:shove(
			Vector3.new(RECOILS[self.shots][1], RECOILS[self.shots][2], 0)
		)
		
		self.KickSpring:shove(
			self.WeaponProperties.KICK
		)
		
	end
	
	if isSpray == false then
		
		self.shots = 0
		
	end
	
end

return Viewmodel
