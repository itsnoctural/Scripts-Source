loadstring(game:HttpGet("https://raw.githubusercontent.com/itsnoctural/Utilities/main/base.lua"))()

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
  Take = false,
  Dupe = 1000,
  Buttons = false,
  Rebirth = false,
}

local Restaurant = Workspace.Restaurants[LocalPlayer.Name]

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("PT2 | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Take Cash", {}, function(state)
  task.spawn(function()
    Settings.Take = state
    while true do
      if not Settings.Take then return end

      for _,v in ipairs(Restaurant.Addments.Chairs:GetChildren()) do
        if v.Money.Value > 0 then
          LocalPlayer.Character:PivotTo(v.Cash:GetPivot() * CFrame.new(0, 5, 0))
          ReplicatedStorage.Remotes.Clients:FireServer("Money", v, Settings.Dupe); task.wait(.25)
          fireproximityprompt(v.Cash.ProximityPrompt)
        end
      end

      task.wait(1)
    end
  end)
end)

Window:Box("Dupe Cash on Take", {}, function(input)
  task.spawn(function()
    Settings.Dupe = tonumber(input)
  end)
end)

Window:Toggle("Auto Buttons", {}, function(state)
  task.spawn(function()
    Settings.Buttons = state
    while true do
      if not Settings.Buttons then return end

      for _,v in ipairs(Restaurant.Addments.Buttons:GetChildren()) do
        local Price = v:FindFirstChild("Price")
        local Rebirths = v:FindFirstChild("Rebirths")

        if Rebirths and Rebirths.Value > LocalPlayer.leaderstats.Rebirths.Value then continue end

        if Price and Price.Value <= LocalPlayer.leaderstats.Money.Value then
          ReplicatedStorage.Remotes.MainRemote:FireServer("SetButton", v); task.wait()
        end
      end

      task.wait(1)
    end
  end)
end)

Window:Toggle("Auto Rebirth", {}, function(state)
  task.spawn(function()
    Settings.Rebirth = state
    while true do
      if not Settings.Rebirth then return end

      ReplicatedStorage.Remotes.Rebirth:FireServer()
      task.wait(10)
    end
  end)
end)

Window:Button("Redeem Codes", function()
  task.spawn(function()
    for _,v in ipairs(ReplicatedStorage.Codes:GetChildren()) do
      ReplicatedStorage.Remotes.Codes:FireServer(v.Name); task.wait(.25)
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