local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {Default = false}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("NMGC | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Nicki Letters", {}, function(state)
    task.spawn(function()
        Settings.Default = state
        while true do
            if not Settings.Default then return end

            for _, v in ipairs(Workspace.NICKILetters:GetChildren()) do
                firetouchinterest(v, LocalPlayer.Character.HumanoidRootPart, 0); task.wait()
                firetouchinterest(v, LocalPlayer.Character.HumanoidRootPart, 1)
            end

            task.wait(1)
        end
    end)
end)

Window:Button("Teleport to UGC", function()
    task.spawn(function()
        LocalPlayer.Character:PivotTo(Workspace.LimitedUGC:GetPivot() + Vector3.new(-2.5, 0, 0))
    end)
end)

Window:Button("YouTube: EsohaSL", function()
    task.spawn(function()
        if setclipboard then
            setclipboard("https://youtube.com/@esohasl")
        end
    end)
end)