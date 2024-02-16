local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Explode = false,
}

local TempExploded = {}

local function GetNearestPart()
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("Part") and v.CanCollide and not table.find(TempExploded, v) then
            if v.Size.X > 10 and v.Size.Y > 10 then
                table.insert(TempExploded, v)
                return v
            end
        end
    end

    return false
end

task.spawn(function()
    while task.wait(30) do
        TempExploded = {}
    end
end)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("ENS | EsohaSL")

Window:Toggle("Auto Explode Nearest", {}, function(state)
    task.spawn(function()
        Settings.Explode = state
        while true do
            if not Settings.Explode then return end

            local NearestPart = GetNearestPart()
            local Tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")

            print(NearestPart)
            print(Tool)

            if NearestPart and Tool then
                LocalPlayer.Character:PivotTo(NearestPart:GetPivot()); task.wait()
                Tool:Activate()
            end

            task.wait(.1)
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

-- local function GetNearestPart()
--     local Part = nil
--     local StartDist = 100

--     for _, v in ipairs(Workspace:GetChildren()) do
--         if v:IsA("Part") then
--             local Distance = LocalPlayer:DistanceFromCharacter(v:GetPivot().Position)
        
--             if Distance < StartDist then
--                 StartDist = Distance
--                 Part = v
--             end
--         end
--     end

--     return Part
-- end