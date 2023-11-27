local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Collect = false,
    Deposit = false,
    Rate = false,
    Bees = false,
    Merge = false,
    Obby = false,
}

local function FireTouchTransmitter(touchParent)
    local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")

    if Character then
        firetouchinterest(touchParent, Character, 0)
        firetouchinterest(touchParent, Character, 1)
    end
end

local function GetTycoon()
    return Workspace.Tycoons[LocalPlayer.Name]
end

local Tycoon = GetTycoon()

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("BF | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Auto Collect", {}, function(state)
    task.spawn(function()
        Settings.Collect = state
        while true do
            if not Settings.Collect then return end

            for _, v in ipairs(Tycoon.Honey:GetChildren()) do
                v:PivotTo(LocalPlayer.Character:GetPivot()); task.wait()
            end

            task.wait(.25)
        end
    end)
end)

Window:Toggle("Auto Deposit", {}, function(state)
    task.spawn(function()
        Settings.Deposit = state
        while true do
            if not Settings.Deposit then return end

            ReplicatedStorage.Events.RemoteEvents.Sell:FireServer()
            task.wait(1)
        end
    end)
end)

Window:Toggle("Auto Buy Bees", {}, function(state)
    task.spawn(function()
        Settings.Bees = state
        while true do
            if not Settings.Bees then return end

            FireTouchTransmitter(Tycoon.Buttons["Purchase_Bee"])
            task.wait(.1)
        end
    end)
end)

Window:Toggle("Auto Buy Rate", {}, function(state)
    task.spawn(function()
        Settings.Rate = state
        while true do
            if not Settings.Rate then return end

            FireTouchTransmitter(Tycoon.Buttons["Faster_Button"])
            task.wait(.25)
        end
    end)
end)

Window:Toggle("Auto Merge", {}, function(state)
    task.spawn(function()
        Settings.Merge = state
        while true do
            if not Settings.Merge then return end

            FireTouchTransmitter(Tycoon.Buttons.MergeBees)
            task.wait(.65)
        end
    end)
end)

Window:Toggle("Auto Obby", {}, function(state)
    task.spawn(function()
        Settings.Obby = state
        while true do
            if not Settings.Obby then return end

            FireTouchTransmitter(Workspace.Obbies.Winter["Teleport_Touch"]); task.wait(.75)

            local Lever = Workspace.Obbies.Winter["Special_Task"].Lever
            LocalPlayer.Character:PivotTo(Lever:GetPivot()); task.wait(.5)

            fireproximityprompt(Lever.ProximityPrompt); task.wait(.65)
            FireTouchTransmitter(Workspace.Obbies.Winter["End_Obby"])

            task.wait(62)
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

LocalPlayer.Idled:connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
    task.wait()
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
end)