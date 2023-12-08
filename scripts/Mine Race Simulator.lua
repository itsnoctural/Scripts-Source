local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Gems = false,
    Slow = false,
}

local EffectsGui = LocalPlayer.PlayerGui:FindFirstChild("Effects")

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("MRS | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Fast Inf. Gems", {}, function(state)
    task.spawn(function()
        Settings.Gems = state
        while true do
            if not Settings.Gems then return end

            for i = 1, 21 do
                ReplicatedStorage.RemoteEvent:FireServer("Quarry.ReachedSection", i);
            end

            task.wait()
        end
    end)
end)

Window:Toggle("Slow Inf. Gems", {}, function(state)
    task.spawn(function()
        Settings.Slow = state
        while true do
            if not Settings.Slow then return end

            for i = 1, 21 do
                ReplicatedStorage.RemoteEvent:FireServer("Quarry.ReachedSection", i); task.wait()
            end

            task.wait()
        end
    end)
end)

Window:Button("Destroy Gem Effects", function()
    task.spawn(function()
        if EffectsGui then
            EffectsGui:Destroy()
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

LocalPlayer.Idled:connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
    task.wait()
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
end)