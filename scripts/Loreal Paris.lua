loadstring(game:HttpGet("https://raw.githubusercontent.com/itsnoctural/Utilities/main/base.lua"))()

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Packets = require(ReplicatedStorage.Shared.Networking.Packets)

getgenv().Settings = {
    Hearts = false,
    Zones = false,
    Rebirth = false,
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("LPCS | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Inf. Worth It Power", {}, function(state)
    task.spawn(function()
        Settings.Hearts = state
        while true do
            if not Settings.Hearts then return end

            for i = 1, 15 do
                Packets.ModelWalkedRunway.send(); task.wait()
            end

            if LocalPlayer:DistanceFromCharacter(Workspace.Map.LoveCollectionArea:GetPivot().Position) > 10 then
                LocalPlayer.Character:PivotTo(Workspace.Map.LoveCollectionArea:GetPivot());
            end

            --     debug.getupvalues(LoveAccumulationController.RedeemHeart)[8].LoveRedemptionRequested.send({
            --         amount = 9999
            --     });

            Packets.LoveConversionRequested.send({
                multiplier = 25.0
            })

            task.wait(.1)
        end
    end)
end)

Window:Toggle("Auto Unlock Zones", {}, function(state)
  task.spawn(function()
    Settings.Zones = state
    while true do
        if not Settings.Zones then return end

        for _,v in ipairs(Workspace.Map.Zones:GetChildren()) do
            Packets.GatedAreaPurchaseRequested.send({
                areaName = v.Name
            }); task.wait()
        end

        task.wait(.25)
    end
  end)
end)

Window:Toggle("Auto Rebirth", {}, function(state)
    task.spawn(function()
      Settings.Rebirth = state
      while true do
        if not Settings.Rebirth then return end
  
        Packets.RebirthRequested.send()
        task.wait(.35)
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

LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
    task.wait()
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
end)