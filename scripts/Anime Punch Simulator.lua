local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Yen = false,
    Power = false,
    Rebirth = false,
}

local Rewards ={
    Yen = {3,4,8},
    Power = {1,2,7,9}
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("APS | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Auto Rebirth", {}, function(state)
    task.spawn(function()
        Settings.Rebirth = state
        while true do
            if not Settings.Rebirth then return end

            ReplicatedStorage.Resources.Packages.Knit.Services.RankService.RE.RankUp:FireServer()
            task.wait(.5)
        end
    end)
end)

Window:Section("Wait for rewards be available")

Window:Toggle("Inf. Yen", {}, function(state)
    task.spawn(function()
        Settings.Yen = state
        while true do
            if not Settings.Yen then return end

            for _, v in ipairs(Rewards.Yen) do
                ReplicatedStorage.Resources.Packages.Knit.Services.GiftsService.RF.Claim:InvokeServer(v)
            end

            task.wait()
        end
    end)
end)

Window:Toggle("Inf. Power", {}, function(state)
    task.spawn(function()
        Settings.Power = state
        while true do
            if not Settings.Power then return end

            for _, v in ipairs(Rewards.Power) do
                ReplicatedStorage.Resources.Packages.Knit.Services.GiftsService.RF.Claim:InvokeServer(v)
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