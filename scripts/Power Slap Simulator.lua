local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Win = false,
    Rebirth = false,
}

local Battle50 = Workspace:FindFirstChild("Battles").Battle50:FindFirstChild("Top")

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("PSS | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Auto Win", {}, function(state)
    task.spawn(function()
        Settings.Win = state
        while true do
            if not Settings.Win then return end

            if LocalPlayer:DistanceFromCharacter(Battle50.Position) > 10 then
                LocalPlayer.Character:PivotTo(Battle50:GetPivot() + Vector3.new(0, 1, 0)); task.wait(.35)
                fireproximityprompt(Battle50.ProximityPrompt);
            end

            ReplicatedStorage.Remotes.Client:InvokeServer("Wins")
            task.wait()
        end
    end)
end)

Window:Toggle("Auto Rebirth", {}, function(state)
    task.spawn(function()
        Settings.Rebirth = state
        while true do
            if not Settings.Rebirth then return end

            ReplicatedStorage.Remotes.Rebirth:FireServer();
            task.wait(1)
        end
    end)
end)

Window:Button("Infinite Power", function()
    task.spawn(function()
        ReplicatedStorage.Remotes.Client:InvokeServer("ClickStat", 9.e+99)
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