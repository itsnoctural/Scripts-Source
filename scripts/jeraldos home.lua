local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Default = false,
    Delay = 0,
}

local function selectCat()
    local cats = {}

    for _,v in ipairs(Workspace:GetChildren()) do
        if v:IsA("MeshPart") and v:FindFirstChildOfClass("ProximityPrompt") and v:FindFirstChildOfClass("Script") and LocalPlayer:DistanceFromCharacter(v.Position) < 100 then
            table.insert(cats, v);
        end
    end

    return cats[math.random(1, #cats)]
end

local Kitty = selectCat()
local Proximity = Kitty:FindFirstChildOfClass("ProximityPrompt")

task.spawn(function()
    while task.wait(.5) do
        if not Kitty then Kitty = selectCat(); return end
    end
end)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("jh | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Kitty", {}, function(state)
    task.spawn(function()
        Settings.Default = state
        while true do
            if not Settings.Default then return end

            fireproximityprompt(Proximity); task.wait(Settings.Delay)
        end
    end)
end)

Window:Box('Click Delay', {}, function(input)
    task.spawn(function()
        Settings.Delay = tonumber(input)
    end)
end)

Window:Button("Teleport to Kitty", function()
    task.spawn(function()
        LocalPlayer.Character:PivotTo(Kitty:GetPivot())
    end)
end)

Window:Button("Remove Map", function()
    task.spawn(function()
        local Map = Workspace:FindFirstChild("Map")

        if Map then Map:Destroy() end
    end)
end)

Window:Button("Remove Kitty's", function()
    task.spawn(function()
        for _,v in ipairs(Workspace:GetChildren()) do
            if v:IsA("MeshPart") and v:FindFirstChildOfClass("ProximityPrompt") and v:FindFirstChildOfClass("Script") and v ~= Kitty then
                v:Destroy(); task.wait()
            end
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