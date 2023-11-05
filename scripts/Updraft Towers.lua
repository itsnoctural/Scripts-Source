local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Win = false,
    Orbs = false,
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("UT | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Auto Win", {}, function(state)
    task.spawn(function()
        Settings.Win = state
        while true do
            if not Settings.Win then return end

            for _, v in ipairs(Workspace.Map.Tower:GetDescendants()) do
                if v.Name == "Won" and v:IsA("Part") then
                    firetouchinterest(v, LocalPlayer.Character.HumanoidRootPart, 0)
                    firetouchinterest(v, LocalPlayer.Character.HumanoidRootPart, 1)
                end
            end

            task.wait()
        end
    end)
end)

Window:Toggle("Auto Collect Orbs", {}, function(state)
    task.spawn(function()
        Settings.Orbs = state
        while true do
            if not Settings.Orbs then return end

            for _, v in ipairs(Workspace.Map.Tower:GetChildren()) do
                for _, z in ipairs(v:GetChildren()) do
                    if z.Name == "Coins" then
                        for _, j in ipairs(z:GetChildren()) do
                            firetouchinterest(j.CoreIn, LocalPlayer.Character.HumanoidRootPart, 0)
                            firetouchinterest(j.CoreIn, LocalPlayer.Character.HumanoidRootPart, 1);
                        end
                    end
                end
            end

            task.wait()
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