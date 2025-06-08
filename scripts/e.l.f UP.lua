local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Buttons = false,
    Collect = false,
    Store = false,
    Wheel = false,
}

local Components = {TycoonClient = require(LocalPlayer.PlayerScripts.Client.Components.TycoonClientComponent);}

-- Knit
local Packages = ReplicatedStorage.Packages._Index

local Knit = Packages:FindFirstChild("sleitnick_knit@1.7.0")
local Services = Knit.knit.Services

game:GetService("CoreGui").PurchasePrompt.Enabled = false
LocalPlayer.PlayerGui.Notification.Enabled = false

function GetTycoon()
    return Components.TycoonClient.GetPlayersTycoon();
end

local Tycoon = GetTycoon()

local function FireTouchTransmitter(touchParent)
    local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")

    if Character then
        firetouchinterest(touchParent, Character, 0)
        firetouchinterest(touchParent, Character, 1)
    end
end

function AutoCollectors()
    for _, v in ipairs(Tycoon.CurrencyCollectors:GetChildren()) do
        if v:FindFirstChild("Hitbox") then
            FireTouchTransmitter(v.Hitbox)
        end
    end
end

function AutoButtons()
    for _, v in ipairs({table.unpack(Tycoon.Pads:GetDescendants()), table.unpack(Tycoon.Stores:GetDescendants())}) do
        if v.Name == "Hitbox" and v:FindFirstChildOfClass("TouchTransmitter") then
            FireTouchTransmitter(v)
        end
    end
end

function AutoStore()
    for _, v in ipairs(Tycoon.Pads:GetChildren()) do
        if string.find(v.Name, "Store") and v:FindFirstChildOfClass("Model") then
            local Stores = Services.StoreService.RF.GetStoreSelectionOptions:InvokeServer("Generic")
            Services.StoreService.RF.UseKey:InvokeServer("Generic", v.Name, Stores[math.random(1, 3)]); return
        end
    end
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("e.l.f | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Buttons", {}, function(state)
    task.spawn(function()
        Settings.Buttons = state
        while true do
            if not Settings.Buttons then return end

            AutoButtons();
            task.wait(.5)
        end
    end)
end)

Window:Toggle("Auto Collect", {}, function(state)
    task.spawn(function()
        Settings.Collect = state
        while true do
            if not Settings.Collect then return end

            AutoCollectors();
            task.wait(.75)
        end
    end)
end)

Window:Toggle("Auto Store", {}, function(state)
    task.spawn(function()
        Settings.Store = state
        while true do
            if not Settings.Store then return end

            AutoStore();
            task.wait(1)
        end
    end)
end)

Window:Toggle("Auto Rebirth", {}, function(state)
    task.spawn(function()
        Settings.Rebirth = state
        while true do
            if not Settings.Rebirth then return end

            Services.TycoonService.RF.Rebirth:InvokeServer();
            task.wait(3.5)
        end
    end)
end)

Window:Toggle("Auto Spin Wheel", {}, function(state)
    task.spawn(function()
        Settings.Wheel = state
        while true do
            if not Settings.Wheel then return end

            Services.SpinService.RF.SpinWheel:InvokeServer()
            task.wait(1)
            Services.SpinService.RF.Claim:InvokeServer()
            task.wait(120)
        end
    end)
end)

Window:Button("Collect Sinfluencer Items", function()
    task.spawn(function()
        for _,v in ipairs(Workspace.PRojectMercuryHiddenItemComponents:GetChildren()) do
            if v:FindFirstChild("Part") then
                firetouchinterest(v.Part, LocalPlayer.Character.HumanoidRootPart, 0)
                firetouchinterest(v.Part, LocalPlayer.Character.HumanoidRootPart, 1); task.wait(.25)
            end
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