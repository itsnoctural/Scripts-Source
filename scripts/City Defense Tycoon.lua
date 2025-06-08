loadstring(game:HttpGet("https://raw.githubusercontent.com/itsnoctural/Utilities/main/base.lua"))()

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Income = false,
    Buttons = false,
    Rebirth = false,
}

local function FireTouchTransmitter(touchParent)
    local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")
  
    if Character then
        firetouchinterest(touchParent, Character, 0)
        firetouchinterest(touchParent, Character, 1)
    end
end

local function GetTycoon()
    for _,v in ipairs(Workspace.Tycoons:GetChildren()) do
        if v:GetAttribute("Owner") == LocalPlayer.Name then
            return v
        end
    end

    return nil
end

local Tycoon = GetTycoon()

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("CDT | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Inf. Income", {}, function(state)
    task.spawn(function()
        Settings.Income = state
        while true do
            if not Settings.Income then return end

            ReplicatedStorage.Knit.Services.TycoonService.RF.PayIncome:InvokeServer(LocalPlayer)
            task.wait()
        end
    end)
end)

Window:Toggle("Auto Buttons", {}, function(state)
    task.spawn(function()
        Settings.Buttons = state
        while true do
            if not Settings.Buttons then return end

            if Tycoon and Tycoon.Parent ~= nil and Tycoon:FindFirstChild("Buttons") then
                for _,v in ipairs(Tycoon.Buttons:GetChildren()) do
                    local config = require(v.config)

                    if config.Type ~= "Gamepass" then
                        ReplicatedStorage.Knit.Services.TycoonService.RF.BuyObject:InvokeServer(v.Name, config.Options and 3 or 1); task.wait()
                    end
                end
            else
                Tycoon = GetTycoon()
            end

            task.wait(.1)
        end
    end)
end)

Window:Toggle("Auto Rebirth", {}, function(state)
    task.spawn(function()
        Settings.Rebirth = state
        while true do
            if not Settings.Rebirth then return end

            ReplicatedStorage.Knit.Services.TycoonService.RF.Rebirth:InvokeServer()
            task.wait(1)
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

LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
    task.wait()
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
end)