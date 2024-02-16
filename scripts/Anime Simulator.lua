local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Default = false,
    Elf = false,
}

local function FireTouchTransmitter(touchParent)
    local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")

    if Character then
        firetouchinterest(touchParent, Character, 0)
        firetouchinterest(touchParent, Character, 1)
    end
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("AS | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Candy", {}, function(state)
    task.spawn(function()
        Settings.Default = state
        while true do
            if not Settings.Default then return end

            for _, v in ipairs(Workspace.Candys:GetChildren()) do
                FireTouchTransmitter(v); task.wait()
            end

            task.wait()
        end
    end)
end)

Window:Toggle("Auto Elfs", {}, function(state)
    task.spawn(function()
        Settings.Elf = state
        while true do
            if not Settings.Elf then return end

            for _, v in ipairs(Workspace.ICEFolder.ICEModel:GetDescendants()) do
                if v:IsA("Model") and v.Name == "Elf" then
                    if v and v.Run then
                        local Root = v:FindFirstChild("HumanoidRootPart")

                        if v.Run.Value and Root then
                            LocalPlayer.Character:PivotTo(v:GetPivot()); task.wait()
                            fireproximityprompt(v.HumanoidRootPart.ProximityPrompt)
                        end
                    end
                end
            end

            task.wait(.1)

            for _, v in ipairs(Workspace.ICEFolder.ICEModel:GetChildren()) do
                if v.Health.Value ~= 0 then
                    LocalPlayer.Character:PivotTo(v:getPivot())
                    while v.Health.Value ~= 0 and task.wait(.1) do
                        ReplicatedStorage.Chirstmast.ICEEvent:FireServer(v, v.Health)
                    end
                end
            end

            task.wait(.5)
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
