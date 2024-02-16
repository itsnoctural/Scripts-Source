local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Reindeer = false,
    Hit = false,
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("VC | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Reindeer", {}, function(state)
    task.spawn(function()
        Settings.Reindeer = state
        while true do
            if not Settings.Reindeer then return end

            for _, v in ipairs(Workspace.christmasEvent.hidingReindeer:GetChildren()) do
                local ClickDetector = v:FindFirstChildOfClass("ClickDetector")

                if ClickDetector then
                    fireclickdetector(ClickDetector); task.wait(.1)
                end
            end

            task.wait(1)
        end
    end)
end)


Window:Toggle("Auto Hit", {}, function(state)
    task.spawn(function()
        Settings.Hit = state
        while true do
            if not Settings.Hit then return end

            ReplicatedStorage.Remotes.Shoot:FireServer("Hit")
            task.wait()
        end
    end)
end)

Window:Button("Teleport to Santa", function()
    task.spawn(function()
        LocalPlayer.Character:PivotTo(Workspace.christmasEvent.standPos:GetPivot() + Vector3.new(0, 3, 0))
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