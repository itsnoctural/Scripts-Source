local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Hash = false,
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("UW | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Auto Hash", {}, function(state)
    task.spawn(function()
        Settings.Hash = state
        while true do
            if not Settings.Hash then return end

            for _, v in ipairs(Workspace["Hash Holding"]:GetChildren()) do
                LocalPlayer.Character:PivotTo(v:GetPivot()); task.wait()
            end

            task.wait(.1)
        end
    end)
end)

Window:Section("There cooldown for hash")
Window:Section("so just wait few minutes!")

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