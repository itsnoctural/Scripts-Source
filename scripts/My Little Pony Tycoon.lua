-- loadstring(game:HttpGet("https://raw.githubusercontent.com/itsnoctural/Utilities/main/base.lua"))()

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
  Buttons = false,
  Collect = false,
  Click = false,
  Coins = false,
  Rebirth = false,
}

local function FireTouchTransmitter(part)
  if firetouchinterest then
    local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")

    if Character then
        firetouchinterest(part, Character, 0)
        firetouchinterest(part, Character, 1)
    end
  else
    LocalPlayer.Character:PivotTo(part:GetPivot())
  end
end

local function GetTycoon()
  local Object = nil

  for _,v in ipairs(Workspace["Zednov's Tycoon Kit"].Tycoons:GetChildren()) do
    if v.Owner.Value == LocalPlayer then
      Object = v; break
    end
  end

  if not Object then
    for _,v in ipairs(Workspace["Zednov's Tycoon Kit"].Tycoons:GetChildren()) do
      if not v.Owner.Value then
        FireTouchTransmitter(v.Entrance:FindFirstChildOfClass("Model").Head)
        Object = v; break
      end
    end
  end

  return Object
end

local function GetDiamondsLink()
  local Link = nil

  for _,v in ipairs(LocalPlayer.leaderstats:GetChildren()) do
    if string.find(v.Name, "Diamonds") then
      Link = v; break
    end
  end

  return Link
end

local function ConvertFromShort(short)
  local subShort = string.sub(short, 1, -3)

  local numberSub = tonumber(subShort)
  if numberSub then
    if string.find(short, "K") then
      return numberSub * 1000
    elseif string.find(short, "M") then
      return numberSub * 1000000
    end

    return numberSub
  end

  return 0
end

local Tycoon = GetTycoon()
local Diamonds = GetDiamondsLink()
local Clickers = {}

task.spawn(function()
  while task.wait(5) do
    if Settings.Click then
      table.clear(Clickers)

      for _,v in ipairs(Tycoon:GetDescendants()) do
        if v:IsA("ClickDetector") and v.Parent.Name == "ClickPart" then
          table.insert(Clickers, v); task.wait()
        end
      end
    end
  end
end)

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("MLPT | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Buttons", {}, function(state)
  task.spawn(function()
    Settings.Buttons = state
    while true do
      if not Settings.Buttons then return end

      for _,v in ipairs(Tycoon.Buttons:GetChildren()) do
        local Gamepass = v:FindFirstChild("Gamepass")

        if not Gamepass and v.Head.Transparency == 0 and ConvertFromShort(Diamonds.Value) >= v.Price.Value then
          FireTouchTransmitter(v.Head); task.wait()
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

      FireTouchTransmitter(Tycoon.Essentials.Giver)
      task.wait(.75)
    end
  end)
end)

Window:Toggle("Auto Click Droppers", {}, function(state)
  task.spawn(function()
    Settings.Click = state
    while true do
      if not Settings.Click then return end

      for _,v in ipairs(Clickers) do
        fireclickdetector(v); task.wait()
      end

      task.wait(.1)
    end
  end)
end)

Window:Toggle("Auto Coins", {}, function(state)
  task.spawn(function()
    Settings.Coins = state
    while true do
      if not Settings.Coins then return end

      for _,v in ipairs(Workspace.Coins:GetChildren()) do
        FireTouchTransmitter(v.MeshPart); task.wait()
      end

      task.wait(2.5)
    end
  end)
end)

Window:Toggle("Auto Rebirth", {}, function(state)
  task.spawn(function()
    Settings.Rebirth = state
    while true do
      if not Settings.Rebirth then return end

      ReplicatedStorage["RebirthEvent (Don't Move)"]:FireServer(); task.wait(1)
      Tycoon = GetTycoon()

      task.wait(15)
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