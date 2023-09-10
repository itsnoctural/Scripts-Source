-- Link: https://www.roblox.com/games/13896956178/Map4-Palm-Slap-Friends-Simulator
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Power = false,
    Palm = false,
    Neck = false,
    Slap = false,
    Rebirth = false,
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("PSFS | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Auto Power", {}, function(state)
    task.spawn(function()
        Settings.Power = state
        while true do
            if not Settings.Power then return end

            ReplicatedStorage.Event.ToolAttack:FireServer("Power", 4, "12"); task.wait()
        end
    end)
end)

Window:Toggle("Auto Palm", {}, function(state)
    task.spawn(function()
        Settings.Palm = state
        while true do
            if not Settings.Palm then return end

            ReplicatedStorage.Event.ToolAttack:FireServer("palm", 4, "7"); task.wait()
        end
    end)
end)

Window:Toggle("Auto Neck", {}, function(state)
    task.spawn(function()
        Settings.Neck = state
        while true do
            if not Settings.Neck then return end

            ReplicatedStorage.Event.ToolAttack:FireServer("Neck", 4, "12"); task.wait()
        end
    end)
end)

Window:Toggle("Auto Slap", {}, function(state)
    task.spawn(function()
        Settings.Slap = state
        while true do
            if not Settings.Slap then return end

            ReplicatedStorage.Event.TakeDamgeEvent:FireServer(true);
            task.wait()
        end
    end)
end)

Window:Toggle("Auto Rebirth", {}, function(state)
    task.spawn(function()
        Settings.Rebirth = state
        while true do
            if not Settings.Rebirth then return end

            ReplicatedStorage.Event.RebirthEvent:FireServer()
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

LocalPlayer.Idled:connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
    task.wait()
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
end)