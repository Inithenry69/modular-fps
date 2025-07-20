-- @ScriptType: LocalScript
local WeaponConstructor = require(game.ReplicatedStorage.Modules.WeaponConstructor)

local Honeybadger = WeaponConstructor.New("Honeybadger", game.ReplicatedStorage.Assets.Weapons.Honeybadger)
Honeybadger:Setup()

Honeybadger:Equip()

game:GetService("RunService"):BindToRenderStep("Viewmodel", Enum.RenderPriority.Camera.Value + 1, function(dt)
	
	Honeybadger:Update(dt)
	
end)

local shooting = false

game:GetService("UserInputService").InputBegan:Connect(function(input)
	
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		
		repeat 
			
			shooting = true
			
			Honeybadger:Fire(true)
			
			wait(0.1)
			
		until shooting == false
		
	end
	
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		
		shooting = false
		Honeybadger:Fire(false)

	end

end)