local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local PathfindingService = game:GetService("PathfindingService")

local Path = PathfindingService:CreatePath({
    WaypointSpacing = 2,
})

local LocalPlayer = Players.LocalPlayer
local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

local PlayerGui = LocalPlayer.PlayerGui
local SellFrame = PlayerGui.MainScreenGui.SellAnimFrame

local Sneakers = require(ReplicatedStorage.SneakerModule).sneakers

table.foreach(require(game.ReplicatedStorage.SneakerModule).sneakers["Adios Samba Black"], print)

getgenv().Settings = {
    Sell = false,
    Buy = {
        Enabled = false,
        Blacklist = {
            Common = false,
            Uncommon = false,
        }
    },
    Buttons = false,
}

local function FireTouchTransmitter(touchParent)
    local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")

    if Character then
        firetouchinterest(touchParent, Character, 0)
        firetouchinterest(touchParent, Character, 1)
    end
end

local function pathFindingTo(destination)
    local isSuccess, errorMessage = pcall(function()
        Path:ComputeAsync(LocalPlayer.Character:GetPivot().Position, destination)
    end)

    if isSuccess and Path.Status == Enum.PathStatus.Success then
        local Waypoints = Path:GetWaypoints()

        for i = 2, #Waypoints - 2 do
            Humanoid:MoveTo(Waypoints[i].Position)
            Humanoid.MoveToFinished:Wait()
        end
    end
end

local function getNearestNPC()
    local Nearest = nil
    local StartDist = 500

    for _,v in ipairs(Workspace.NPCFolder:GetChildren()) do
        local Distance = LocalPlayer:DistanceFromCharacter(v:GetPivot().Position)
                
        if Distance < StartDist then
            StartDist = Distance
            Nearest = v
        end
    end

    return Nearest
end

local function sellToNPC()
    local NPC = getNearestNPC()

    pathFindingTo(NPC:GetPivot().Position)

    local Proximity = NPC:FindFirstChildOfClass("ProximityPrompt")

    if Proximity then
        fireproximityprompt(Proximity)
    end
end

local function getStore()
    return Workspace.Stores:FindFirstChild(LocalPlayer.Name .. "Store")
end

local Store = getStore()

task.spawn(function()
    while not Store and task.wait(.5) do Store = getStore() end
end)

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("SRS | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Sell", {}, function(state)
    task.spawn(function()
        Settings.Sell = state
        while true do
            if not Settings.Sell then return end

            if SellFrame.Visible then
                local LinePos = SellFrame.BarAndLine.Line.AbsolutePosition.X
        
                local Perfect = SellFrame.BarAndLine.ExtraBarFrame.LineColorsFrame["COLORX_Perfect"]
                local PerfSize = Perfect.AbsoluteSize.X
                local PerfPos = Perfect.AbsolutePosition.X
        
                if LinePos > PerfPos - PerfSize / 2 and LinePos < PerfPos + PerfSize / 2  then
                    firesignal(SellFrame.StopButton.MouseButton1Down);
                end
            else 
                sellToNPC() 
            end

            task.wait()
        end
    end)
end)

Window:Toggle("Auto Buttons", {}, function(state)
    task.spawn(function()
        Settings.Buttons = state
        while true do
            if not Settings.Buttons then return end

            for _,v in ipairs(Store:GetChildren()) do
                if v:IsA("Part") and string.find(v.Name, "Button") then
                    FireTouchTransmitter(v); task.wait(.25)
                end
            end

            task.wait(2.5)
        end
    end)
end)

Window:Toggle("Auto Buy Sneakers", {}, function(state)
    task.spawn(function()
        Settings.Buy.Enabled = state
        while true do
            if not Settings.Buy.Enabled then return end

            local Items = ReplicatedStorage.RemoteEvents.RefreshPageFunction:InvokeServer()

            for i,v in pairs(Items) do
                if Sneakers[v] then
                    if Settings.Buy.Blacklist.Common and Sneakers[v].Rarity == "Common" then continue; 
                    elseif Settings.Buy.Blacklist.Uncommon and Sneakers[v].Rarity == "Uncommon" then continue; end

                    ReplicatedStorage.RemoteEvents.BuySneakerFunction:InvokeServer("Offer" .. i); task.wait(.1)
                end
            end

            task.wait(1)
        end
    end)
end)

Window:Section("Buy Blacklist")

Window:Toggle("Common", {}, function(state)
    task.spawn(function()
        Settings.Buy.Blacklist.Common = state
    end)
end)

Window:Toggle("Uncommon", {}, function(state)
    task.spawn(function()
        Settings.Buy.Blacklist.Uncommon = state
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