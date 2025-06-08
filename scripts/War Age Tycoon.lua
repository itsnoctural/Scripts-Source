local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
  Buttons = false,
}

local function GetTycoon()
  for _,v in ipairs(Workspace.Tycoons:GetChildren()) do
    if v:GetAttribute("LastOwner") == LocalPlayer.Name then
      return v
    end
  end

  return nil
end

local Tycoon = GetTycoon()

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("War Age Tycoon")

Window:Toggle("Auto Buttons", {}, function(state)
  task.spawn(function()
    Settings.Buttons = state
    while true do
      if not Settings.Buttons then return end

      for _,v in ipairs(Tycoon.Buttons:GetChildren()) do
        if LocalPlayer.leaderstats.Cash.Value >= v:GetAttribute("Price") then
          ReplicatedStorage.Remotes.RequestPurchase:FireServer(v); task.wait()
        end
      end

      task.wait(1)
    end
  end)
end)

Window:Toggle("Auto Collect", {}, function(state)
  task.spawn(function()
    Settings.Collect = state
    while true do
      if not Settings.Collect then return end

      ReplicatedStorage.Remotes.RequestCollection:FireServer(Tycoon, Tycoon.StarterItems.MainCollectionArea)
      task.wait(0.75)
    end
  end)
end)