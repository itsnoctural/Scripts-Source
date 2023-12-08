local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Collect = false,
}

local function FireTouchTransmitter(touchParent)
    local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")

    if Character then
        firetouchinterest(touchParent, Character, 0)
        firetouchinterest(touchParent, Character, 1)
    end
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("SPMS | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Auto Collect UGC", {}, function(state)
    task.spawn(function()
        Settings.Collect = state
    end)
end)

task.spawn(function()
    while task.wait(10) do
        if Settings.Collect then
            for _, v in ipairs(Workspace.UGCSpawns:GetChildren()) do
                if v:IsA("MeshPart") then FireTouchTransmitter(v) end
            end
        end
    end
end)

Workspace.UGCSpawns.ChildAdded:Connect(function()
    if Settings.Collect then
        if v:IsA("MeshPart") then
            FireTouchTransmitter(v)
        end
    end
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