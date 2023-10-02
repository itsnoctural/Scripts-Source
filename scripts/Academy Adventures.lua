-- Link: https://www.roblox.com/games/14700018413/NEW-Academy-Adventures-The-Hunger-Games
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Birds = false,
    Guitars = false,
    Roses = false,
    Snakes = false,
    Classroom = false,
    Vault = false,
}

local SCAVENGER_ITEMS = Workspace["SCAVENGER_ITEMS"]

function FindScavengerItems(chapterName, folderName)
    if SCAVENGER_ITEMS:FindFirstChild(chapterName) and SCAVENGER_ITEMS[chapterName]:FindFirstChild(folderName) then
        for _, v in ipairs(SCAVENGER_ITEMS[chapterName][folderName]:GetChildren()) do
            LocalPlayer.Character:PivotTo((v:GetPivot() * CFrame.Angles(0, 0, math.rad(-90))) + Vector3.new(0, 7.5, 0)); task.wait(.5)
        end
    end
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("AA | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Collect Birds", {}, function(state)
    task.spawn(function()
        Settings.Birds = state
        while true do
            if not Settings.Birds then return end

            FindScavengerItems("Prologue", "collectedBirds");
            task.wait(2.5)
        end
    end)
end)

Window:Toggle("Collect Guitars", {}, function(state)
    task.spawn(function()
        Settings.Guitars = state
        while true do
            if not Settings.Guitars then return end

            FindScavengerItems("Prologue", "collectedGuitars");
            task.wait(2.5)
        end
    end)
end)

Window:Toggle("Collect Roses", {}, function(state)
    task.spawn(function()
        Settings.Roses = state
        while true do
            if not Settings.Roses then return end

            FindScavengerItems("Prologue", "collectedRoses");
            task.wait(2.5)
        end
    end)
end)

Window:Toggle("Collect Snakes", {}, function(state)
    task.spawn(function()
        Settings.Snakes = state
        while true do
            if not Settings.Snakes then return end

            FindScavengerItems("Prologue", "collectedSnakes");
            task.wait(2.5)
        end
    end)
end)


Window:Section("Corialonus Snow")

Window:Toggle("Collect Classroom Keys", {}, function(state)
    task.spawn(function()
        Settings.Classroom = state
        while true do
            if not Settings.Snakes then return end

            FindScavengerItems("Chapter1ClassroomKeys", "collectedClassroomKeys");
            task.wait(1)
        end
    end)
end)

Window:Toggle("Collect Vault Keys", {}, function(state)
    task.spawn(function()
        Settings.Vault = state
        while true do
            if not Settings.Snakes then return end

            FindScavengerItems("Chapter1VaultKeys", "collectedPaperVaultKeys");
            task.wait(1)
        end
    end)
end)

Window:Button("YouTube: EsohaSL", function()
   task.spawn(function()
        pcall(function()
            setclipboard("https://youtube.com/@esohasl")
        end)
   end)
end)

LocalPlayer.Idled:connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
    task.wait()
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
end)