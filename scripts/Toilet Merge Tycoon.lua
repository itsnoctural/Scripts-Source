local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Drops = false,
    Deposit = false,
    MaxDroppers = false,
    Merge = false,
    Rate = false,
    Quests = false,

    Delays = {
        Drops = 1,
        Deposit = 1,
        MaxDroppers = 1.75,
        Merge = 3.5,
        Rate = 2.5,
    }
}

local function FireTouchTransmitter(touchParent)
    local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")

    if Character then
        firetouchinterest(touchParent, Character, 0)
        firetouchinterest(touchParent, Character, 1)
    end
end

local function GetTycoon()
    return Workspace.PlayerTycoons:FindFirstChild(LocalPlayer.UserId)
end

local Tycoon = GetTycoon()

task.spawn(function()
    while not Tycoon and task.wait(1) do Tycoon = GetTycoon() end
end)

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("TMT | EsohaSL")
local Delays = Library:CreateWindow("Delay")

Window:Section("esohasl.net")

Window:Toggle("Auto Drops", {}, function(state)
    task.spawn(function()
        Settings.Drops = state
        while true do
            if not Settings.Drops then return end

            for _,v in ipairs(Tycoon.Drops:GetChildren()) do
                v:PivotTo(LocalPlayer.Character:GetPivot()); task.wait()
            end

            task.wait(Settings.Delays.Drops)
        end
    end)
end)

Window:Toggle("Auto Deposit", {}, function(state)
    task.spawn(function()
        Settings.Deposit = state
        while true do
            if not Settings.Deposit then return end

            FireTouchTransmitter(Tycoon.Important.Collector.Collider)
            task.wait(Settings.Delays.Deposit)
        end
    end)
end)

Window:Toggle("Auto Max Droppers", {}, function(state)
    task.spawn(function()
        Settings.MaxDroppers = state
        while true do
            if not Settings.MaxDroppers then return end

            FireTouchTransmitter(Tycoon.Important.Buttons["add max toilet"].Head2)
            task.wait(Settings.Delays.MaxDroppers)
        end
    end)
end)

Window:Toggle("Auto Merge", {}, function(state)
    task.spawn(function()
        Settings.Merge = state
        while true do
            if not Settings.Merge then return end

            FireTouchTransmitter(Tycoon.Important.MERGE.Head2)
            print("merge")
            task.wait(Settings.Delays.Merge)
        end
    end)
end)

Window:Toggle("Auto Sell Rate", {}, function(state)
    task.spawn(function()
        Settings.Rate = state
        while true do
            if not Settings.Rate then return end

            FireTouchTransmitter(Tycoon.Important.Buttons["increase sell rate"].Head2)
            task.wait(Settings.Delays.Rate)
        end
    end)
end)

Window:Toggle("Auto Claim Quests", {}, function(state)
    task.spawn(function()
        Settings.Quests = state
        while true do
            if not Settings.Quests then return end

            for _,v in ipairs(LocalPlayer.PlayerGui.MainUI.guiChallengesMain.ChallengeList:GetChildren()) do
                if v:IsA("Frame") and v.Bar.Fill.Size.X.Scale == 1 then
                    for _, j in ipairs({"Activated", "MouseButton1Click", "MouseButton1Down", "MouseButton1Up", "MouseButton2Click", "MouseButton2Down", "MouseButton2Up"}) do
                        firesignal(v.ClaimButton[j])
                    end
                end
            end

            task.wait(.5)
        end
    end)
end)

Delays:Box('Drops Delay', {}, function(input)
    task.spawn(function()
        Settings.Delays.Drops = tonumber(input)
    end)
end)

Delays:Box('Deposit Delay', {}, function(input)
    task.spawn(function()
        Settings.Delays.Deposit = tonumber(input)
    end)
end)

Delays:Box('Max Droppers Delay', {}, function(input)
    task.spawn(function()
        Settings.Delays.MaxDroppers = tonumber(input)
    end)
end)

Delays:Box('Merge Delay', {}, function(input)
    task.spawn(function()
        Settings.Delays.Merge = tonumber(input)
    end)
end)

Delays:Box('Sell Rate Delay', {}, function(input)
    task.spawn(function()
        Settings.Delays.Rate = tonumber(input)
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
