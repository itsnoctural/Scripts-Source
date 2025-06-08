loadstring(game:HttpGet("https://raw.githubusercontent.com/itsnoctural/Utilities/main/base.lua"))()

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")

local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Colors = {
    ["Hider"] = Color3.new(0, 255, 0),
    ["Seeker"] = Color3.new(255, 0, 0),
}

getgenv().Settings = {
    Infinite = false,
    Coins = false,
    Hiders = false,
    Seekers = false,
}

local function FireTouchTransmitter(touchParent)
    local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")
  
    if Character then
        firetouchinterest(touchParent, Character, 0)
        firetouchinterest(touchParent, Character, 1)
    end
end

function ConnectESP(item)
    local DrawingText = Drawing.new("Text")
    DrawingText.Visible = false
    DrawingText.Center = true
    DrawingText.Outline = true
    DrawingText.Color = Color3.fromRGB(255, 255, 255)
    DrawingText.Size = 16

    local SteppedRender
    SteppedRender = RunService.RenderStepped:Connect(function()
        if item and item.Character then
            local CurrentTeam = item:GetAttribute("CurrentTeam")
            local itemPosition, itemScreen = Camera:WorldToViewportPoint(item.Character:GetPivot().Position)

            if itemScreen and ( (Settings.Hiders and CurrentTeam == "Hider") or (Settings.Seekers and CurrentTeam == "Seeker") ) then
                DrawingText.Position = Vector2.new(itemPosition.X, itemPosition.Y)
                DrawingText.Text = item.Name
                DrawingText.Color = Colors[CurrentTeam]
                DrawingText.Visible = true
            else 
                DrawingText.Visible = false
            end
        else
            DrawingText.Visible = false
            DrawingText:Remove()
            SteppedRender:Disconnect()
        end
    end)
end

for _, v in ipairs(Players:GetPlayers()) do 
    ConnectESP(v)
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow(" | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Inf. Coins and Crates", {}, function(state)
    task.spawn(function()
        Settings.Infinite = state
        while true do
            if not Settings.Infinite then return end

            for i = 1, 30 do
                ReplicatedStorage.Network.rewards.claim_pass:FireServer("base", i); task.wait()
            end

            task.wait(.1)
        end
    end)
end)

Window:Toggle("Hiders ESP", {}, function(state)
    task.spawn(function()
        Settings.Hiders = state
    end)
end)

Window:Toggle("Seekers ESP", {}, function(state)
    task.spawn(function()
        Settings.Seekers = state
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