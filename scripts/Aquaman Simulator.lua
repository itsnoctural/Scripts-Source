local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Farm = false,
    Pickup = false,
}

local function GetNearestEnemy()
    local Nearest = nil
    local StartDist = 250

    for _, v in ipairs(Workspace.Areas:GetChildren()) do
        local EnemySpawning = v:FindFirstChild("EnemySpawning")

        if EnemySpawning then
            for _, j in ipairs(EnemySpawning.EnemyPositions:GetChildren()) do
                local Enemy = j:FindFirstChildOfClass("Model")

                if Enemy then
                    local Distance = LocalPlayer:DistanceFromCharacter(Enemy:GetPivot().Position)
                
                    if Distance < StartDist then
                        StartDist = Distance
                        Nearest = Enemy
                    end
                end
            end
        end
    end

    return Nearest
end

local src = require(Workspace.Src.Shoot)

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("AS | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Farm Nearest", {}, function(state)
    task.spawn(function()
        Settings.Farm = state
        while true do
            if not Settings.Farm then return end

            local NearestEnemy = GetNearestEnemy()

            if NearestEnemy then
                while NearestEnemy.Parent and Settings.Farm and task.wait(1) do
                    for _, v in ipairs(Workspace.Pets[LocalPlayer.Name]:GetChildren()) do
                        src:UpdateTarget(v, NearestEnemy, tick());
                    end
                end
            end

            task.wait(1)
        end
    end)
end)

Window:Toggle("Auto Pickup", {}, function(state)
    task.spawn(function()
        Settings.Pickup = state
        while true do
            if not Settings.Pickup then return end

            local Coin = Workspace.Temp.ItemPickups:FindFirstChildOfClass("Model")

            if Coin then
                LocalPlayer.Character:PivotTo(Coin:GetPivot());
            end

            task.wait(1)
        end
    end)
end)

Window:Button("Get 4K Trident [Once]", function()
    task.spawn(function()
        ReplicatedStorage.GoldTridentHandler_grantGoldTridentRemoteEvent:FireServer()
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

