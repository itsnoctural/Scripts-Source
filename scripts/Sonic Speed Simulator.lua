loadstring(game:HttpGet("https://raw.githubusercontent.com/itsnoctural/Utilities/main/base.lua"))()

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    XP = false,
    Boos = false,
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("SSM | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto XP", {}, function(state)
    task.spawn(function()
        Settings.XP = state
        while true do
            if not Settings.XP then return end

            for _,v in ipairs(CollectionService:GetTagged("Collectable")) do
                ReplicatedStorage.Knit.Services.WorldCurrencyService.RE.PickupCurrency:FireServer(v.Name); task.wait()
            end
            
            task.wait(.05)
        end
    end)
end)

Window:Toggle("Auto Boos", {}, function(state)
    task.spawn(function()
        Settings.Boos = state
        while true do
            if not Settings.Boos then return end

            for _,v in ipairs(CollectionService:GetTagged("Destructible")) do
                ReplicatedStorage.Knit.Services.DestructibleService.RE.ProcessDestructible:FireServer(v.Name)
            end
            
            task.wait()
        end
    end)
end)

Window:Toggle("Auto Gold Eggs", {}, function(state)
    task.spawn(function()
        Settings.Boos = state
        while true do
            if not Settings.Boos then return end

            ReplicatedStorage.Knit.Services.VendorService.RF.ClaimFreeGoldEgg:InvokeServer()
            ReplicatedStorage.Knit.Services.VendorService.RF.EggPurchased:InvokeServer("GoldEggFreeTokens", 1, 0)
            
            task.wait(1)
        end
    end)
end)

Window:Button("Win Neo Metal Sonic", function()
    task.spawn(function()
        local Duration = 180 + math.random(1, 30)

        ReplicatedStorage.Knit.Services.FlyingBattleService.RE.AttemptBossComplete:FireServer(Duration, {
            ["Difficulty"] = "Easy",
            ["CollectedOrbs"] = 300 + math.random(5, 100),
            ["DamageToNeo"] = 3000,
            ["FightDuration"] = Duration,
            ["CollectedRings"] = math.random(200, 350),
            ["CandyEarned"] = 0,
            ["Rank"] = "F"
        }, false)
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