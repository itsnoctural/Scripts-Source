local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("WlmrtD | EsohaSL")

Window:Button("Auto Farm Coins", function()
    task.spawn(function()
        for i = 1, 150 do
            ReplicatedStorage.Remotes.CollectCoinEvent:FireServer(i); task.wait()
        end
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

Window:Section("esohasl.com")

Window:Button("YouTube: EsohaSL", function()
   task.spawn(function()
        pcall(function()
            setclipboard("https://youtube.com/@esohasl")
        end)
   end)
end)