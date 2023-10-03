-- Link: https://www.roblox.com/games/14793777270/Team-Rob-The-Bank-Escape-TEAMWORK-OBBY-2
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Default = false,
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("TRBE | EsohaSL")

Window:Section("esohasl.com")

Window:Button("UGC Win", function()
    task.spawn(function()
        ReplicatedStorage.RepStorage.Win:FireServer()
    end)
end)

Window:Button("Find Guns", function()
    task.spawn(function()
        for _, v in ipairs(Workspace.GameAssets.Money:GetChildren()) do
            if v.Name == "Gun" then
                if firetouchinterest then
                    firetouchinterest(LocalPlayer.Character:FindFirstChildOfClass("Part"), v.TouchPart, 0)
                    firetouchinterest(LocalPlayer.Character:FindFirstChildOfClass("Part"), v.TouchPart, 1)
                else
                    LocalPlayer.Character:PivotTo(v:GetPivot()); task.wait(.25)
                end
            end
        end
    end)
end)

Window:Button("Invite Friend", function()
    task.spawn(function()
        ReplicatedStorage.RepStorage.UGC.FriendJoined:FireServer()
    end)
end)

Window:Section("esohasl.com")

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