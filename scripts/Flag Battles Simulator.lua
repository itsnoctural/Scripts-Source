local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Click = false,
    Fight = false,
}

local function GetNearestDuel()
    local Enemy = nil
    local StartDist = 500

    for _, v in ipairs(Workspace.GameItems.Duels:GetChildren()) do
        local Distance = LocalPlayer:DistanceFromCharacter(v:GetPivot().Position)
    
        if Distance < StartDist then
            StartDist = Distance
            Enemy = v
        end
    end

    return Enemy
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("FBS | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Auto Click", {}, function(state)
    task.spawn(function()
        Settings.Click = state
        while true do
            if not Settings.Click then return end

            ReplicatedStorage.Framework.Remotes.Click:FireServer(); task.wait()
        end
    end)
end)

Window:Toggle("Auto Fight Nearest", {}, function(state)
    task.spawn(function()
        Settings.Fight = state
        while true do
            if not Settings.Fight then return end

            local Nearest = GetNearestDuel()

            if Nearest then
                ReplicatedStorage.Framework.Remotes.Fight:FireServer(Nearest:GetAttribute("Power"));
            end

            task.wait(.25)
        end
    end)
end)

Window:Toggle("Auto Rebirth", {}, function(state)
    task.spawn(function()
        Settings.Rebirth = state
        while true do
            if not Settings.Rebirth then return end

            ReplicatedStorage.Framework.Remotes.Rebirth:FireServer(); task.wait(.1)
        end
    end)
end)

Window:Button("Get Ultra Dominus [100k]", function()
    task.spawn(function()
        ReplicatedStorage.Framework.Remotes.Shiny:FireServer("Ultra Dominus", 3); task.wait()
    end)
end)

Window:Button("YouTube: EsohaSL", function()
    task.spawn(function()
        if setclipboard then
            setclipboard("https://youtube.com/@esohasl")
        end
    end)
end)

LocalPlayer.Idled:connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
    task.wait()
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
end)