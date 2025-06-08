loadstring(game:HttpGet("https://raw.githubusercontent.com/itsnoctural/Utilities/main/base.lua"))()

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
  Wins = false,
  Click = false,
  Rebirth = false,
  Eggs = {
    Enabled = false,
    Select = nil
  }
}

local function GetLatestRace()
  local Race = {
    Number = 0,
    Link = nil,
  }

  for _,v in ipairs(Workspace.Environment:GetChildren()) do
    for _,j in ipairs(v:GetChildren()) do
      local Name = j.Name
      local Number = tonumber(Name)

      if Name ~= "0" and Number > Race.Number then
        Race = {
          Number = Number,
          Link = j,
        }
      end
    end
  end

  return Race.Link:FindFirstChild(Race.Number)
end

local function FireTouchTransmitter(touchParent)
	local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")

	if Character then
			firetouchinterest(touchParent, Character, 0)
			firetouchinterest(touchParent, Character, 1)
	end
end

local function GetAllEggs()
  local Eggs = {}

  for _,v in ipairs(ReplicatedStorage.Eggs:GetChildren()) do
    table.insert(Eggs, v.Name)
  end

  table.sort(Eggs)

  return Eggs
end

local LatestRace = GetLatestRace()

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("MR | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Wins", {}, function(state)
    task.spawn(function()
        Settings.Wins = state
        while true do
            if not Settings.Wins then return end

            if ReplicatedStorage.RoundRunning.Value == 1 then
              LocalPlayer.Character:PivotTo(LatestRace:GetPivot())
            end

            task.wait(.25)
        end
    end)
end)

task.spawn(function()
  while task.wait(1) do
    if Settings.Wins then
      FireTouchTransmitter(Workspace.Interactive.Starter);
    end
  end
end)

Window:Toggle("Auto Click", {}, function(state)
  task.spawn(function()
      Settings.Click = state
      while true do
          if not Settings.Click then return end

          if ReplicatedStorage.RoundRunning.Value == 0.5 then
            ReplicatedStorage.Remotes.PlayerClicking:FireServer()
          end

          task.wait()
      end
  end)
end)

Window:Toggle("Auto Rebirth", {}, function(state)
  task.spawn(function()
      Settings.Rebirth = state
      while true do
          if not Settings.Rebirth then return end

          ReplicatedStorage.Remotes.Rebby:InvokeServer(true)
          task.wait(1.75)
      end
  end)
end)

Window:Toggle("Auto Eggs", {}, function(state)
  task.spawn(function()
      Settings.Eggs.Enabled = state
      while true do
          if not Settings.Eggs.Enabled then return end

          ReplicatedStorage.Remotes.EggOpened:InvokeServer(Settings.Eggs.Select, "Single")
          task.wait(.25)
      end
  end)
end)

Window:Dropdown("Eggs", {list =  GetAllEggs()}, function(value)
  task.spawn(function()
      Settings.Eggs.Select = value
  end)
end)

Window:Button("Teleport to Selected Egg", function()
  task.spawn(function()
    for _,v in ipairs(Workspace:GetChildren()) do
      local Eggs = v:FindFirstChild("Eggs")

      if Eggs and Eggs:FindFirstChild(Settings.Eggs.Select) then
        LocalPlayer.Character:PivotTo(Eggs[Settings.Eggs.Select].Egg:GetPivot())
      end
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