local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Buttons = false,
    Collect = false,
    Arrest = false,
    ATMs = false,
}

local function FireTouchTransmitter(touchParent)
    local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")

    if Character then
        firetouchinterest(touchParent, Character, 0)
        firetouchinterest(touchParent, Character, 1)
    end
end

local Tycoon = LocalPlayer.Tycoon.Value

task.spawn(function()
    while task.wait(1) do
        if not Tycoon then Tycoon = LocalPlayer.Tycoon.Value end
    end
end)

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("CRT | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Buttons", {}, function(state)
    task.spawn(function()
        Settings.Buttons = state
        while true do
            if not Settings.Buttons then return end

            for _, v in ipairs(Tycoon.Buttons:GetChildren()) do
                local Money =  v.CurrencyCost:FindFirstChild("Money")

                if Money and LocalPlayer.realstats.Money.Value > Money.Value then
                    FireTouchTransmitter(v.Head); task.wait()
                end
            end

            task.wait(1)
        end
    end)
end)

Window:Toggle("Auto Collect", {}, function(state)
    task.spawn(function()
        Settings.Collect = state
        while true do
            if not Settings.Collect then return end

            FireTouchTransmitter(Tycoon.Essentials.CurrencyCollector.Giver);
            task.wait(2.5)
        end
    end)
end)

Window:Toggle("Auto Arrest", {}, function(state)
    task.spawn(function()
        Settings.Arrest = state
        while true do
            if not Settings.Arrest then return end

            for _, v in ipairs(Players:GetPlayers()) do
                if v.realstats.Reputation.Value < 0 then
                    ReplicatedStorage.HandcuffEvent:FireServer(v.Character, 1, LocalPlayer.realstats.Reputation); task.wait()
                end
            end

            task.wait(2.5)
        end
    end)
end)

Window:Toggle("Auto Robbing ATMs", {}, function(state)
    task.spawn(function()
        Settings.ATMs = state
        while true do
            if not Settings.ATMs then return end

            for _, v in ipairs(Workspace.Map.ATMs:GetChildren()) do
                if v.Cooldown.Value == 0 then
                    LocalPlayer.Character:PivotTo(v.Screen:GetPivot()); task.wait(.25)
                    fireproximityprompt(v.ProxPart.ProximityPrompt)
                end
            end


            if LocalPlayer:DistanceFromCharacter(Tycoon.Essentials.TycoonSpawn.Position) > 10 then
                LocalPlayer.Character:PivotTo(Tycoon.Essentials.TycoonSpawn:GetPivot() * CFrame.Angles(math.rad(-90), 0, 0));
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