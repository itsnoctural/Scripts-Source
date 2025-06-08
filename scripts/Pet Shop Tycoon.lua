local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Sell = false,
}

local function GetTycoon()
    for _,v in ipairs(Workspace.Map.Tycoons:GetChildren()) do
        if string.find(v.Name, LocalPlayer.Name) then
            return v
        end
    end

    return nil
end

local Tycoon = GetTycoon()

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("PST | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Sell", {}, function(state)
    task.spawn(function()
        Settings.Sell = state
        while true do
            if not Settings.Sell then return end

            for _,v in ipairs(Tycoon:GetChildren()) do
                if v.Name == "RockContainer" then
                    LocalPlayer.Character:PivotTo(v.PromptPart:GetPivot()); task.wait(.35)
                    fireproximityprompt(v.PromptPart.ProximityPrompt); task.wait(.5)

                    local NPCs = Workspace.Npcs:GetChildren()

                    for i = 1, 2 do
                        LocalPlayer.Character:PivotTo(NPCs[i]:GetPivot() + Vector3.new(0, 5, 0)); task.wait(.35)
                        fireproximityprompt(NPCs[i].HumanoidRootPart.ProximityPrompt); task.wait(.5)
                    end
                end
            end

            task.wait(15)
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

LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
    task.wait()
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
end)