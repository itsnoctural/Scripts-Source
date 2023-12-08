local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Notes = false,
    Hearts = false,
    HeartsLegacy = false,
}

local function FireTouchTransmitter(touchParent)
    local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")

    if Character then
        firetouchinterest(touchParent, Character, 0)
        firetouchinterest(touchParent, Character, 1)
    end
end

local Soundwaves = Workspace:FindFirstChild("Soundwaves")
local LevelSections = Workspace:FindFirstChild("LevelSections")

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("SI | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Notes and Bubbles", {}, function(state)
    task.spawn(function()
        Settings.Notes = state
        while true do
            if not Settings.Notes then return end

            if Soundwaves then
                for _, v in ipairs(Soundwaves["Coins - SyncAssisted"]:GetChildren()) do
                    FireTouchTransmitter(v); task.wait()
                end
            end

            task.wait(.25)
        end
    end)
end)

Window:Toggle("Auto Hearts", {}, function(state)
    task.spawn(function()
        Settings.Hearts = state
        while true do
            if not Settings.Hearts then return end

            if LevelSections then
                for _, v in ipairs(LevelSections.Coins:GetDescendants()) do
                    if v:IsA("Part") then
                        FireTouchTransmitter(v); task.wait()
                    end
                end
            end

            task.wait(.5)
        end
    end)
end)

Window:Toggle("Auto Hearts [Teleport]", {}, function(state)
    task.spawn(function()
        Settings.HeartsLegacy = state
        while true do
            if not Settings.HeartsLegacy then return end

            if LevelSections then
                for _, v in ipairs(LevelSections.Coins:GetDescendants()) do
                    if v:IsA("Part") then
                        LocalPlayer.Character:PivotTo(v:GetPivot()); task.wait(.1)
                    end
                end
            end

            task.wait(2.5)
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