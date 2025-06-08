loadstring(game:HttpGet("https://raw.githubusercontent.com/itsnoctural/Utilities/main/base.lua"))()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

local Modules = {
    PetManager = require(ReplicatedStorage.Shared.Components.Pets.PetManager),
    Field = require(ReplicatedStorage.Client.Components.Spawner.Field),
    Pet = require(ReplicatedStorage.Client.Components.Pet.Pet),
}

local PetStates = {
    ["Lonely"] = "Hugged",
    ["Hungry"] = "Fed",
    ["Stinky"] = "Bathed",
}
local PetInteracted = require(ReplicatedStorage.Remotes.RemoteWrapper).new("PetInteracted")
local PurchaseEgg =  require(ReplicatedStorage.Remotes.RemoteWrapper).new("PurchaseEgg")
local Fields = {}

getgenv().Settings = {
    Happy = false,
    Flowers = {
        Enabled = false,
        Type = "All"
    },
    Candy = false,
    Rainbow = false,
    Eggs = {
        Enabled = false,
        Choice = "AdoptacornEgg"
    }
}

for _,v in ipairs(Workspace.Maps.Fields:GetChildren()) do
    for _,z in ipairs(v:GetChildren()) do
        local Field = Modules.Field:GetFieldFromUID(z.FieldArea:GetAttribute("UID"))

        table.insert(Fields, Field)
    end
end

local function GetPets()
    return Modules.PetManager.Sessions[LocalPlayer.Name].Pets
end

local function GetFlowers()
    local Flowers = {}

    for _,v in ipairs(ReplicatedStorage.Metadata.Consumables.Flowers:GetChildren()) do
        table.insert(Flowers, v.Name)
    end

    return Flowers
end

local function GetNearestCandy()
    local Candy = nil
    local CurrentDistance = math.huge

    for _,v in ipairs(Fields) do
        for _,z in ipairs(v._Bushes) do
            if string.find(z._Root.Parent.Name, "Halloween") then
                local Distance = LocalPlayer:DistanceFromCharacter(z._Root:GetPivot().Position)

                if CurrentDistance > Distance then
                    CurrentDistance = Distance
                    Candy = z
                end
            end
        end
    end

    return Candy
end

local function GetNearestRainbow()
    local Rainbow = nil
    local CurrentDistance = math.huge

    for _,v in ipairs(Fields) do
        for _,z in ipairs(v._Bushes) do
            if z._isRainbow then
                local Distance = LocalPlayer:DistanceFromCharacter(z._Root:GetPivot().Position)

                if CurrentDistance > Distance then
                    CurrentDistance = Distance
                    Rainbow = z
                end
            end
        end
    end

    return Rainbow
end

local function GetNearestFlower()
    local Flower = nil
    local CurrentDistance = math.huge

    for _,v in ipairs(Workspace.Activators:GetChildren()) do
        if v.Name == "Flower" and (Settings.Flowers.Type == "All" and true or Settings.Flowers.Type == v.DEBRIS:GetAttribute("ItemId")) then
            local Distance = LocalPlayer:DistanceFromCharacter(v:GetPivot().Position)

            if CurrentDistance > Distance then
                CurrentDistance = Distance
                Flower = v
            end
        end
    end

    return Flower
end

local function GetEggs()
    local Eggs = {}

    for _,v in ipairs(ReplicatedStorage.Metadata.Eggs:GetChildren()) do
        if v.Name ~= "_Template" then
            table.insert(Eggs, v.Name)
        end
    end

    table.sort(Eggs)

    return Eggs
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("RaR | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Happy Pets", {}, function(state)
    task.spawn(function()
        Settings.Happy = state
        while true do
            if not Settings.Happy then return end

            for _,pet in ipairs(GetPets()) do
                if typeof(pet._HappyState) ~= "table" then continue end
                
                for name,state in pairs(pet._HappyState) do
                    if state then
                        PetInteracted:InvokeServer({pet._UID, PetStates[name]}); task.wait(.1)
                    end
                end
            end

            task.wait(1.75)
        end
    end)
end)

Window:Toggle("Auto Flowers", {}, function(state)
    task.spawn(function()
        Settings.Flowers.Enabled = state
        while true do
            if not Settings.Flowers.Enabled then return end

            local Flower = GetNearestFlower()

            if Flower then
                LocalPlayer.Character:PivotTo(Flower:GetPivot() + Vector3.new(0, 5, 0)); task.wait(.1)
                fireproximityprompt(Flower.Part.ProximityPrompt)
            end

            task.wait(.1)
        end
    end)
end)

Window:Dropdown("Flowers", {list = {"All", table.unpack(GetFlowers())}}, function(value)
    task.spawn(function()
        Settings.Flowers.Type = value
    end)
end)

Window:Toggle("Auto Candy", {}, function(state)
    task.spawn(function()
        Settings.Candy = state
        while true do
            if not Settings.Candy then return end

            local Candy = GetNearestCandy()

            if Candy and LocalPlayer:DistanceFromCharacter(Candy._Root:GetPivot().Position) > 5 then
                LocalPlayer.Character:PivotTo(Candy._Root:GetPivot())
            end

            task.wait(.1)
        end
    end)
end)

Window:Toggle("Auto Rainbow", {}, function(state)
    task.spawn(function()
        Settings.Rainbow = state
        while true do
            if not Settings.Rainbow then return end

            local Rainbow = GetNearestRainbow()

            if Rainbow and LocalPlayer:DistanceFromCharacter(Rainbow._Root:GetPivot().Position) > 5 then
                LocalPlayer.Character:PivotTo(Rainbow._Root:GetPivot())
            end

            task.wait(.1)
        end
    end)
end)

Window:Dropdown("Eggs", {list = GetEggs()}, function(value)
    task.spawn(function()
        Settings.Eggs.Choice = value
    end)
end)

Window:Toggle("Auto Purchase Eggs", {}, function(state)
    task.spawn(function()
        Settings.Eggs.Enabled = state
        while true do
            if not Settings.Eggs.Enabled then return end

            local GUID = nil

            for _,v in ipairs(Workspace.Machines:GetChildren()) do
                if v:FindFirstChild("Root") and v.Root:GetAttribute("EggType") == Settings.Eggs.Choice then
                    GUID = v.Root:GetAttribute("PurchaserGUID")
                    break
                end
            end

            if GUID then
                PurchaseEgg:InvokeServer({
                    PurchaserGUID = GUID
                })
            else
                print(string.format("[ESOHASL] It seems the %s isn't loaded.", Settings.Eggs.Choice))
            end

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

LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
    task.wait()
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
end)