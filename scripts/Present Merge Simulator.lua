local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Merge = false,
    Click = false,
    Tier = false,
    Rate = false,
    Presents = false,
}

local PlayerArea = LocalPlayer.PlayerArea.Value

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("PMS | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Auto Merge", {}, function(state)
    task.spawn(function()
        Settings.Merge = state
        while true do
            if not Settings.Merge then return end

            local FirstPresent = nil
            local SecondPresent = nil

            for _, v in ipairs(PlayerArea.Items:GetChildren()) do
                local vLevel, vCollider = v:GetAttribute("Order"), v:FindFirstChild("Collider")
                for _, j in ipairs(PlayerArea.Items:GetChildren()) do
                    local jLevel, jCollider = j:GetAttribute("Order"), j:FindFirstChild("Collider")

                    if vCollider and jCollider and vLevel == jLevel then
                        firetouchinterest(vCollider, jCollider, 0); task.wait()
                        firetouchinterest(vCollider, jCollider, 1)
                    end
                end
            end

            task.wait(.25)
        end
    end)
end)

Window:Toggle("Auto Click Presents", {}, function(state)
    task.spawn(function()
        Settings.Click = state
        while true do
            if not Settings.Click then return end

            for _, v in ipairs(PlayerArea.Items:GetChildren()) do
                ReplicatedStorage.Modules.Weave.Remotes.ClickGain:FireServer(v:GetAttribute("ID")); task.wait()
            end

            task.wait()
        end
    end)
end)

Window:Toggle("Auto Spawn Tier", {}, function(state)
    task.spawn(function()
        Settings.Tier = state
        while true do
            if not Settings.Tier then return end

            ReplicatedStorage.Modules.Weave.Remotes.BuyUpgrade:FireServer("SpawnTier")
            task.wait(.35)
        end
    end)
end)

Window:Toggle("Auto Spawn Rate", {}, function(state)
    task.spawn(function()
        Settings.Rate = state
        while true do
            if not Settings.Rate then return end

            ReplicatedStorage.Modules.Weave.Remotes.BuyUpgrade:FireServer("SpawnRate")
            task.wait(.35)
        end
    end)
end)

Window:Toggle("Auto Max Presents", {}, function(state)
    task.spawn(function()
        Settings.Presents = state
        while true do
            if not Settings.Presents then return end

            ReplicatedStorage.Modules.Weave.Remotes.BuyUpgrade:FireServer("MaxBlocks")
            task.wait(.35)
        end
    end)
end)

Window:Toggle("Auto Rebirth", {}, function(state)
    task.spawn(function()
        Settings.Rebirth = state
        while true do
            if not Settings.Rebirth then return end

            ReplicatedStorage.Modules.Weave.Remotes.BuyUpgrade:FireServer("Rebirth")
            task.wait(5)
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