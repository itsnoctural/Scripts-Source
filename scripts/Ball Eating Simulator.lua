loadstring(game:HttpGet("https://raw.githubusercontent.com/itsnoctural/Utilities/main/base.lua"))()

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
  Default = false,
  Speed = false,
  Walk = 31,
}

local function GetNearestFood()
  local Nearest = nil
  local StartDist = 500

  for _, v in ipairs(Workspace.Game.Food:GetChildren()) do
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
local Window = Library:CreateWindow("BES | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Food", {}, function(state)
    task.spawn(function()
        Settings.Default = state
        while true do
            if not Settings.Default then return end

            for _,v in ipairs(Workspace.Game.Food:GetChildren()) do
              ReplicatedStorage.Remotes.Eat:FireServer({GetNearestFood()}); task.wait()
            end 

            task.wait(.25)
        end
    end)
end)

Window:Toggle("Enable Walk Speed", {}, function(state)
  task.spawn(function()
      Settings.Speed = state
      while true do
        if not Settings.Speed then return end

        local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

        if Humanoid then
          Humanoid.WalkSpeed = Settings.Walk
        end

        task.wait()
      end
  end)
end)

Window:Box('Speed (Default 31)', {}, function(input)
  task.spawn(function()
    Settings.Walk = tonumber(input)
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