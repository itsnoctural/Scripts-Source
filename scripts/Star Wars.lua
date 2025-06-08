loadstring(game:HttpGet("https://raw.githubusercontent.com/itsnoctural/Utilities/main/base.lua"))()

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:service("VirtualInputManager")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Default = false,
}

local Meta = nil;

local Platform = Workspace:FindFirstChild("esohasl")

if not Platform then
    Platform = Instance.new("Part")
    Platform.Name = "esohasl"
    Platform.Anchored = true
    Platform.Parent = Workspace
    Platform.Size = Vector3.new(50,1,50)
    Platform.Position = LocalPlayer.Character:GetPivot().Position + Vector3.new(0, 500, 0)
end

local function GetCDLabel()
    for _,v in ipairs(CoreGui:GetChildren()) do
        if v.Name == "ScreenGui" then
            for _,z in ipairs(v:GetDescendants()) do
                if z:IsA("TextLabel") and string.find(z.Text, "CD") then
                    return z
                end
            end
        end
    end

    return nil
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("SW | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Rob Bank", {}, function(state)
    task.spawn(function()
        Settings.Default = state
        while true do
            if not Settings.Default then return end

            if LocalPlayer.Team == "Resistance" then
                if Meta and not Meta.Data then
                    LocalPlayer.Character:PivotTo(Workspace.Misc.NPCs.Bank.Prompt:GetPivot()); task.wait(1)
                    ReplicatedStorage.Remotes.Functions.Bank:InvokeServer("StartRobbery"); task.wait(5)

                    for i, v in pairs(Workspace.Misc.Bank.Cash:GetChildren()) do
                        if i == 4 then break; end

                        LocalPlayer.Character:PivotTo(v:GetPivot()); task.wait(1)

                        VirtualInputManager:SendKeyEvent(true, 101, false, v.ProximityPrompt)
                        task.wait(5.25)
                        VirtualInputManager:SendKeyEvent(false, 101, false, v.ProximityPrompt); task.wait(.5)
                    end

                    LocalPlayer.Character:PivotTo(Platform:GetPivot() + Vector3.new(0, 5, 0))
                end
            else
                ReplicatedStorage.Remotes.Functions.RoundController:InvokeServer("LeaveTeam"); task.wait(.1)
                ReplicatedStorage.Remotes.Functions.RoundController:InvokeServer("JoinTeam", 2)

                StarterGui:SetCore("SendNotification", {
                    Title = "You can rob bank only in Resistance team.",
                    Text = ""
                }); task.wait(5)
            end

            task.wait(1)
        end
    end)
end)

Window:Section("CD (s): 0")

task.spawn(function()
    while task.wait(2) do
        local Label = GetCDLabel()

        if Label then
            local LastRobbery = ReplicatedStorage.Remotes.Functions.Bank:InvokeServer("GetLastRobbery")
            Meta = LastRobbery

            if LastRobbery then 
                Label.Text = string.format("CD (s): %i", typeof(LastRobbery.Data) == "number" and LastRobbery.Data or 0)
            else
                Label.Text = "CD (s): 0"
            end
        end
    end
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