local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local CR = LocalPlayer.PlayerScripts:FindFirstChild("ClientRuntime")
local AC = LocalPlayer.PlayerScripts.Controllers:FindFirstChild("AntiCheatClient")

if CR then CR:Destroy() end
if AC then AC:Destroy() end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("MR | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Fast Ball", {}, function(state)
    task.spawn(function()
        Workspace.Gravity = state and 1000 or 196
    end)
end)

Window:Toggle("Can Collide", {}, function(state)
    task.spawn(function()
        Workspace.Marbles[LocalPlayer.UserId].CanCollide = state
    end)
end)

Window:Button("YouTube: EsohaSL", function()
    task.spawn(function()
        if setclipboard then
            setclipboard("https://youtube.com/@esohasl")
        end
    end)
end)