-- Link: https://www.roblox.com/games/14518789199/Obby-But-Youre-on-a-Pogo-Stick
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Stage = false,
    LuckyBlock = false,
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("OBYPS | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Auto Stage", {}, function(state)
    task.spawn(function()
        Settings.Stage = state
        while true do
            if not Settings.Stage then return end

            for i = 1, 100 do
                local Model = Workspace.Map.SavePoints:FindFirstChild(tostring(i))
                while Settings.Stage and Model and Model.Status.Color.R == 1 do
                    LocalPlayer.Character:PivotTo(Model:GetPivot()); task.wait(.25)
                end
            end

            task.wait(.5)
        end
    end)
end)

Window:Toggle("Auto Lucky Block", {}, function(state)
    task.spawn(function()
        Settings.LuckyBlock = state
        while true do
            if not Settings.LuckyBlock then return end

            ReplicatedStorage.Packages._Index["sleitnick_knit@1.5.1"].knit.Services.LuckyBlock.RE.OpenLuckyBlock:FireServer();
            task.wait(5)
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