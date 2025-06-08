local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

getgenv().Settings = {
    Default = false,
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("AO | EsohaSL")

Window:Section("esohasl.net")

Window:Button("Get Instant UGC", function(state)
  task.spawn(function()      
    ReplicatedStorage.Signals.Events.SaveOutfits:FireServer("PurchaseItem", 140086970555376)
  end)
end)

Window:Button("YouTube: EsohaSL", function()
  task.spawn(function()
    if setclipboard then
        setclipboard("https://youtube.com/@esohasl")
    end
  end)
end)