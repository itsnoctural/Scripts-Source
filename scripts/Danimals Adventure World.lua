-- loadstring(game:HttpGet("https://raw.githubusercontent.com/itsnoctural/Utilities/main/base.lua"))()

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer

local DoneFolder = Instance.new("Folder", Workspace)
DoneFolder.Name = game:GetService("HttpService"):GenerateGUID(false)

getgenv().Settings = {
  Default = false,
  Headphones = false,
}

-- local function GetNodes()
--   local Nodes = {}

--   for _, v in ipairs(Workspace.Spawnables:GetChildren()) do
--     table.insert(Nodes, {
--       Node = v,
--       Distance = LocalPlayer:DistanceFromCharacter(v:GetPivot().Position)
--     })
--   end

--   table.sort(Nodes, function(a, b)
--     return a.Distance < b.Distance
--   end)

--   return Nodes
-- end

local function GetNearestNode()
  local Nearest = nil
  local StartDist = 999

  for _, v in ipairs(Workspace.Spawnables:GetChildren()) do
    local Distance = LocalPlayer:DistanceFromCharacter(v:GetPivot().Position)

    if StartDist > Distance then
        StartDist = Distance
        Nearest = v
    end
  end

  if Nearest then
    Nearest.Parent = DoneFolder
    task.delay(30, function()
      print("Returting..")
      Nearest.Parent = Workspace.Spawnables
    end)
  end

  return Nearest
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("DAW | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Farm Lvl", {}, function(state)
  task.spawn(function()
    Settings.Default = state
    while true do
      if not Settings.Default then return end

      local Node = GetNearestNode()

      if Node then
        -- LocalPlayer.Character:PivotTo(LocalPlayer.Character:GetPivot():Lerp(Node:GetPivot(), 0.5))
        LocalPlayer.Character:PivotTo(Node:GetPivot())
      end

      task.wait(.05)
    end
  end)
end)

Window:Toggle("Auto Headphones", {}, function(state)
  task.spawn(function()
    Settings.Headphones = state
    while true do
      if not Settings.Headphones then return end

      for _,v in ipairs(Workspace.EasterEggs:GetChildren()) do
        if not Settings.Headphones then break end
        LocalPlayer.Character:PivotTo(v:GetPivot()); task.wait(2.5)
      end

      task.wait(1)
    end
  end)
end)

Window:Button("Teleport to Yogurt World", function()
  task.spawn(function()
    TeleportService:Teleport(116628219162552)
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