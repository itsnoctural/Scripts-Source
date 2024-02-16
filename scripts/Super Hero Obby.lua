local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Points = false,
}

local function FireTouchTransmitter(touchParent)
    local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")

    if Character then
        firetouchinterest(touchParent, Character, 0)
        firetouchinterest(touchParent, Character, 1)
    end
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("SHO | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Farm Points", {}, function(state)
    task.spawn(function()
        Settings.Points = state
        while true do
            if not Settings.Points then return end

            FireTouchTransmitter(Workspace.PointFolder["100"]); task.wait(.25)
            ReplicatedStorage.Rebirth:FireServer("Actual");

            task.wait(.1)
        end
    end)
end)

Window:Button("YouTube: EsohaSL", function()
    task.spawn(function()
        if setclipboard then
            setclipboard("https://youtube.com/@esohasl")
        end
    end)
end)