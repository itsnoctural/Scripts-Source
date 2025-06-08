local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

getgenv().Settings = {
    Default = false,
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("SL | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Fast Auto Click", {}, function(state)
    task.spawn(function()
        Settings.Default = state
        while true do
            if not Settings.Default then return end

            ReplicatedStorage.Train.Remote.TrainAnimeHasEnded:FireServer()
            task.wait()
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

LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), game["Workspace"].CurrentCamera.CFrame);
    task.wait()
    VirtualUser:Button2Up(Vector2.new(0,0), game["Workspace"].CurrentCamera.CFrame);
end)
