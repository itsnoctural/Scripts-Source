-- Key System
local Base = loadstring(game:HttpGet("https://raw.githubusercontent.com/itsnoctural/Utilities/main/base.lua"))()

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Products = require(ReplicatedStorage.Shared.config.ProductConstants)

getgenv().Settings = {
    Grab = false,
    Decision = "keep"
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("FBE | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Grab Item", {}, function(state)
    task.spawn(function()
        Settings.Grab = state
        while true do
            if not Settings.Grab then return end

            ReplicatedStorage.Remotes.FentyRollFunction:InvokeServer(); task.wait()
            ReplicatedStorage.Remotes.ProductDecisionFunction:InvokeServer(Settings.Decision)

            task.wait(.1)
        end
    end)
end)

Window:Dropdown("Decision", {list = {"keep", "discard"}}, function(var)
    task.spawn(function()
        Settings.Decision = var
    end)
end)

Window:Toggle("Auto Sell Inventory", {}, function(state)
    task.spawn(function()
        Settings.Sell = state
        while true do
            if not Settings.Sell then return end

            for i,v in pairs(Products) do
                ReplicatedStorage.Remotes.DiscardProductFunction:InvokeServer(i); task.wait()
            end

            task.wait(.25)
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