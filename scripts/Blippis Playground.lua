local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

local Packages = ReplicatedStorage.Packages._Index
local Knit = Packages:FindFirstChild("sleitnick_knit@1.5.3")

if not Knit then
    Knit = Packages:FindFirstChild("sleitnick_knit@1.6.0")
end

local Services = Knit.knit.Services

getgenv().Settings = {
    Tokens = false,
    Candy = false,
    Dig = false,
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("BP | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Farm Tokens", {}, function(state)
    task.spawn(function()
        Settings.Tokens = state
        while true do
            if not Settings.Tokens then return end

            Services.NPCService.RE.StartQuestFromDialogue:FireServer("FindTabbs"); task.wait(.1)

            for _, v in pairs(Workspace.ItemSpawners.HauntedHouseTabbs:GetChildren()) do
                firetouchinterest(v, game.Players.LocalPlayer.Character:FindFirstChildOfClass("Part"), 0)
                firetouchinterest(v, game.Players.LocalPlayer.Character:FindFirstChildOfClass("Part"), 1); task.wait()
            end

            task.wait(.1)
            
            Services.NPCService.RE.UpdateQuestFromDialogue:FireServer("TabbsBlippi", "FindTabbs", {["TALK"] = "TabbsBlippi"})

            task.wait(.5)
        end
    end)
end)

Window:Toggle("Auto Candy", {}, function(state)
    task.spawn(function()
        Settings.Candy = state
        while true do
            if not Settings.Candy then return end

            for _, v in ipairs(Workspace.Map.HalloweenHouses:GetChildren()) do
                Services.TricknTreatService.RE.GiveCandySignal:FireServer(v); task.wait(.1)
            end

            task.wait()
        end
    end)
end)

Window:Toggle("Auto Dig", {}, function(state)
    task.spawn(function()
        Settings.Dig = state
        while true do
            if not Settings.Dig then return end

            for _, v in ipairs(Workspace.DinoDig:GetChildren()) do
                for _, j in ipairs(v:GetChildren()) do
                    Services.DinoDigService.RF.BreakSlab:InvokeServer(j:GetAttribute("ID")); task.wait()
                end
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