-- Link: https://www.roblox.com/games/14700018413/NEW-Academy-Adventures-The-Hunger-Games
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Collect = false,
}

local SCAVENGER_ITEMS = Workspace["SCAVENGER_ITEMS"]

function FindScavengerItems()
    for _, v in ipairs(SCAVENGER_ITEMS:GetDescendants()) do
        if v:IsA("Part") or v:IsA("MeshPart") then
            LocalPlayer.Character:PivotTo((v:GetPivot() * CFrame.Angles(0, 0, math.rad(-90))) + Vector3.new(0, 7.5, 0)); task.wait(.5)
        end
    end 
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("AA | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Collect All", {}, function(state)
    task.spawn(function()
        Settings.Collect = state
        while true do
            if not Settings.Collect then return end

            FindScavengerItems();
            task.wait(1.5)
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