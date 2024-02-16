local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

local function getCarnivalQuest()
    for _, v in ipairs(LocalPlayer.PlayerGui:WaitForChild("Challenges").ChallengesPane:WaitForChild("wrapper").body:GetDescendants()) do
        if v.Name == "example_ugc_quest_2" then
            return v;
        end
    end
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("SdJU | EsohaSL")

Window:Section("esohasl.net")

task.spawn(function()
    local quest = getCarnivalQuest()

    while task.wait(1) do
        if quest then
            quest:WaitForChild("wrapper").soldOut.Visible = false
        else
            quest = getCarnivalQuest()
        end
    end
end)

Window:Button("Teleport to Carnival", function()
    task.spawn(function()
        LocalPlayer.Character:PivotTo(CFrame.new(165, -45, -175))
    end)
end)

Window:Button("Claim Fruit Hat", function()
    task.spawn(function()
        ReplicatedStorage.Remotes.UGC_BuyFunction:InvokeServer("Fruit Hat")
    end)
end)

Window:Section("Credits")

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