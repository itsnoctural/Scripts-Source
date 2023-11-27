local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Tycoon = LocalPlayer.Tycoon.Value

getgenv().Settings = {
    Collect = false,
    Buttons = false,
}

local function FireTouchTransmitter(touchParent)
    local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")

    if Character and touchParent then
        firetouchinterest(touchParent, Character, 0)
        firetouchinterest(touchParent, Character, 1)
    end
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("NT | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Auto Collect", {}, function(state)
    task.spawn(function()
        Settings.Collect = state
        while true do
            if not Settings.Collect then return end

            FireTouchTransmitter(Tycoon.Essentials.CurrencyCollector.Giver)
            task.wait(.75)
        end
    end)
end)

Window:Toggle("Auto Buttons", {}, function(state)
    task.spawn(function()
        Settings.Buttons = state
        while true do
            if not Settings.Buttons then return end

            for _, v in ipairs(Tycoon.Buttons:GetChildren()) do
                local CurrencyFolder = v:FindFirstChild("CurrencyCost")

                if CurrencyFolder and CurrencyFolder:FindFirstChild("Money") then
                    FireTouchTransmitter(v.Head); task.wait()
                end
            end

            task.wait(.35)
        end
    end)
end)

Window:Button("Teleport to Secret Room", function()
    task.spawn(function()
        LocalPlayer.Character:PivotTo(Workspace["Badge Giver (open me)"]:GetPivot())
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