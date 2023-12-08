local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Snowmen = false,
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("PnchMd | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Auto Snowmen", {}, function(state)
    task.spawn(function()
        Settings.Snowmen = state
        while true do
            if not Settings.Snowmen then return end

            for _, v in ipairs(Workspace.Ignore.Christmas:GetDescendants()) do
                if v:IsA("ProximityPrompt") and v.Parent then
                    LocalPlayer.Character:PivotTo(v.Parent:GetPivot()); task.wait(2)
                    fireproximityprompt(v);
                end
            end

            task.wait(4)
        end
    end)
end)

Window:Button("Snowmen ESP", function()
    task.spawn(function()
        for _, v in ipairs(Workspace.Ignore.Christmas:GetChildren()) do
            if v:FindFirstChild("Snowman") then
                local Highlight = Instance.new("Highlight")
                Highlight.Parent = v.Snowman
                Highlight.Adornee = v.Snowman
                Highlight.DepthMode = 0
            end
        end
    end)
end)

Window:Section("Anti-AFK - Enabled")

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