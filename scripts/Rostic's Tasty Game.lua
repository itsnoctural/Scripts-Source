local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local LatencyPresets = {
  ["Slow"] = 0.3,
  ["Medium"] = 0.1,
  ["Fast"] = 0,
}

getgenv().Settings = {
  Food = false,
  Boosters = false,
  Latency = 0.3,
}

local function FireTouchTransmitter(part)
  local Hitbox = Workspace.Players:FindFirstChild(LocalPlayer.Name)

  if Hitbox then
    firetouchinterest(part, Hitbox.Player.Cell, 0)
    firetouchinterest(part, Hitbox.Player.Cell, 1)
  end
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("R:TG | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Food", {}, function(state)
    task.spawn(function()
        Settings.Food = state
        while true do
            if not Settings.Food then return end

            for _,v in ipairs(Workspace.Food:GetChildren()) do
              FireTouchTransmitter(v)
              task.wait(Settings.Latency)
            end

            task.wait(.25)
        end
    end)
end)

Window:Toggle("Auto Boosters", {}, function(state)
  task.spawn(function()
      Settings.Boosters = state
      while true do
          if not Settings.Boosters then return end

          for _,v in ipairs(Workspace.Boosters:GetChildren()) do
            FireTouchTransmitter(v)
            task.wait(Settings.Latency)
          end

          task.wait(.5)
      end
  end)
end)

Window:Section("Settings")

Window:Dropdown("Speed", {list = {"Slow", "Medium", "Fast"}}, function(value)
  task.spawn(function()
      Settings.Latency = LatencyPresets[value]
  end)
end)

Window:Button("YouTube: EsohaSL", function()
    task.spawn(function()
        if setclipboard then
            setclipboard("https://youtube.com/@esohasl")
        end
    end)
end)