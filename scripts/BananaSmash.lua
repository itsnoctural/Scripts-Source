loadstring(game:HttpGet("https://raw.githubusercontent.com/itsnoctural/Utilities/main/base.lua"))()

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
  Click = false,
  Drops = false,
  Comet = false,
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("BS | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Click", {}, function(state)
  task.spawn(function()
      Settings.Click = state
      while true do
          if not Settings.Click then return end

          firesignal(LocalPlayer.PlayerGui.Interface["pack-buttons"].BananaClick.MouseButton1Click)
          task.wait(.2)
      end
  end)
end)

Window:Toggle("Auto Drops", {}, function(state)
    task.spawn(function()
        Settings.Drops = state
        while true do
            if not Settings.Drops then return end

            for _,v in ipairs(Workspace.Instanced.Drops:GetChildren()) do
              if v:FindFirstChild("Collision") then
                v:PivotTo(LocalPlayer.Character:GetPivot()); task.wait(.1)
              end
            end

            task.wait(1)
        end
    end)
end)

Window:Toggle("Auto Comet", {}, function(state)
  task.spawn(function()
      Settings.Comet = state
      while true do
          if not Settings.Comet then return end

          ReplicatedStorage.Events.Game["Banana Comet"].Event:FireServer(tick());
          task.wait(.25)
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

-- LocalPlayer.Idled:Connect(function()
--     VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
--     task.wait()
--     VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
-- end)

