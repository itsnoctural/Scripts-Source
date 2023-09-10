-- Link: https://www.roblox.com/games/13973120326/FREE-LIMITED-Grimace-Race
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Wins = false,
    Rebirth = false,
}

LocalPlayer.PlayerGui.ErorBoard.Enabled = false

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("GR/BRR | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Inf. Wins", {}, function(state)
    task.spawn(function()
        Settings.Wins = state
        while true do
            if not Settings.Wins then return end

            ReplicatedStorage.GameClient.Events.RemoteEvent.RestTimerDaliyChest:FireServer()
            task.wait()
        end
    end)
end)

Window:Toggle("Auto Rebirth", {}, function(state)
    task.spawn(function()
        Settings.Rebirth = state
        while true do
            if not Settings.Rebirth then return end

            ReplicatedStorage.GameClient.Events.RemoteEvent.UpdateRebirth:FireServer()
            task.wait(.25)
        end
    end)
end)

Window:Button("YouTube: EsohaSL", function()
   task.spawn(function()
        pcall(function()
            setclipboard("https://youtube.com/@esohasl")
        end)
   end)
end)