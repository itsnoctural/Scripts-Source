-- Link: https://www.roblox.com/games/13827198708/FREE-LIMITED-Pull-a-Sword
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Click = false,
    Win = {
        Enabled = false,
        LastTime = os.clock()
    },
    Nearest = false,
    WinterMobs = false,
    DamageUpgrade = false,
    Rebirth = false,
    Gifts = false,
}

function GetLatestMob()
    local MobIndex = "1";

    for _, v in pairs(ReplicatedStorage.Mobs:GetChildren()) do
        if tonumber(v.Name) > 0 and v.Power.Value < LocalPlayer.Rock.Value then
           MobIndex = v.Name 
        end
    end

    return MobIndex
end

function GetNearestMob()
    local MobIndex = "1";
    local StartDist = 250

    for _, v in ipairs(Workspace.Mobs["1"]:GetChildren()) do
        local Distance = LocalPlayer:DistanceFromCharacter(v:GetPivot().Position)
    
        if Distance < StartDist then
            StartDist = Distance
            MobIndex = v.Name
        end
    end

    return MobIndex
end

function GetNearestWinterMob()
    local WinterMob = nil
    local StartDist = 100

    for _, v in ipairs(Workspace.EventMobs:GetChildren()) do
        local Distance = LocalPlayer:DistanceFromCharacter(v:GetPivot().Position)
    
        if Distance < StartDist then
            StartDist = Distance
            WinterMob = v
        end
    end

    return WinterMob
end

local function MoveTo(position)
    local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

    if Humanoid then
        Humanoid:MoveTo(position)
    end
end

local function DoWin(index)
    if os.clock() - Settings.Win.LastTime > 6 then
        ReplicatedStorage.RemoveC:FireServer(1)
        ReplicatedStorage.WinEvent:FireServer(index)
        ReplicatedStorage.RemoveC:FireServer(0)

        Settings.Win.LastTime = os.clock()
    end
end

local function GetPencil()
    local Pencil = nil

    for _, v in ipairs(ReplicatedStorage.Items.Pencil:GetChildren()) do
        if tonumber(v.Name) > 0 and v.Configuration.PowerReq.Value < LocalPlayer.Rock.Value then
            Pencil = v
        end
    end

    return Pencil
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("PS | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Click", {}, function(state)
    task.spawn(function()
        Settings.Click = state
        while true do
            if not Settings.Click then return end

            ReplicatedStorage.ClickEvent:FireServer("Click", false)
            ReplicatedStorage.GameClient.Events.RemoteEvent.ClickChangeEvent:FireServer(GetPencil())    
            task.wait(.1)
        end
    end)
end)

Window:Toggle("Auto Win [Highest Possib]", {}, function(state)
    task.spawn(function()
        Settings.Win.Enabled = state
        while true do
            if not Settings.Win.Enabled then return end

            DoWin(GetLatestMob());
            task.wait(1)
        end
    end)
end)

Window:Toggle("Auto Win [Nearest]", {}, function(state)
    task.spawn(function()
        Settings.Nearest = state
        while true do
            if not Settings.Nearest then return end

            DoWin(GetNearestMob());
            task.wait(1)
        end
    end)
end)

Window:Toggle("Auto Kill Winter Mobs", {}, function(state)
    task.spawn(function()
        Settings.WinterMobs = state
        while true do
            if not Settings.WinterMobs then return end
            
            local WinterEnemy = GetNearestWinterMob()

            if WinterEnemy then
                while Settings.WinterMobs and WinterEnemy.Parent and task.wait() do
                    MoveTo(WinterEnemy:GetPivot().Position);
                end
            end

            task.wait(.5)
        end
    end)
end)

Window:Toggle("Auto Damage Upgrade", {}, function(state)
    task.spawn(function()
        Settings.DamageUpgrade = state
        while true do
            if not Settings.DamageUpgrade then return end

            ReplicatedStorage.DamageUpgradeEvent:FireServer()
            task.wait(1)
        end
    end)
end)


Window:Toggle("Auto Rebirth", {}, function(state)
    task.spawn(function()
        Settings.Rebirth = state
        while true do
            if not Settings.Rebirth then return end

            ReplicatedStorage.GameClient.Events.RemoteEvent.RebirthEvent:FireServer()
            task.wait(2.5)
        end
    end)
end)

Window:Toggle("Auto Claim Gifts", {}, function(state)
    task.spawn(function()
        Settings.Gifts = state
        while true do
            if not Settings.Gifts then return end

            for _, v in ipairs(ReplicatedStorage.Gifts:GetChildren()) do
                ReplicatedStorage.GameClient.Events.RemoteEvent.ClaimGift:FireServer(v.Name); task.wait(.1)
            end

            task.wait(30)
        end
    end)
end)

Window:Button("Redeem codes", function()
    task.spawn(function()
        for _, v in ipairs(ReplicatedStorage.Codes:GetChildren()) do
            ReplicatedStorage.GameClient.Events.RemoteEvent.CodeEventSR:FireServer(v.Code.Value); task.wait(.1)
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