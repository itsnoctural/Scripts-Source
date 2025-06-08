loadstring(game:HttpGet("https://raw.githubusercontent.com/itsnoctural/Utilities/main/base.lua"))()

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
  Merge = false,
  Click = false,
  Eggs = {
    Enabled = false,
    Value = "Basic"
  },
  Rebirth = false,
  Rain = false,
}

local Blocks = Workspace[LocalPlayer.Name .. "Blocks"]

local function GetBestBlock()
  local Block = 1

  for _,v in ipairs(Blocks:GetChildren()) do
    if tonumber(v.Name) > Block then
      Block = tonumber(v.Name)
    end
  end

  return Block
end

local function GetEggs()
  local Eggs = {}

  for _,v in ipairs(Workspace.Eggs:GetChildren()) do
    if not table.find(Eggs, v.Name) then
      table.insert(Eggs, v.Name)
    end
  end

  return Eggs
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("MfD | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Merge", {}, function(state)
  task.spawn(function()
    Settings.Merge = state
    while true do
        if not Settings.Merge then return end

        for _,v in ipairs(Blocks:GetChildren()) do
          for _,z in ipairs(Blocks:GetChildren()) do
            if v.Name == z.Name then
              v:PivotTo(z:GetPivot()); task.wait()
              break
            end
          end
        end

        task.wait(.25)
    end
  end)
end)

Window:Toggle("Auto Click", {}, function(state)
  task.spawn(function()
    Settings.Click = state
    while true do
      if not Settings.Click then return end

      ReplicatedStorage.Remotes.GiveCashEvent:FireServer(Blocks[GetBestBlock()])
      task.wait()
    end
  end)
end)

Window:Dropdown("Eggs", {list =  GetEggs()}, function(var)
  task.spawn(function()
      Settings.Eggs.Value = var
  end)
end)

Window:Toggle("Auto Eggs", {}, function(state)
  task.spawn(function()
    Settings.Eggs.Enabled = state
    while true do
      if not Settings.Eggs.Enabled then return end

      ReplicatedStorage.EggHatchingRemotes.HatchServer:InvokeServer(Workspace.Eggs[Settings.Eggs.Value])
      task.wait(.25)
    end
  end)
end)

Window:Toggle("Auto Rebirth", {}, function(state)
  task.spawn(function()
    Settings.Rebirth = state
    while true do
      if not Settings.Rebirth then return end

      ReplicatedStorage.Remotes.RebirthConfirmEvent:FireServer(0, 0, 0)
      task.wait(1)
    end
  end)
end)

Window:Toggle("Auto Rain Event", {}, function(state)
  task.spawn(function()
    Settings.Rain = state
    while true do
      if not Settings.Rain then return end

      ReplicatedStorage.Remotes.RainEvent:FireServer()
      task.wait(.2)
    end
  end)
end)

Window:Box("Give Gems", {}, function(input)
  task.spawn(function()
      ReplicatedStorage.Remotes.GemEvent:FireServer(tonumber(input))
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