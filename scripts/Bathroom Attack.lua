local Auth = loadstring(game:HttpGet("https://raw.githubusercontent.com/itsnoctural/Utilities/main/base.lua"))()
repeat task.wait(.1) until Auth.Finished

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local FireArgs = "player_" .. LocalPlayer.UserId .. "_skill_"

local Weapons = require(ReplicatedStorage.Scripts.Configs.WeaponConfig)
local Skills = require(ReplicatedStorage.Scripts.Configs.SkillConfig)

getgenv().Settings = {
    Kill = false,
	Collect = false,
}

local function GetWeaponId(name)
	for _,v in ipairs(Weapons) do
		if v.Name == name then return v.SkillId end
	end

	return false
end

local function IdentifyPlayerWeapon()
	for _,v in ipairs(LocalPlayer.Character:GetChildren()) do
		if v:IsA("Tool") then
			local Response = GetWeaponId(v.Name)

			if Response then
				return Response;
			end
		end
	end

	for _,v in ipairs(LocalPlayer.Backpack:GetChildren()) do
		local Response = GetWeaponId(v.Name)

		if Response then
			local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			if Humanoid then Humanoid:EquipTool(v) end

			return Response;
		end
	end

	return 101;
end

local function FireTouchTransmitter(touchParent)
    local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")

    if Character then
        firetouchinterest(touchParent, Character, 0)
        firetouchinterest(touchParent, Character, 1)
    end
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("BA | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Kill", {}, function(state)
    task.spawn(function()
        Settings.Kill = state
        while true do
            if not Settings.Kill then return end

			local Enemies = {}

			for _,v in ipairs(Workspace.Enemies:GetChildren()) do
				local Head = v:FindFirstChild("Head")
				local Humanoid = v:FindFirstChildOfClass("Humanoid")

				if Head and (Humanoid and Humanoid.Health > 0) then
					table.insert(Enemies, Head)
				end
			end

			ReplicatedStorage.Scripts.Common.Event.RemoteEvent:FireServer(FireArgs .. IdentifyPlayerWeapon() .. "_fire", Vector3.new(0, 0, 0), {Vector3.new(0, 0, 0)}, Enemies)

			task.wait()
        end
    end)
end)

Window:Toggle("Auto Collect", {}, function(state)
    task.spawn(function()
        Settings.Collect = state
        while true do
            if not Settings.Collect then return end

			for _,v in ipairs(Workspace.TmpObjects:GetDescendants()) do
				if v:IsA("TouchTransmitter") then
					FireTouchTransmitter(v.Parent); task.wait()
				end
			end

			task.wait(.25)
        end
    end)
end)

Window:Button("Teleport to Spawn", function()
    task.spawn(function()
        LocalPlayer.Character:PivotTo(Workspace.Lobby.SpawnLocations.SpawnLocation:GetPivot())
    end)
end)


Window:Button("YouTube: EsohaSL", function()
    task.spawn(function()
        if setclipboard then
            setclipboard("https://youtube.com/@esohasl")
        end
    end)
end)

LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
    task.wait()
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
end)