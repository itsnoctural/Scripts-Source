local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Card = {
        Enabled = false,
        Cooldown = false,
    },
}


-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("OBYOB | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Auto Win", {}, function(state)
    task.spawn(function()
        Settings.Card.Enabled = state
        while true do
            if not Settings.Card.Enabled then return end

            if not Settings.Card.Cooldown then
                local Checkpoints = Workspace.WorldMap.Checkpoints
                local Child = nil

                for i = 1, #Checkpoints:GetChildren() do
                    Child = Checkpoints[tostring(i)]

                    if Child then
                        firetouchinterest(Checkpoints[tostring(i)].Hitbox, LocalPlayer.Character.HumanoidRootPart, 0)
                        firetouchinterest(Checkpoints[tostring(i)].Hitbox, LocalPlayer.Character.HumanoidRootPart, 1); task.wait()
                    end
                end

                LocalPlayer.Character:PivotTo(Child:GetPivot())

                task.wait(.75)
                Settings.Card.Cooldown = true
                ReplicatedStorage.RemoteEvents.ReportReset:FireServer()
                
                task.spawn(function()
                    task.wait(26.5)
                    Settings.Card.Cooldown = false
                end)
            end

            task.wait(1)
        end
    end)
end)

Window:Toggle("Auto Event Card", {}, function(state)
    task.spawn(function()
        Settings.Card = state
        while true do
            if not Settings.Card then return end

            for _, v in ipairs(Workspace.ICC_PopUp_Package.RunCollectables:GetChildren()) do
                ReplicatedStorage.ICC_PopUp_Package.Packages.Knit.Services.PickupService.RF.Collect:InvokeServer(v); task.wait()
            end

            task.wait(2.75)
        end
    end)
end)

Window:Box('Bike 1 - 44', {}, function(var)
    task.spawn(function()
        local BikeNumber = tonumber(var) 
        if BikeNumber then
            ReplicatedStorage.RemoteEvents.PublishBike:FireServer("BikeType", BikeNumber); task.wait()
            ReplicatedStorage.RemoteEvents.ReportDeath:FireServer()
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