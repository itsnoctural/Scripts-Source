loadstring(game:HttpGet("https://raw.githubusercontent.com/itsnoctural/Utilities/main/base.lua"))()

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
  Plushies = false,
  Type = 'walk',
  Sell = false,
}

local function GetNearest()
  local Nearest = nil
  local StartDist = 100

  for _, v in ipairs(Workspace.Plushies:GetChildren()) do
      local Distance = LocalPlayer:DistanceFromCharacter(v:GetPivot().Position)
  
      if Distance < StartDist then
          StartDist = Distance
          Nearest = v
      end
  end

  return Nearest
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("CP | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Plushies", {}, function(state)
    task.spawn(function()
        Settings.Plushies = state
        while true do
            if not Settings.Plushies then return end

            if Settings.Type == "bring" then
              for _,v in ipairs(Workspace.Plushies:GetChildren()) do
                v:PivotTo(LocalPlayer.Character:GetPivot()); task.wait()
              end
            else
              local Plushy = GetNearest()

              if Plushy then
                LocalPlayer.Character.Humanoid:MoveTo(Plushy:GetPivot().Position)
                LocalPlayer.Character.Humanoid.MoveToFinished:Wait()
              end
            end

            task.wait(.1)
        end
    end)
end)

Window:Dropdown("Type", {list = {"walk", "bring"}}, function(var)
  task.spawn(function()
      Settings.Type = var
  end)
end)

Window:Toggle("Auto Sell", {}, function(state)
  task.spawn(function()
      Settings.Sell = state
      while true do
          if not Settings.Sell then return end

          local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")
          firetouchinterest(Workspace.Sell, Character, 0)
          firetouchinterest(Workspace.Sell, Character, 1)

          task.wait()
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