-- Link: https://www.roblox.com/games/13827198708/FREE-LIMITED-Pull-a-Sword
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Win = false,
    Rebirth = false,
    Gifts = false,
}

function GetLatestMob()
    local MobIndex = "1";

    for _, v in pairs(ReplicatedStorage.Mobs:GetChildren()) do
        if v.Power.Value < LocalPlayer.Rock.Value then
           MobIndex = v.Name 
        end
    end

    return MobIndex
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("PS | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Auto Win", {}, function(state)
    task.spawn(function()
        Settings.Win = state
        while true do
            if not Settings.Win then return end

            ReplicatedStorage.WinEvent:FireServer(GetLatestMob());
            task.wait(.25)
        end
    end)
end)

Window:Toggle("Auto Rebirth", {}, function(state)
    task.spawn(function()
        Settings.Rebirth = state
        while true do
            if not Settings.Rebirth then return end

            ReplicatedStorage.GameClient.Events.RemoteEvent.RebirthEvent:FireServer()
            task.wait(2.5)
        end
    end)
end)

Window:Toggle("Auto Claim Gifts", {}, function(state)
    task.spawn(function()
        Settings.Gifts = state
        while true do
            if not Settings.Gifts then return end

            for _, v in ipairs(ReplicatedStorage.Gifts:GetChildren()) do
                ReplicatedStorage.GameClient.Events.RemoteEvent.ClaimGift:FireServer(v.Name); task.wait(.1)
            end

            task.wait(30)
        end
    end)
end)

Window:Button("Redeem codes", function()
    task.spawn(function()
        for _, v in ipairs(ReplicatedStorage.Codes:GetChildren()) do
            ReplicatedStorage.GameClient.Events.RemoteEvent.CodeEventSR:FireServer(v.Code.Value);
        end
    end)
 end)

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