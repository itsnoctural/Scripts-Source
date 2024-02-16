local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Default = false,
    Pickup = false,
    Delay = 1,
    Eggs = false,
    Area = "1",
    Type = "basic",
    Quantity = "1"
}

local Nodes = nil
for _, v in ipairs(Workspace:GetChildren()) do if v.Name == "Nodes" and #v:GetChildren() > 0 then Nodes = v; break end end

local function GetNearest()
    local Nearest = nil
    local StartDist = 100

    for _, v in ipairs(Nodes:GetChildren()) do
        local Distance = LocalPlayer:DistanceFromCharacter(v:GetPivot().Position)
    
        if Distance < StartDist then
            StartDist = Distance
            Nearest = v
        end
    end

    return Nearest
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("SpngbS | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Attack", {}, function(state)
    task.spawn(function()
        Settings.Default = state
        while true do
            if not Settings.Default then return end

            local Nearest = GetNearest()

            if Nearest then
                ReplicatedStorage.Knit.Services.NodeService.RE.NodeClicked:FireServer(Nearest, true, false)
            end

            task.wait(Settings.Delay)
        end
    end)
end)

Window:Slider("Attack Delay", {min = 0.1, max = 10, default = 1}, function(v)
    task.spawn(function()
        Settings.Delay = v
    end)
end)

Window:Toggle("Auto Pickup", {}, function(state)
    task.spawn(function()
        Settings.Pickup = state
        while true do
            if not Settings.Pickup then return end

            for _, v in ipairs(Workspace.Terrain:GetChildren()) do        
                if string.find(v.Name, "Currency") then
                    LocalPlayer.Character:PivotTo(v.CFrame); task.wait(.25)                    
                end
            end

            task.wait(1)
        end
    end)
end)

Window:Toggle("Auto Eggs", {}, function(state)
    task.spawn(function()
        Settings.Eggs = state
        while true do
            if not Settings.Eggs then return end

            ReplicatedStorage.Knit.Services.VendorService.RF.Purchase:InvokeServer("area" .. Settings.Area .. " " .. Settings.Type, tonumber(Settings.Quantity))  

            task.wait(4)
        end
    end)
end)

Window:Dropdown("Areas", {list = {"1", "2", "3", "4", "5", "6", "7", "8", "9"}}, function(var)
    task.spawn(function()
        Settings.Area = var
    end)
end)

Window:Dropdown("Type", {list = {"basic", "golden"}}, function(var)
    task.spawn(function()
        Settings.Type = var
    end)
end)

Window:Dropdown("Quantity", {list = {"1", "3", "8"}}, function(var)
    task.spawn(function()
        Settings.Quantity = var
    end)
end)

LocalPlayer.Idled:connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
    task.wait()
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
end)