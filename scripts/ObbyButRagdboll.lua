local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Obby = false,
    Wheel = false,
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("OBYR | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Auto Obby", {}, function(state)
    task.spawn(function()
        Settings.Obby = state
        while true do
            if not Settings.Obby then return end

            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("Part") and v.Name == "Spawn" and Settings.Obby then
                    firetouchinterest(v, LocalPlayer.Character:FindFirstChildOfClass("Part"), 0)
                    firetouchinterest(v, LocalPlayer.Character:FindFirstChildOfClass("Part"), 1); task.wait()
                end
            end

            task.wait(.1)
        end
    end)
end)

Window:Toggle("Auto Inf. Wheel", {}, function(state)
    task.spawn(function()
        Settings.Wheel = state
        while true do
            if not Settings.Wheel then return end

            ReplicatedStorage.Modules.Remote.Remotes.SpinWheel:FireServer()
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