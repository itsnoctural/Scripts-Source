local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
  Default = false,
}

local function GetNearestHeart()
  local Heart = nil
  local Distance = 999

  for _, v in ipairs(Workspace["_HEARTS"]:GetChildren()) do
      local CurrentDistance = LocalPlayer:DistanceFromCharacter(v:GetPivot().Position)
  
      if Distance > CurrentDistance then
          Distance = CurrentDistance
          Heart = v
      end
  end

  return Heart
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("NN | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Hearts", {}, function(state)
    task.spawn(function()
        Settings.Default = state
        while true do
            if not Settings.Default then return end
            
            local Heart = GetNearestHeart()

            if Heart then
              LocalPlayer.Character:PivotTo(Heart:GetPivot())
            end

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