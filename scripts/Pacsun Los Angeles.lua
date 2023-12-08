local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
game:GetService("CoreGui").PurchasePrompt.Enabled = false

getgenv().Settings = {
    Tycoon = false,
}

local function FireTouchTransmitter(touchParent)
    local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")

    if Character then
        firetouchinterest(Character, touchParent, 0)
        firetouchinterest(Character, touchParent, 1)
    end
end

local function GetTycoon()
    for _, v in ipairs(Workspace.Plots:GetChildren()) do
        local Owner = v:FindFirstChild("OwnerPlayer")

        if Owner and Owner.Value == LocalPlayer then
            return v
        end
    end

    return false
end

local Tycoon = GetTycoon()

task.spawn(function()
    while task.wait(1) do
        if not Tycoon then Tycoon = GetTycoon() end
    end
end)

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("PLST | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Tycoon", {}, function(state)
    task.spawn(function()
        Settings.Tycoon = state
        while true do
            if not Settings.Tycoon then return end

            for _, v in ipairs(Tycoon.Start:GetDescendants()) do
                if Settings.Tycoon and (v.Name == "TouchCollider" or v.Name == "ButtonTrigger") and v:FindFirstChildOfClass("TouchTransmitter") then

                    LocalPlayer.Character:PivotTo(v:GetPivot()); task.wait(.2)
                end
            end

            task.wait(2.5)
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