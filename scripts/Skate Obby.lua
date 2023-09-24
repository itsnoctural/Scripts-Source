local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Win = false,
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("SO | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Auto Win", {}, function(state)
    task.spawn(function()
        Settings.Win = state
        while true do
            if not Settings.Win then return end

            for i = 1, 100 do
                ReplicatedStorage.Packages._Index["sleitnick_knit@1.4.7"].knit.Services.CheckpointService.RF.SetCheckpoint:InvokeServer(i); task.wait()
            end

            task.wait(.25)
        end
    end)
end)

Window:Section("Anti-AFK Enabled")

Window:Button("YouTube: EsohaSL", function()
   task.spawn(function()
        pcall(function()
            setclipboard("https://youtube.com/@esohasl")
        end)
   end)
end)

LocalPlayer.Idled:connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
    task.wait()
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
end)