local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Coins = false,
    Rebirth = false,
    Spin = false,
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("HS | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Inf. Coins", {}, function(state)
    task.spawn(function()
        Settings.Coins = state
        while true do
            if not Settings.Coins then return end

            ReplicatedStorage.DailyLoginRewards:FireServer(); 
            task.wait()
        end
    end)
end)

Window:Toggle("Auto Rebirth", {}, function(state)
    task.spawn(function()
        Settings.Rebirth = state
        while true do
            if not Settings.Rebirth then return end

            ReplicatedStorage.rebirthbuyRE:FireServer(); 
            task.wait(2.5)
        end
    end)
end)

Window:Toggle("Auto UGC Spinner", {}, function(state)
    task.spawn(function()
        Settings.Spin = state
        while true do
            if not Settings.Spin then return end

            ReplicatedStorage.WheelspinRE:FireServer();
            task.wait(5)
        end
    end)
end)

Window:Section("Anti-AFK Enabled.")

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