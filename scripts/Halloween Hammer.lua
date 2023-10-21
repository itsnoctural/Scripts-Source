local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService('TeleportService')
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Coins = false,
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("HlwnH | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Auto Coins", {}, function(state)
    task.spawn(function()
        Settings.Coins = state
    end)
end)

Window:Button("Rejoin Server", function()
    task.spawn(function()
        local ServersList = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))

        for _, z in pairs(ServersList.data) do
            if z.playing ~= z.maxPlayers then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, z.id)
            end
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

task.spawn(function()
    while task.wait(1) do
        if Settings.Coins then
            for _, v in ipairs(Workspace.Coins:GetChildren()) do
                LocalPlayer.Character:PivotTo(v:GetPivot()); task.wait(.5)
            end
        end
    end
end)

Workspace.Coins.ChildAdded:Connect(function(v)
    if Settings.Coins then
        print(os.date() .. " | Trying to get coin")
        LocalPlayer.Character:PivotTo(v:GetPivot());
    end
end)

LocalPlayer.Idled:connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
    task.wait()
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
end)