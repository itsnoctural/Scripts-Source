local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService('TeleportService')
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Corns = false,
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("SlapB | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Auto Candy Corns", {}, function(state)
    task.spawn(function()
        Settings.Corns = state
    end)
end)

Window:Button("YouTube: EsohaSL", function()
   task.spawn(function()
        pcall(function()
            setclipboard("https://youtube.com/@esohasl")
        end)
   end)
end)

Workspace.CandyCorns.ChildAdded:Connect(function(v)
    if Settings.Corns then
        v:PivotTo(LocalPlayer.Character:GetPivot())
    end
end)

while task.wait(1) do
    if Settings.Corns then
        for _, v in ipairs(Workspace.CandyCorns:GetChildren()) do
            v:PivotTo(LocalPlayer.Character:GetPivot())
        end
    end
end

LocalPlayer.Idled:connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
    task.wait()
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
end)