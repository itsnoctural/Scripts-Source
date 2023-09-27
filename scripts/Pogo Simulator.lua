-- Link: https://www.roblox.com/games/14034883309/Pogo-Simulator
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Rebirth = false,
    Coins = false,
    Convert = false,
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("PogoS | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Auto Rebirth", {}, function(state)
    task.spawn(function()
        Settings.Rebirth = state
        while true do
            if not Settings.Rebirth then return end

            ReplicatedStorage.rebirth:FireServer()
            task.wait(.5)
        end
    end)
end)


Window:Toggle("Infinite Coins", {}, function(state)
    task.spawn(function()
        Settings.Coins = state
        while true do
            if not Settings.Coins then return end

            ReplicatedStorage.stickBought:FireServer("prostick", -1000000000);
            task.wait(.1)
        end
    end)
end)

Window:Toggle("Auto Power", {}, function(state)
    task.spawn(function()
        Settings.Convert = state
        while true do
            if not Settings.Convert then return end

            ReplicatedStorage.power:FireServer(1)
            task.wait(.1)
        end
    end)
end)

Window:Section("Anti-AFK Enabled")

Window:Button("YouTube: EsohaSL", function()
   task.spawn(function()
        pcall(function()
            setclipboard("https://youtube.com/@esohasl")
        end)
   end)
end)

LocalPlayer.Idled:connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
    task.wait()
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
end)