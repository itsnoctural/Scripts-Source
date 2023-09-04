-- Link: https://www.roblox.com/games/11063612131/FREE-LIMITED-Every-Second-You-Get-1-Jump-Power
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Wins = false,
    Rebirth = false,
    BuySpins = false,
    Spin = false,
}

-- Library
local Library = {
    World = nil
}

function Library:GetLatestWorld()
    local WorldInstance = nil
    local TempWins = 0

    for _, v in ipairs(Workspace.Wins:GetChildren()) do
        local Wins = v:FindFirstChild("Wins")

        if Wins and Wins.Value > TempWins then
            TempWins = Wins.Value
            WorldInstance = v
        end
    end

    return WorldInstance
end

Library.World = Library:GetLatestWorld()

-- User Interface
local UILibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = UILibrary:CreateWindow("ESYGJP | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Auto Win", {}, function(state)
    task.spawn(function()
        Settings.Wins = state
        while true do
            if not Settings.Wins then return end

            LocalPlayer.Character:PivotTo(Library.World:GetPivot() + Vector3.new(0, 7.5, 0))
            task.wait(1.25)
        end
    end)
end)

Window:Toggle("Auto Rebirth", {}, function(state)
    task.spawn(function()
        Settings.Rebirth = state
        while true do
            if not Settings.Rebirth then return end

            ReplicatedStorage.RebirthEvent:FireServer()
            task.wait(.35)
        end
    end)
end)

Window:Toggle("Auto Spin", {}, function(state)
    task.spawn(function()
        Settings.Spin = state
        while true do
            if not Settings.Spin then return end

            ReplicatedStorage.SpinRemote:InvokeServer()
            task.wait(.25)
        end
    end)
end)

Window:Toggle("Auto Buy Spins", {}, function(state)
    task.spawn(function()
        Settings.BuySpins = state
        while true do
            if not Settings.BuySpins then return end

            ReplicatedStorage.SpinnerUpdate:FireServer("BuySpin")
            task.wait(.1)
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