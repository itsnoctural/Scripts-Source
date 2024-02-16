local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Default = false,
}

local function GetNearestPlayer()
    local Player = nil;
    local StartDist = 50;

    for _, v in ipairs(Players:GetPlayers()) do
        if v ~= LocalPlayer then
            local Distance = LocalPlayer:DistanceFromCharacter(v.Character:GetPivot().Position)
        
            if Distance < StartDist then
                StartDist = Distance
                Player = v
            end
        end
    end

    return Player
end

local function EquipTool(tool)
    local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    
    if Humanoid then
        Humanoid:EquipTool(tool)
    end
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow(" | EsohaSL")

Window:Section("esohasl.net")

-- Window:Toggle("Auto Kill", {}, function(state)
--     task.spawn(function()
--         Settings.Default = state
--         while true do
--             if not Settings.Default then return end

--             local Sword = LocalPlayer.Character:FindFirstChildOfClass("Tool")

--             if Sword and Sword:FindFirstChild("Handle") then
--                 local NearestEnemy = GetNearestPlayer()

--                 if NearestEnemy then
--                     Sword:Activate()
--                     firetouchinterest(Sword.Handle, NearestEnemy.Character.HumanoidRootPart, 1); task.wait()
--                     firetouchinterest(Sword.Handle, NearestEnemy.Character.HumanoidRootPart, 0)
--                 end
--             end

--             task.wait()
--         end
--     end)
-- end)

Window:Toggle("Auto Kill", {}, function(state)
        task.spawn(function()
            Settings.Default = state
            while true do
                if not Settings.Default then return end

                local Sword = LocalPlayer.Backpack:FindFirstChild("ClassicSword")
    
                if Sword then
                    EquipTool(Sword)
                else
                    local EquippedSword = LocalPlayer.Character:FindFirstChild("ClassicSword")

                    if EquippedSword then
                        local NearestEnemy = GetNearestPlayer()

                        if NearestEnemy then
                            while EquippedSword.Parent and NearestEnemy.Character and task.wait() do
                                EquippedSword:Activate()
                                firetouchinterest(EquippedSword.Handle, NearestEnemy.Character.HumanoidRootPart, 1);
                                firetouchinterest(EquippedSword.Handle, NearestEnemy.Character.HumanoidRootPart, 0)
                            end
                        end
                    end
                end

                
    
                task.wait()
            end
        end)
    end)

Window:Button("Teleport to Top", function()
    task.spawn(function()
        LocalPlayer.Character:PivotTo(Workspace.Top:GetPivot())
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