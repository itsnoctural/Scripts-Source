local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Money = 1000,
    Friends = 10,
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("FaF | EsohaSL")

Window:Section("esohasl.com")

Window:Button("Give Money", function()
    task.spawn(function()
        ReplicatedStorage.RemoteEvent:FireServer({{"\n", Settings.Money}})
    end)
end)

Window:Box('How many Money?', {}, function(input)
    task.spawn(function()
        Settings.Money = tonumber(input)
    end)
end)

Window:Button("Give Friends", function()
    task.spawn(function()
        ReplicatedStorage.RemoteEvent:FireServer({{"\11", Settings.Friends}})
    end)
end)

Window:Box('How many Friends?', {}, function(input)
    task.spawn(function()
        Settings.Friends = tonumber(input)
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