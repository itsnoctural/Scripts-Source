-- loadstring(game:HttpGet("https://raw.githubusercontent.com/itsnoctural/Utilities/main/base.lua"))()

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
  Default = false,
}

local function FireTouchTransmitter(touchParent)
  local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")

  if Character then
      firetouchinterest(touchParent, Character, 0)
      firetouchinterest(touchParent, Character, 1)
  end
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("AJH | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Find Items", {}, function(state)
  task.spawn(function()
    Settings.Default = state
    while true do
      if not Settings.Default then return end

      for _,v in ipairs(Workspace.World.ScavengerHunts:GetChildren()) do
        for _,z in ipairs(v:GetChildren()) do
          FireTouchTransmitter(z:FindFirstChildOfClass("Part")); task.wait()
        end
      end

      task.wait(.5)
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