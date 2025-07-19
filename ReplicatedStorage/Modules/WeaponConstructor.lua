-- @ScriptType: ModuleScript


local ViewmodelModule = require(script.Viewmodel)


local Weapon = {}
Weapon.__index = Weapon


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
function Weapon:Update()
	
	-- viewmodel
	self.Viewmodel:Update()

	-- fire	
	
end

	

-- reload

return Weapon
