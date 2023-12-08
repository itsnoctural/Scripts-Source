local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local BattleConfig = require(ReplicatedStorage.Source.Config.BattleConfig)

getgenv().Settings = {
    Pop = false,
    Win = false,
    Eggs = {
        Enabled = false,
        Name = "Starter"
    }
}

local function GetEggs()
    local Eggs = {}

    for _, v in ipairs(Workspace.Worlds:GetChildren()) do
        for _, j in ipairs(v.Eggs:GetChildren()) do
            table.insert(Eggs, j.Name)
        end
    end

    table.sort(Eggs)

    return Eggs
end

local function GetNearestCharacter()
    local Enemy = nil
    local StartDist = 500

    for _, v in ipairs(Workspace.Worlds:GetChildren()) do
        for _, z in ipairs(v.Battles:GetChildren()) do
            local Distance = LocalPlayer:DistanceFromCharacter(z:GetPivot().Position)
        
            if Distance < StartDist then
                StartDist = Distance
                Enemy = z
            end
        end
    end

    return Enemy
end

local function ParseCharacter()
    local ParsedIndex = 1
    local Character = GetNearestCharacter()
    local CharacterName = "Noob"

    if Character:FindFirstChild("PileRoot") then
        CharacterName = Character.PileRoot.BattleInfo.Title.Text
    end

    for i, v in pairs(BattleConfig.Characters) do
        if v.Name == CharacterName then
            ParsedIndex = i
        end
    end

    return ParsedIndex
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("PcrnS | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Fast Auto Pop", {}, function(state)
    task.spawn(function()
        Settings.Pop = state
        while true do
            if not Settings.Pop then return end

            ReplicatedStorage.Packages.Knit.Services.PopService.RF.Pop:InvokeServer()
            ReplicatedStorage.Packages.Knit.Services.PopService.RF.AddPopcorn:InvokeServer(2)
            task.wait()
        end
    end)
end)

Window:Toggle("Auto Win Nearest", {}, function(state)
    task.spawn(function()
        Settings.Win = state
        while true do
            if not Settings.Win then return end

            ReplicatedStorage.Packages.Knit.Services.PopService.RF.BattleWon:InvokeServer(ParseCharacter())        
            task.wait(.25)
        end
    end)
end)

Window:Toggle("Auto Rebirth", {}, function(state)
    task.spawn(function()
        Settings.Rebirth = state
        while true do
            if not Settings.Rebirth then return end

            ReplicatedStorage.Packages.Knit.Services.GameService.RF.Rebirth:InvokeServer()
            task.wait(2.5)
        end
    end)
end)

Window:Dropdown("Eggs", {list = GetEggs()}, function(var)
    task.spawn(function()
        Settings.Eggs.Name = var
    end)
end)

Window:Toggle("Auto Eggs", {}, function(state)
    task.spawn(function()
        Settings.Eggs.Enabled = state
        while true do
            if not Settings.Eggs.Enabled then return end

            ReplicatedStorage.Packages.Knit.Services.PetService.RF.BuyEgg:InvokeServer(Settings.Eggs.Name, 3, false)
            task.wait(1)
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

table.foreach(game:GetService("Workspace").Worlds.World3.Battles["2"]:GetAttributes(), print)