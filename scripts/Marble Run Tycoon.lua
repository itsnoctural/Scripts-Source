loadstring(game:HttpGet("https://raw.githubusercontent.com/itsnoctural/Utilities/main/base.lua"))()

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Tycoon = Workspace[LocalPlayer.Name .. "_tycoon"]

getgenv().Settings = {
  Buttons = false,
  Collect = false,
  Rebirth = false,
  Daily = false,
}

local function FireTouchTransmitter(touchParent)
  local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")

  if Character then
      firetouchinterest(touchParent, Character, 0)
      firetouchinterest(touchParent, Character, 1)
  end
end

local function GetDropperButton()
  local Button = nil

  for _,floor in ipairs(Tycoon.Buttons:GetChildren()) do
    for _,v in ipairs(floor:GetChildren()) do
      if not v:FindFirstChild("ProductId") and string.find(v.Name, "Dropper") and v.BillboardGui.Enabled then
        Button = v; break
      end
    end
  end

  return Button
end

local function GetVCash()
  return tonumber(LocalPlayer.leaderstats.Cash.V.Value)
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("MRT2 | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Buttons", {}, function(state)
    task.spawn(function()
        Settings.Buttons = state
        while true do
            if not Settings.Buttons then return end

            local Button = GetDropperButton()

            if Button then
              print(Button)
              print(Button.Parent)
              if GetVCash() >= Button.Cost.Value then
                FireTouchTransmitter(Button.TouchPart)
              end
            else
              for _,floor in ipairs(Tycoon.Buttons:GetChildren()) do
                for _,v in ipairs(floor:GetChildren()) do
                  if not v:FindFirstChild("ProductId") and GetVCash() >= v.Cost.Value then
                    FireTouchTransmitter(v.TouchPart); task.wait()
                  end
                end
              end
            end

            task.wait(.75)
        end
    end)
end)

Window:Section("Droppers is prioritized.")

Window:Toggle("Auto Collect", {}, function(state)
  task.spawn(function()
      Settings.Collect = state
      while true do
          if not Settings.Collect then return end

          FireTouchTransmitter(Tycoon.Models.Collector.Collector.CollectPart)
          task.wait(.5)
      end
  end)
end)

Window:Toggle("Auto Rebirth", {}, function(state)
  task.spawn(function()
      Settings.Rebirth = state
      while true do
          if not Settings.Rebirth then return end

          ReplicatedStorage.Remotes["Client > Server"].Rebirth:InvokeServer()
          task.wait(10)
      end
  end)
end)

Window:Toggle("Auto Claim Daily", {}, function(state)
  task.spawn(function()
      Settings.Daily = state
      while true do
          if not Settings.Daily then return end

          for i = 1, 12 do
            ReplicatedStorage.Remotes.ClaimDailyReward:FireServer(i); task.wait(.25)
          end

          task.wait(60)
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