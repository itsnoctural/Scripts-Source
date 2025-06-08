local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Default = false,
}

local function FireTouchTransmitter(touchParent)
    if firetouchinterest then
        local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")
    
        if Character then
            firetouchinterest(touchParent, Character, 0)
            firetouchinterest(touchParent, Character, 1)
        end
    else
        LocalPlayer.Character:PivotTo(touchParent:GetPivot())
    end
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow(" | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Candy", {}, function(state)
    task.spawn(function()
        Settings.Default = state
        while true do
            if not Settings.Default then return end

            for _,v in ipairs(Workspace.CandySpawns:GetChildren()) do
                FireTouchTransmitter(v.TouchPart); task.wait(0.05)
            end

            task.wait(1)
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