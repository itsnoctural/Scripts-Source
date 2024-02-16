local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Crates = false,
}

local CratesFolder = Workspace["Game Systems"]["UGC Crates"]
local CratesPositions = {
    ["Crate12"] = Vector3.new(-2450.72, 68.3661, -2512.9),
    ["Crate13"] = Vector3.new(-61.2052, 52.7405, 2864.62),
    ["Crate14"] = Vector3.new(-5.58545, 77.331, 3439.26),
    ["Crate15"] = Vector3.new(69.217, 103.43, 3402.34),
    ["Crate16"] = Vector3.new(-29.5, 207.75, 3175.25),
    ["Crate17"] = Vector3.new(31.75, 103, -2081),
    ["Crate18"] = Vector3.new(53.35, 46.95, -2007),
    ["Crate34"] = Vector3.new(1961.68, 76.4805, -936.539),
    ["Crate38"] = Vector3.new(1943.66, 63.8802, 70.241),
}

local function FireCollect(part)
    LocalPlayer.Character:PivotTo(part:GetPivot()); task.wait(.35)

    local Prompt = part:FindFirstChildOfClass("ProximityPrompt")
    if Prompt then fireproximityprompt(Prompt) end
end

local function FindByKey(table, value)
    for i, v in pairs(table) do
        if i == value then 
            return true 
        end
    end

    return false
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("WT | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Find Crates", {}, function(state)
    task.spawn(function()
        Settings.Crates = state
        while true do
            if not Settings.Crates then return end

            local Fired = 0

            for _, v in ipairs(CratesFolder:GetChildren()) do
                local Mesh = v:FindFirstChildOfClass("MeshPart") 

                if Mesh then
                    FireCollect(Mesh)
                    Fired = Fired + 1
                end
            end

            if Fired == 0 then
                for _, j in ipairs(CratesFolder:GetChildren()) do
                    if FindByKey(CratesPositions, j.Name) then
                        LocalPlayer.Character:PivotTo(CFrame.new(CratesPositions[j.Name])); task.wait(.5)

                        local Mesh = j:FindFirstChildOfClass("MeshPart")
                        if Mesh then
                            local Prompt = Mesh:FindFirstChildOfClass("ProximityPrompt")

                            if Prompt then fireproximityprompt(Prompt) end
                        end
                    end
                end
            end

            task.wait(1)
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