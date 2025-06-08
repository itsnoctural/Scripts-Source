local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

local Services = ReplicatedStorage.Packages.Knit.Services
local HatchimalsGui = LocalPlayer.PlayerGui.HatchimalsGui.Background

getgenv().Settings = {
    Play = false,
    Milk = false,
    Tub = false,
}

local function GetPlot()
    for _,v in ipairs(Workspace.Plots:GetChildren()) do
        if v:GetAttribute("Owner") == LocalPlayer.UserId then
            return v
        end
    end

    return nil
end

local function GetBaby()
    for _,v in ipairs(Workspace.Baby:GetChildren()) do
        if v:FindFirstChild("Target") and v.Target.Value == LocalPlayer.Character then
            return v
        end
    end

    return nil
end

local UserPlot = GetPlot()

local function FeedMilk()
    if not UserPlot then UserPlot = GetPlot(); end
    fireclickdetector(UserPlot.House.Interior.Model.MilkGiver.ClickDetector); task.wait(3.25)

    Services.ActivityService.RE.StartActivity:FireServer("FeedMilk", { LocalPlayer.Character, GetBaby() })
end

local function TakeTub()
    if not UserPlot then UserPlot = GetPlot(); end
    Services.ActivityService.RE.StartActivity:FireServer(UserPlot.House.Interior.Model.Tub1.ProximityPrompt, { LocalPlayer.Character, GetBaby() })
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/artemy133563/Utilities/refs/heads/main/wally", true))()
local Window = Library:CreateWindow("Connect Hub")

Window:Toggle("Auto Quest 1 & 3", {}, function(state)
    task.spawn(function()
        Settings.Play = state
        while true do
            if not Settings.Play then return end

            Services.HatchimalsQuestService.RE.StartQuest:FireServer()
            task.wait(1)
            Services.HatchimalsQuestService.RE.CompletePersonalityTest:FireServer("Snowy")
            Services.HatchimalsQuestService.RE.SpawnHatchimal:FireServer()

            if HatchimalsGui.Quest1.Status.Text ~= "15/15" then
                LocalPlayer.Character:PivotTo(Workspace.Playground.Swings.Swing:GetPivot())

                for i = 1, 5 do
                    for _,v in ipairs(Workspace.Playground.Swings:GetChildren()) do
                        if v:IsA("Model") then
                            for _,z in ipairs(v:GetDescendants()) do
                                if z:IsA("Seat") then
                                    fireproximityprompt(z.ProximityPrompt) task.wait(.1)
                                end
                            end
                        end
                    end
                    task.wait(.2)
                end
            end

            if HatchimalsGui.Quest3.Status.Text ~= "1/1" then HatchimalsQuestService.RE.EnterFunhouse:FireServer() end

            task.wait(1)
        end       
    end)
end)

Window:Section("Claim House before ")

Window:Toggle("Auto Feed Milk", {}, function(state)
    task.spawn(function()
        Settings.Milk = state
        while true do
            if not Settings.Milk then return end

            FeedMilk(); task.wait(.35)
        end       
    end)
end)

Window:Toggle("Auto Tub", {}, function(state)
  task.spawn(function()
      Settings.Tub = state
      while true do
          if not Settings.Tub then return end

          TakeTub(); task.wait(.5)
      end       
  end)
end)

task.spawn(function()
  while task.wait(.05) do
    if Settings.Milk or Settings.Tub then
      Services.ActivityService.RE.FinishActivity:FireServer()
    end
  end
end)


for _,v in ipairs({81398944312735, 85542509985196}) do
    game["ReplicatedStorage"].BloxbizRemotes.CatalogOnPromptPurchase:InvokeServer(v); task.wait(2.5)
end