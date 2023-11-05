local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Area = 1,
    Carve = false,
    Sell = false,
}

local Modules = {
    BackpackModule = require(ReplicatedStorage.backpackModule),
}

local function GetAreas()
    local Areas = {}

    for _, v in ipairs(Workspace.pumpkins:GetChildren()) do
        if v:FindFirstChild("Configuration") and not table.find(Areas, v.Configuration.area.Value) then
            table.insert(Areas, v.Configuration.area.Value)
        end
    end

    table.sort(Areas)

    return Areas
end

local function GetBackpack()
    return HttpService:JSONDecode(ReplicatedStorage.RemoteFunction:InvokeServer("getData")).Backpack
end

local TempBackpack = GetBackpack()

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("PCS | EsohaSL")

Window:Section("esohasl.com")

Window:Dropdown("Area", {list = GetAreas()}, function(var)
    task.spawn(function()
        Settings.Area = tonumber(var)
    end)
end)

Window:Toggle("Auto Carve", {}, function(state)
    task.spawn(function()
        Settings.Carve = state
        while true do
            if not Settings.Carve then return end

            ReplicatedStorage.RemoteEvent:FireServer("resetPumpkin");

            for _, v in ipairs(Workspace.pumpkins:GetChildren()) do
                if v:FindFirstChild("Configuration") then
                    if v.Configuration.area.Value == Settings.Area and not v.Configuration.player.Value then
                        while not v.Configuration.complete.Value and Settings.Carve and task.wait(.1) do
                            ReplicatedStorage.RemoteEvent:FireServer("carvePumpkin", v);
                        end
                    end
                end
            end

            task.wait(.1)
        end
    end)
end)

Window:Toggle("Auto Sell", {}, function(state)
    task.spawn(function()
        Settings.Sell = state
        while true do
            if not Settings.Sell then return end

            if LocalPlayer.info.inBag.Value == Modules.BackpackModule[TempBackpack].storage then
                ReplicatedStorage.RemoteFunction:InvokeServer("sellSeeds");
                local v1, v2, v3 = pairs(LocalPlayer.Character.UpperTorso:GetChildren())
                for v4, v5 in v1, v2, v3 do
                    local v6 = v5.Name
                    v6 = v5.Name
                    if v6 == "beamDebris" then
                        v5:Destroy()
                    end
                end
            end

            task.wait(2.5)
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
    while task.wait(30) do
        TempBackpack = GetBackpack();
    end
end)

LocalPlayer.Idled:connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
    task.wait()
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
end)