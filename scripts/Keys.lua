-- Services
local Services = {
    Workspace = game:GetService("Workspace"),
    Players = game:GetService("Players"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    VirtualUser = game:GetService("VirtualUser")
}


-- Player
local LocalPlayer = Services.Players.LocalPlayer

local Paths = {
    Maps = Services.Workspace.Maps,
    GamePlayers = Services.Workspace.Game.GamePlayers,
    RemotesFolder = Services.ReplicatedStorage.Remotes
}

local Remotes = {
    GamePlayer = Paths.RemotesFolder.GamePlayerRE,
    PlayerBackpack = Paths.RemotesFolder.PlayerBackpackRE
}

-- Settings
getgenv().Settings = {
    AutoFarm = {
        Enabled = false,

        UnlockDoors = false,
        PickupKeys = false,
        JoinGame = false
    }
}


-- Functions
local Functions = {}


-- Basic
function Functions:IsInGame()
    return (LocalPlayer:GetAttribute("PlayerState") == "InGame" and LocalPlayer:GetAttribute("SurvivalState") == "Alive")
end

function Functions:JoinGame()
    Remotes.GamePlayer:FireServer("JoinGame")
end

function Functions:Teleport(dest)
    if LocalPlayer.Character and LocalPlayer.Character.Parent ~= nil then
        LocalPlayer.Character:PivotTo(dest)
    end
end

-- Doors
function Functions:UnlockDoor()
    for _, v in pairs(Paths.Maps:GetDescendants()) do
        if v.Parent ~= nil and v.Name == "ExitRoot" and v:FindFirstChildOfClass("TouchTransmitter") then
            Functions:Teleport(v.Parent:GetPivot()); return
        elseif v:IsA("ProximityPrompt") then
            local vParent = v.Parent
            local Model = vParent.Parent
            local Folder = Model.Parent

            if Folder.Name == "ItemPlace" and vParent.Name == "ControlPart" then
                if LocalPlayer:DistanceFromCharacter(vParent.Position) > 10 then
                    Functions:Teleport(Model:GetPivot()); task.wait(.1)
                end
                fireproximityprompt(v); return
            end
        end
    end
end


-- Keys
function Functions:HasKey()
    return LocalPlayer.Backpack:FindFirstChild("SecretKey")
end

function Functions:IsHoldKey()
    return LocalPlayer.Character:FindFirstChildOfClass("Tool")
end

function Functions:PickupKey()
    for _, v in pairs(Paths.Maps:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            local vParent = v.Parent

            if vParent:IsA("Part") and vParent.Name == "Point_1" then
                if LocalPlayer:DistanceFromCharacter(vParent.Position) > 10 then
                    Functions:Teleport(vParent:GetPivot()); task.wait(.1)
                end
                fireproximityprompt(v); break
            end
        end
    end
end

function Functions:CheckKey()
    local IsHas = self:HasKey()
    local IsHold = self:IsHoldKey()

    if IsHas then
        Remotes.PlayerBackpack:FireServer("UseInGameTool", {["ToolId"] = "SecretKey"}); return false
    end

    if not IsHold or IsHold.Name ~= "SecretKey" then
        self:PickupKey(); return false
    end

    return true
end


-- User Interface
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("Keys | EsohaSL")

Window:Toggle("AutoFarm", {}, function(state)
    task.spawn(function()
        Settings.AutoFarm.Enabled = state
        while true do
            if not Settings.AutoFarm.Enabled then return end
            
            if Functions:IsInGame() then
                local HasKey;
                if Settings.AutoFarm.PickupKeys then
                    HasKey = Functions:CheckKey(); task.wait()
                end

                if Settings.AutoFarm.UnlockDoors and HasKey then
                    Functions:UnlockDoor()
                end
            else
                if Settings.AutoFarm.JoinGame then
                    if not JoinThread or coroutine.status(JoinThread) == "dead" then
                        JoinThread = task.spawn(function()
                            Functions:JoinGame(); task.wait(10)
                        end)
                    end
                end
            end

            task.wait(.1)
        end
    end)
end)

Window:Section("Config")

Window:Toggle("Unlock Doors", {}, function(state)
    task.spawn(function()
        Settings.AutoFarm.UnlockDoors = state
    end)
end)

Window:Toggle("Pickup Keys", {}, function(state)
    task.spawn(function()
        Settings.AutoFarm.PickupKeys = state
    end)
end)

Window:Toggle("Join Game", {}, function(state)
    task.spawn(function()
        Settings.AutoFarm.JoinGame = state
    end)
end)

Window:Button("YouTube: EsohaSL", function()
    pcall(function()
        setclipboard("https://www.youtube.com/@esohasl")
    end)
end)

LocalPlayer.Idled:Connect(function()
    Services.VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait()
    Services.VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)
