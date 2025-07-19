-- @ScriptType: LocalScript
local WeaponConstructor = require(game.ReplicatedStorage.Modules.WeaponConstructor)

local Honeybadger = WeaponConstructor.New("Honeybadger", game.ReplicatedStorage.Assets.Weapons.Honeybadger)
Honeybadger:Setup()

Honeybadger:Equip()

game:GetService("RunService"):BindToRenderStep("Viewmodel", Enum.RenderPriority.Camera.Value + 1, function()
	
	Honeybadger:Update()
	
end)