local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Fish = false,
    Rod = "Wooden Rod",
}

local function GetRods()
    local Rods = {}

    for _, v in ipairs(ReplicatedStorage.RodConfig:GetChildren()) do
        table.insert(Rods, v.Name)
    end

    return Rods
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("FS | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Fish", {}, function(state)
    task.spawn(function()
        Settings.Fish = state
        while true do
            if not Settings.Fish then return end

            ReplicatedStorage.FishRemote.GetFish:InvokeServer(Settings.Rod); task.wait(.1)
        end
    end)
end)

Window:Dropdown("Rods", {list =  GetRods()}, function(var)
    task.spawn(function()
        Settings.Rod = var
    end)
end)

Window:Section("Anti-AFK - Enabled")

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