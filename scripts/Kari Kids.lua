local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
  Coins = false,
}

local function FireTouchTransmitter(part)
  if firetouchinterest then
    local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")

    if Character then
        firetouchinterest(part, Character, 0)
        firetouchinterest(part, Character, 1)
    end
  else
    LocalPlayer.Character:PivotTo(part:GetPivot())
  end
end

local function GetAllCoins()
  local Coins = {}

  for _,v in ipairs(Workspace:GetChildren()) do
    if string.find(v.Name, "Landscape_") and v:FindFirstChild("Coins") then
      for _, coin in ipairs(v.Coins:GetChildren()) do table.insert(Coins, coin); end
    end
  end

  return Coins
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("VK | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Coins", {}, function(state)
  task.spawn(function()
      Settings.Coins = state
      while true do
          if not Settings.Coins then return end

          for _,v in ipairs(GetAllCoins()) do
            if v:FindFirstChild("Coin") and v.Coin.Transparency == 0 then
              print(v)
              FireTouchTransmitter(v.Coin.Hitbox); task.wait()
            end
          end

          task.wait(1)
      end
  end)
end)

Window:Toggle("Auto Spin", {}, function(state)
  task.spawn(function()
      Settings.Spin = state
      while true do
          if not Settings.Spin then return end

          ReplicatedStorage.Events.Badges.ObbyCompleted:FireServer()
          ReplicatedStorage.Events.Badges.QuestsCompleted:FireServer()

          ReplicatedStorage.RequestSpin:FireServer(Workspace.Karusha_Stand_1.KolesoFortuny) 
          task.wait(.2)
      end
  end)
end)

Window:Button("Finish Obby", function()
  task.spawn(function()
      if Workspace:FindFirstChild("Finish") then
        LocalPlayer.Character:PivotTo(Workspace.Finish:GetPivot())
      end
  end)
end)

Window:Slider("Walk Speed", {min = 16, max = 100}, function(v)
  task.spawn(function()
      local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

      if Humanoid then
          Humanoid.WalkSpeed = v
      end
  end)
end)

Window:Slider("Jump Power", {min = 50, max = 200}, function(v)
  task.spawn(function()
      local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

      if Humanoid then
          Humanoid.JumpPower = v
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