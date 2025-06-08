-- Game Link: https://www.roblox.com/games/18920893671/Mining-Tycoon-Update-3
loadstring(game:HttpGet("https://raw.githubusercontent.com/itsnoctural/Utilities/main/base.lua"))()

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
  Miners = false,
  Prospect = false,
  Door = false,
}

local function GetTycoon()
  for _,v in ipairs(Workspace:GetChildren()) do
    if v:IsA("Folder") and v:GetAttribute("TycoonOwnerId") == LocalPlayer.UserId then
      return v.Tycoon
    end
  end

  return nil
end

local Tycoon = GetTycoon()

local function IsFull()
  if Tycoon.Machines.Seller:FindFirstChild("Minecart") then
    return string.find(Tycoon.Machines.Seller.Minecart.Gui.CanvasGroup.Progress.BarContainer.Quantity.Text, "Full")
  end

  return false
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("MT | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Max Miners", {}, function(state)
  task.spawn(function()
    Settings.Miners = state
    while true do
      if not Settings.Miners then return end

      ReplicatedStorage.Packages._Index["supersocial_flux@0.0.2"].flux.Services.TycoonService.RF.PurchaseMaxNodes:InvokeServer();
      task.wait(1)
    end
  end)
end)

Window:Toggle("Auto Prospect", {}, function(state)
  task.spawn(function()
    Settings.Prospect = state
    while true do
      if not Settings.Prospect then return end

      Tycoon.Machines.Prospector.ButtonPodium.ButtonEvent:FireServer()
      task.wait(.2)
    end
  end)
end)

Window:Toggle("Auto Open Door", {}, function(state)
  task.spawn(function()
    Settings.Door = state
    while true do
      if not Settings.Door then return end

      Tycoon.Machines.Forge.ButtonPodium.ButtonEvent:FireServer()
      task.wait(1)
    end
  end)
end)

Window:Toggle("Auto Sell", {}, function(state)
  task.spawn(function()
    Settings.Sell = state
    while true do
      if not Settings.Sell then return end

      if IsFull() then
        Tycoon.Machines.Seller.ButtonPodium.ButtonEvent:FireServer()
      end

      task.wait(1.5)
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