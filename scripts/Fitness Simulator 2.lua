local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Win = false,
    Strength = false,
    Stamina = false,
    Eggs = {
        Enabled = false,
        Name = "Basic",
        Exclude = {},
    },
}

function GetNearestEnemy()
    local Enemy = nil
    local StartDist = 500

    for _, v in ipairs(Workspace.Enemies:GetChildren()) do
        local Distance = LocalPlayer:DistanceFromCharacter(v.Model:GetPivot().Position)
    
        if Distance < StartDist then
            StartDist = Distance
            Enemy = v
        end
    end

    return Enemy
end

function GetEggs()
    local Eggs = {}

    for _, v in ipairs(ReplicatedStorage.Models.Eggs:GetChildren()) do
        table.insert(Eggs, v.Name)
    end

    table.sort(Eggs)

    return Eggs
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("FS2 | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Auto Win Nearest", {}, function(state)
    task.spawn(function()
        Settings.Win = state
        while true do
            if not Settings.Win then return end

            local Enemy = GetNearestEnemy()

            if Enemy then
                local Hits = {}
                for i = 1, math.random(29, 42) do
                    Hits[i] = tick() - i / 2;
                end                

                ReplicatedStorage.Remotes.GiveWin:FireServer(Enemy.Name, Hits)
            end

            task.wait(.5)
        end
    end)
end)

Window:Toggle("Auto Strength", {}, function(state)
    task.spawn(function()
        Settings.Strength = state
        while true do
            if not Settings.Strength then return end

            ReplicatedStorage.Remotes.Train:FireServer("Strength")
            task.wait()
        end
    end)
end)

Window:Toggle("Auto Stamina", {}, function(state)
    task.spawn(function()
        Settings.Stamina = state
        while true do
            if not Settings.Stamina then return end

            ReplicatedStorage.Remotes.Train:FireServer("Stamina")
            task.wait()
        end
    end)
end)

Window:Toggle("Auto Rebirth", {}, function(state)
    task.spawn(function()
        Settings.Stamina = state
        while true do
            if not Settings.Stamina then return end

            ReplicatedStorage.Remotes.RankUp:InvokeServer()
            task.wait(2.5)
        end
    end)
end)

Window:Dropdown("Eggs", {list = GetEggs()}, function(var)
    task.spawn(function()
        Settings.Eggs.Name = var
    end)
end)

Window:Section("Be near the egg")

Window:Toggle("Auto Eggs", {}, function(state)
    task.spawn(function()
        Settings.Eggs.Enabled = state
        while true do
            if not Settings.Eggs.Enabled then return end

            ReplicatedStorage.Remotes.BuyEgg:InvokeServer(Settings.Eggs.Name, 1, Settings.Eggs.Exclude)
            task.wait(.1)
        end
    end)
end)

Window:Section("Example: Dog, Panda, Super Fish")

Window:Box('Type Pets to delete', {}, function(input)
    task.spawn(function()
        for v in input:gmatch("([^,]+)") do
            Settings.Eggs.Exclude[v:match("^%s*(.-)%s*$")] = true
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

LocalPlayer.Idled:connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
    task.wait()
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
end)