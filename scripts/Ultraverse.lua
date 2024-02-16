local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Scavenger = false,
    Points = false,
}

local function FireTouchTransmitter(touchParent)
    local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")

    if Character then
        firetouchinterest(touchParent, Character, 0)
        firetouchinterest(touchParent, Character, 1)
    end
end

local SleighRide = Workspace["Sleigh Ride"]

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("Ultrs | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Scavenger Hunt", {}, function(state)
    task.spawn(function()
        Settings.Scavenger = state
        while true do
            if not Settings.Scavenger then return end

            local TutorialToken = Workspace.Tokens:FindFirstChild("TutorialToken")

            if TutorialToken then
                FireTouchTransmitter(TutorialToken.TutorialToken);
            end

            for _, v in ipairs(Workspace.TokensSpawnLocations:GetDescendants()) do
                if v.Name == "collision" then
                    FireTouchTransmitter(v); task.wait(.25)
                end
            end

            task.wait(1)
        end
    end)
end)

Window:Toggle("Auto Points", {}, function(state)
    task.spawn(function()
        Settings.Points = state
        while true do
            if not Settings.Points then return end

            LocalPlayer.Character:PivotTo(SleighRide.Objects.FinishLineTrigger:GetPivot()); task.wait(2.5)

            for _, v in ipairs(SleighRide.Points:GetChildren()) do
                LocalPlayer.Character:PivotTo(v:GetPivot()); task.wait(1)
            end

            for i = 1, #SleighRide.CheckPoints:GetChildren() do
                LocalPlayer.Character:PivotTo(SleighRide.CheckPoints["checkpoint" .. i]:GetPivot() * CFrame.Angles(0, 0, math.rad(-90))); task.wait(10)
            end

            LocalPlayer.Character:PivotTo(SleighRide.Objects.FinishLineTrigger:GetPivot());

            task.wait(1)
        end
    end)
end)

Window:Section("Anti-AFK - Enabled")

Window:Button("YouTube: EsohaSL", function()
    task.spawn(function()
        if setclipboard then
            setclipboard("https://youtube.com/@esohasl")
        end
    end)
end)

LocalPlayer.Idled:connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
    task.wait()
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
end)