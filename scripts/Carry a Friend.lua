local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Complete = false,
    Enter = {
        Enabled = false,
        Level = "Level 1: Basics",
        Delay = {
            Default = 4,
            Increased = 7.5
        }
    },
    Eggs = {
        Enabled = false,
        Name = ""
    }
}

local function FireTouchTransmitter(touchParent)
    local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")

    if Character then
        firetouchinterest(touchParent, Character, 0)
        firetouchinterest(touchParent, Character, 1)
    end
end

local function GetPortalsNames()
    local Names = {}

    for _,v in ipairs(Workspace["2 Player:"]:GetChildren()) do
        table.insert(Names, v.Name)
    end

    table.sort(Names)

    return Names
end

local function GetEggs()
    local Eggs = {}

    for _, v in ipairs(Workspace.PetEggs:GetChildren()) do
        table.insert(Eggs, v.Name)
    end

    table.sort(Eggs)

    return Eggs
end

local function Complete()
    for _, v in ipairs(Workspace["2 Player:"]:GetChildren()) do
        local ToLobby = v.Jumps:FindFirstChild("ToLobby")

        if ToLobby then
            LocalPlayer.Character:PivotTo(ToLobby:GetPivot())
        end
    end
end

local function Enter()
    for _, v in ipairs(Workspace.PortalTPS:GetChildren()) do
        if v.Data.Level.Value.Name == Settings.Enter.Level then
            ReplicatedStorage.Events.EnterLevel:FireServer(v); break
        end
    end
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("CaF | EsohaSL")

Window:Section("esohasl.net")

Main = task.spawn(function()
    while true do    
        if Settings.Complete then Complete() end
        if Settings.Enter.Enabled then Enter(); task.wait(Settings.Enter.Level == "Level 11: Rebound" and Settings.Enter.Delay.Increased or Settings.Enter.Delay.Default) end

        task.wait(.25)
    end
end)

Window:Toggle("Auto Complete", {}, function(state)
    task.spawn(function()
        Settings.Complete = state
    end)
end)

Window:Toggle("Auto Enter", {}, function(state)
    task.spawn(function()
        Settings.Enter.Enabled = state
    end)
end)

Window:Dropdown("Levels", {list =  GetPortalsNames()}, function(var)
    task.spawn(function()
        Settings.Enter.Level = var
    end)
end)

Window:Toggle("Auto Rebirth", {}, function(state)
    task.spawn(function()
        Settings.Rebirth = state
        while true do
            if not Settings.Rebirth then return end

            ReplicatedStorage.Events.Rebirth:FireServer()
            task.wait(10)
        end
    end)
end)

Window:Dropdown("Eggs", {list =  GetEggs()}, function(var)
    task.spawn(function()
        Settings.Eggs.Name = var
    end)
end)

Window:Toggle("Auto Eggs", {}, function(state)
    task.spawn(function()
        Settings.Eggs.Enabled = state
        while true do
            if not Settings.Eggs.Enabled then return end

            ReplicatedStorage.Events.OpenEgg:FireServer(Settings.Eggs.Name, 1)
            task.wait(.1)
        end
    end)
end)

Window:Button('Do "Invite 25 Friends"', function()
    task.spawn(function()
        for i = 1, 25 do
            ReplicatedStorage.Events.InviteFriend:FireServer(); task.wait(.25)
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