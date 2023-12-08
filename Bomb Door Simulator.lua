local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Win = false,
    Train = false,
    Honey = false,
}

local Map10 = Workspace.World.Map10

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("BDS | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Auto Win", {}, function(state)
    task.spawn(function()
        Settings.Win = state
        while true do
            if not Settings.Win then return end

            LocalPlayer.Character:PivotTo(Map10.Trophy:GetPivot()); task.wait(2.5)
        end
    end)
end)

Window:Toggle("Auto Train", {}, function(state)
    task.spawn(function()
        Settings.Train = state
        while true do
            if not Settings.Train then return end

            ReplicatedStorage.RemoteEvents.Click:FireServer(Map10.Targets.target4, "Map10"); task.wait(.1)
        end
    end)
end)

Window:Toggle("Auto Honey Egg", {}, function(state)
    task.spawn(function()
        Settings.Honey = state
        while true do
            if not Settings.Honey then return end

            ReplicatedStorage.RemoteFun.offerPet:InvokeServer("Honey Egg", "Single"); task.wait(.25)
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