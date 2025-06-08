local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Wins = false,
    Cash = false,
}

local function FireTouchTransmitter(touchParent)
    local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")

    if Character then
        if firetouchinterest then
            firetouchinterest(touchParent, Character, 0)
            firetouchinterest(touchParent, Character, 1)
        else
            Character:PivotTo(touchParent:GetPivot())
        end
    end
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("ISG | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Wins", {}, function(state)
    task.spawn(function()
        Settings.Wins = state
        while true do
            if not Settings.Wins then return end

            FireTouchTransmitter(Workspace.Finish.Chest); task.wait(.25)
        end
    end)
end)

Window:Button("Show Path", function()
    task.spawn(function()
        for _,segment in ipairs(Workspace.segmentSystem.Segments:GetChildren()) do
            for _,v in ipairs(segment.Folder:GetChildren()) do
                v.Color = v:FindFirstChild("breakable") and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0)
            end
        end
    end)
end)

Window:Toggle("Inf. Cash", {}, function(state)
    task.spawn(function()
        Settings.Cash = state
        while true do
            if not Settings.Cash then return end

            ReplicatedStorage.RemoteEvents.crateRemote:FireServer("processCrate", 3)
            ReplicatedStorage.RemoteEvents.crateRemote:FireServer("processReward", 3)

            task.wait()
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