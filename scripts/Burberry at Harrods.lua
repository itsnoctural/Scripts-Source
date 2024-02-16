local ReplicatedStorage = game:GetService("ReplicatedStorage")

getgenv().Settings = {Coins = false}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("BH | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Inf. Coins", {}, function(state)
    task.spawn(function()
        Settings.Coins = state
        while true do
            if not Settings.Coins then return end

            ReplicatedStorage.Remotes.CollectCoinEvent:FireServer("Coin60");
            task.wait()
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