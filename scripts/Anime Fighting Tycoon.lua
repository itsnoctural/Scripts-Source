local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Buttons = false,
    Collect = false,
    Rings = false,
    Gifts = false,
}

local function FireTouchTransmitter(touchParent)
    local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")

    if Character then
        firetouchinterest(touchParent, Character, 0)
        firetouchinterest(touchParent, Character, 1)
    end
end

local function GetTycoon()
    for _, v in ipairs(Workspace.Tycoons:GetDescendants()) do
        if v:IsA("TextLabel") and v.Name == "PlayerName" then
            if v.Text == LocalPlayer.Name then
                return v.Parent.Parent.Parent
            end
        end
    end

    return false
end

local Tycoon = GetTycoon()

task.spawn(function()
    while task.wait(1) do
        if not Tycoon then
            Tycoon = GetTycoon()
        else return end
    end
end)

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("AFT | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Auto Buttons", {}, function(state)
    task.spawn(function()
        Settings.Buttons = state
        while true do
            if not Settings.Buttons then return end

            if Tycoon then
                for _, v in ipairs(Tycoon.Pads:GetChildren()) do
                    FireTouchTransmitter(v); task.wait()
                end
            end

            task.wait(.75)
        end
    end)
end)

Window:Toggle("Auto Collect Cash", {}, function(state)
    task.spawn(function()
        Settings.Collect = state
        while true do
            if not Settings.Collect then return end

            if Tycoon then
                for _, v in ipairs(Tycoon.Models.Collector:GetChildren()) do
                    if v:IsA("Part") and v:FindFirstChildOfClass("TouchTransmitter") then
                        FireTouchTransmitter(v); break;
                    end
                end
            end

            task.wait(1)
        end
    end)
end)

Window:Toggle("Auto Rings", {}, function(state)
    task.spawn(function()
        Settings.Rings = state
        while true do
            if not Settings.Rings then return end

            for _, v in ipairs(Workspace.Rings:GetChildren()) do
                if v:FindFirstChild("Hitbox") then
                    FireTouchTransmitter(v.Hitbox); task.wait()
                end
            end

            task.wait(.5)
        end
    end)
end)

Window:Toggle("Auto Gifts", {}, function(state)
    task.spawn(function()
        Settings.Gifts = state
        while true do
            if not Settings.Gifts then return end

            local Gift = Workspace.Gifts:FindFirstChildOfClass("Model")

            if Gift then
                ReplicatedStorage["<firework>RemoteEvent"]:FireServer("AbilitySystem", "UseAbility", "Naruto1", Gift:GetPivot().Position);
            end

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