-- @ScriptType: ModuleScript


local ViewmodelModule = require(script.Viewmodel)
local Camera = workspace.CurrentCamera


local Weapon = {}
Weapon.__index = Weapon

local function EmitParticles(object)
	for _, Particles in pairs(object:GetDescendants()) do
		if Particles:IsA("ParticleEmitter") then
			Particles:Emit(1)
		end
	end
end

function Weapon.New(WeaponName, Model)
	local self = setmetatable({}, Weapon)	
	
	self.Name = WeaponName
	self.Model = Model
	self.Viewmodel = ViewmodelModule.New(self.Model)
	
	return self	
end

-- equip
function Weapon:Setup()
	
	local MainPart = self.Model.Components.Handle
	
	for i, part in ipairs(self.Model:GetDescendants()) do
		
		if part:IsA("BasePart") and part ~= MainPart then
			
			-- part settings
			part.CanCollide = false
				
			if part.Parent.Name == "Animatable" then
				
				local NewMotor = Instance.new("Motor6D")
				NewMotor.Name = part.Name
				NewMotor.Part0 = MainPart
				NewMotor.Part1 = part
				NewMotor.C0 = NewMotor.Part0.CFrame:Inverse() * NewMotor.Part1.CFrame
				NewMotor.Parent = MainPart
				
			else
				
				local NewWeld = Instance.new("Weld")
				NewWeld.Name = part.Name
				NewWeld.Part0 = MainPart
				NewWeld.Part1 = part
				NewWeld.C0 = NewWeld.Part0.CFrame:Inverse() * NewWeld.Part1.CFrame
				NewWeld.Parent = MainPart				
			
			end
			
		end
		
	end
	
end

-- equip
function Weapon:Equip()
	
	self.Viewmodel:Equip()
	
end

-- dequip

-- update
function Weapon:Update(dt)
	
	-- viewmodel
	self.Viewmodel:Update(dt)
	
end

function Weapon:Fire(isStart)
	
	self.Viewmodel:Recoil(isStart)
	
	if isStart then
		-- SFX
		
		-- VFX
		EmitParticles(self.Model.Components.FirePart)		
		
		-- Actually shoot bullets
		local Params = RaycastParams.new()
		Params.FilterType = Enum.RaycastFilterType.Exclude
		Params.FilterDescendantsInstances = {
			self.Model,
			game.Players.LocalPlayer.Character
		}

		local hit = workspace:Raycast(Camera.CFrame.Position, Camera.CFrame.LookVector * 100, Params)

		if hit then

			

		end
	end
	
end
	

-- reload

return Weapon
