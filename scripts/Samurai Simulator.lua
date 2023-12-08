local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Rebirth = false,
    Spins = {
        Enabled = false,
        Throttled = false,
    },
    Gift = {
        Enabled = false,
        Number = 1
    },
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("SS | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Auto Rebirth", {}, function(state)
    task.spawn(function()
        Settings.Rebirth = state
        while true do
            if not Settings.Rebirth then return end

            ReplicatedStorage.Channels_F.Client_Server_F.RF.Player_Rebirth:InvokeServer()
            task.wait(.1)
        end
    end)
end)

Window:Toggle("Auto Inf. Spins", {}, function(state)
    task.spawn(function()
        Settings.Spins.Enabled = state
        while true do
            if not Settings.Spins.Enabled then return end

            if not Settings.Spins.Throttled then
                ReplicatedStorage.Remotes.MainRemote:FireServer("AddSpin=50");

                Settings.Spins.Throttled = true
                task.delay(5, function()
                    Settings.Spins.Throttled = false
                end)
            end

            ReplicatedStorage.Remotes.MainRemote:FireServer("AddSpin=-1")
            task.wait(.25)
        end
    end)
end)

Window:Toggle("Auto Inf. Gift", {}, function(state)
    task.spawn(function()
        Settings.Gift.Enabled = state
        while true do
            if not Settings.Gift.Enabled then return end

            ReplicatedStorage.Channels_F.Client_Server_F.RF.Claim_Playtime_Reward:InvokeServer(Settings.Gift.Number); task.wait()
        end
    end)
end)

Window:Box('Type Gift [1-24]', {}, function(input)
    task.spawn(function()
        Settings.Gift.Number = tonumber(input)
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