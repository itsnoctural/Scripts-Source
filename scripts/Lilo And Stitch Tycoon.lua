loadstring(game:HttpGet("https://raw.githubusercontent.com/itsnoctural/Utilities/main/base.lua"))()

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Tycoon = LocalPlayer.tycoonBase.Value

local LastUpdateSpinsTime = os.clock()
local CurrentPrize = nil

getgenv().Settings = {
  Spins = false,
  Buttons = false,
  Rebirth = false,
}

local function FireTouchTransmitter(touchParent)
  local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")

  if Character then
      firetouchinterest(touchParent, Character, 0)
      firetouchinterest(touchParent, Character, 1)
  end
end

task.spawn(function()
  while task.wait(.5) do
    if not Tycoon then
      print("Trying to get...")
      Tycoon = LocalPlayer.tycoonBase.Value
    else return end
  end
end)

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("LAST | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Inf. Spins", {}, function(state)
    task.spawn(function()
        Settings.Spins = state
        while true do
            if not Settings.Spins then return end

            if os.clock() - LastUpdateSpinsTime > 20 then
              ReplicatedStorage.RE.UpdateSpins:FireServer(999);
              LastUpdateSpinsTime = os.clock()
            end

            if not CurrentPrize or CurrentPrize ~= 6 then
              CurrentPrize = ReplicatedStorage.RE.GetSpinPrize:InvokeServer()
            else
              ReplicatedStorage.RE.GiveSpinPrize:FireServer(LocalPlayer)
            end

            task.wait()
        end
    end)
end)

Window:Toggle("Auto Buttons", {}, function(state)
  task.spawn(function()
      Settings.Buttons = state
      while true do
          if not Settings.Buttons then return end

          for _,v in ipairs(Tycoon.Buttons:GetChildren()) do
            if v.Head.Transparency ~= 1 and not v.buttonSettings:FindFirstChild("Product") and not v.buttonSettings:FindFirstChild("gpass") then
              FireTouchTransmitter(v.Head); task.wait()
            end
          end


          task.wait(.25)
      end
  end)
end)

Window:Toggle("Auto Rebirth", {}, function(state)
  task.spawn(function()
      Settings.Rebirth = state
      while true do
          if not Settings.Rebirth then return end

          ReplicatedStorage.remoteEvents.doRebirth:FireServer()
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

LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
    task.wait()
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
end)