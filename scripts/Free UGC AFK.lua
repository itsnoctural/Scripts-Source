local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Points = false,
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("FUA | EsohaSL")

for _, v in ipairs(Workspace:GetChildren()) do
    if v.Name == "Bench" then
        v:Destroy()
    end
end

function GetClosestCoin()
    local ClosestCoin = nil
    local StartDist = 250

    for _, v in ipairs(Workspace.Coins:GetChildren()) do
        local Distance = LocalPlayer:DistanceFromCharacter(v.Position)
    
        if Distance < StartDist then
            StartDist = Distance
            ClosestCoin = v
        end
    end

    return ClosestCoin
end

Window:Section("esohasl.com")

Window:Toggle("Auto Points", {}, function(state)
    task.spawn(function()
        Settings.Points = state
        while true do
            if not Settings.Points then return end

            local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid") 
            local Coin = GetClosestCoin()

            if Humanoid and Coin then
                Humanoid:MoveTo(GetClosestCoin():GetPivot().Position)
                Humanoid.MoveToFinished:Wait()
            end

            task.wait(.1)
        end
    end)
end)

Window:Slider("Walk Speed", {min = 16, max = 25}, function(v)
    task.spawn(function()
        local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

        if Humanoid then
            Humanoid.WalkSpeed = v
        end
    end)
end)

Window:Section("Anti-AFK Enabled.")

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