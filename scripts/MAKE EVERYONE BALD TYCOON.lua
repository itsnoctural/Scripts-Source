loadstring(game:HttpGet("https://raw.githubusercontent.com/itsnoctural/Utilities/main/base.lua"))()

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Tycoon = Workspace.TycoonSystem.Tycoons[LocalPlayer.PlotNumber.Value]

getgenv().Settings = {
  Farm = false,

  Items = false,
  Stock = false,
  Upgrade = false,
  Collect = false,
  Buttons = false,
}

local function AutoItems()
  for _, v in ipairs(CollectionService:GetTagged("Collectible")) do
    v:PivotTo(LocalPlayer.Character:GetPivot()); task.wait()
  end
end

local function FindAndFire(Name, IsA, Distance)
  for _, v in ipairs(Tycoon:GetDescendants()) do
    if v.Name == Name and v:IsA(IsA) then
      if LocalPlayer:DistanceFromCharacter(v.Position) > Distance then
        LocalPlayer.Character:PivotTo(v:GetPivot()); task.wait(.15)
      end

      fireproximityprompt(v.ProximityPrompt); task.wait()
    end
  end
end

local function AutoUpgrade()
  for _, v in ipairs(Tycoon:GetDescendants()) do
    if v.Name == "UpgradePrompt" and v:IsA("Part") then
      local MaxLevel = v.Parent.MaxUpgradeLevel.Value
      local Level = v.Parent.Parent.Stats.DropperLevel.Value

      if Level < MaxLevel then
        if LocalPlayer:DistanceFromCharacter(v.Position) > 10 then
          LocalPlayer.Character:PivotTo(v:GetPivot()); task.wait(.15)
        end

        fireproximityprompt(v.ProximityPrompt)
      end
    end
  end
end

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

local function AutoButtons()
  for _,v in ipairs(Tycoon.Purchaseables:GetChildren()) do
    local Button = v:FindFirstChild("Button")

    if Button then
      FireTouchTransmitter(Button)
    end
  end
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("MEBT | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Farm", {}, function(state)
  task.spawn(function()
    Settings.Items = state
    while true do
      if not Settings.Items then return end

      if Settings.Items then AutoItems(); task.wait(.1) end
      if Settings.Stock then FindAndFire("DepositItems", "Part", 5); task.wait(.25) end
      if Settings.Collect then FindAndFire("CollectButton", "MeshPart", 10); task.wait(.1) end
      if Settings.Upgrade then AutoUpgrade() end
      if Settings.Buttons then AutoButtons() end

      task.wait(.1)
    end
  end)
end)

Window:Section("Config")

Window:Toggle("Auto Items", {}, function(state)
  task.spawn(function()
    Settings.Items = state
  end)
end)

Window:Toggle("Auto Stock", {}, function(state)
  task.spawn(function()
    Settings.Stock = state
  end)
end)

Window:Toggle("Auto Collect Cash", {}, function(state)
  task.spawn(function()
    Settings.Collect = state
  end)
end)

Window:Toggle("Auto Upgrade", {}, function(state)
  task.spawn(function()
    Settings.Upgrade = state
  end)
end)

Window:Toggle("Auto Buttons", {}, function(state)
  task.spawn(function()
    Settings.Buttons = state
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