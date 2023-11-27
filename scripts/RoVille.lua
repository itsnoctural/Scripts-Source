local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Pizza = false,
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("RoVil | EsohaSL")

Window:Section("esohasl.com")

Window:Button("Join Pizza Event", function()
    task.spawn(function()
        ReplicatedStorage.TMNTEvents.PromptStartMinigame:FireServer()
    end)
 end)

Window:Toggle("Auto Collect Pizza", {}, function(state)
    task.spawn(function()
        Settings.Pizza = state
        while true do
            if not Settings.Pizza then return end

            for _, v in ipairs(Workspace.TMNTPizzas:GetChildren()) do
                LocalPlayer.Character:PivotTo(v:GetPivot()); task.wait();
            end

            task.wait(.5)
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