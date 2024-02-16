local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local SpinCoords = LocalPlayer.PlayerGui.ScreenGui.MainUI.Spin.Spin.ImageLabel.AbsolutePosition

getgenv().Settings = {
    Spin = false,
    Obby = false,
    Dominiues = false,
}

local function Hopper()
    local ServersList = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))

    for _, v in pairs(ServersList.data) do
        if v.playing and v.playing <= 35 then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, v.id); task.wait(.1)
        end
    end
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("SFFU | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Spin", {}, function(state)
    task.spawn(function()
        Settings.Spin = state
        while true do
            if not Settings.Spin then return end

            VirtualInputManager:SendMouseButtonEvent(SpinCoords.X, SpinCoords.Y + 50, 0, true, game, 1); task.wait()
            VirtualInputManager:SendMouseButtonEvent(SpinCoords.X, SpinCoords.Y + 50, 0, false, game, 1)

            task.wait(1)
        end
    end)
end)

Window:Toggle("Auto Obby", {}, function(state)
    task.spawn(function()
        Settings.Obby = state
        while true do
            if not Settings.Obby then return end

            if LocalPlayer:DistanceFromCharacter(Workspace.ObbyFinish:GetPivot().Position) > 10 then
                LocalPlayer.Character:PivotTo(Workspace.ObbyFinish:GetPivot()); task.wait(.5)
            end

            fireproximityprompt(Workspace.ObbyFinish.ProximityPrompt)

            task.wait(.75)
        end
    end)
end)

Window:Button("Server Hop", function()
    task.spawn(function()
        Hopper()
    end)
end)

Window:Toggle("Auto Tiny Dominiues", {default = Settings.Dominiues}, function(state)
    task.spawn(function()
        for _,v in ipairs(Workspace.TinyDominus:GetChildren()) do
            if v.Name == "Item" then
                LocalPlayer.Character:PivotTo(v:GetPivot()); task.wait(.75)
                fireproximityprompt(v.ProximityPrompt); task.wait(1)

                Hopper()
            end
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