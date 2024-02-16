local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Default = false,
}

local AbovePos = CFrame.new(0, 15, 0) * CFrame.Angles(-90, 0, 0)

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("PnchS | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Dungeon", {}, function(state)
    task.spawn(function()
        Settings.Dungeon = state
        while true do
            if not Settings.Dungeon then return end

            for _, v in ipairs(Workspace.BreakableParts.Dungeon:GetChildren()) do
                ReplicatedStorage.Events.SetTarget:FireServer(v)
                while Settings.Dungeon and v.Parent and task.wait() do
                    LocalPlayer.Character:PivotTo(v:GetPivot() * AbovePos)
                    ReplicatedStorage.Events.PunchEvent:FireServer(v)
                end
                ReplicatedStorage.Events.SetTarget:FireServer()
            end

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