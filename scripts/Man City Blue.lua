local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("MCBM | EsohaSL")

Window:Section("esohasl.net")

Window:Button("Teleport to Dragon", function()
    task.spawn(function()
        local Dragon = Workspace.Scriptables.NPCs:FindFirstChild("Dragon")

        if Dragon then
            LocalPlayer.Character:PivotTo(Dragon:GetPivot())
        else
            LocalPlayer.Character:PivotTo(CFrame.new(485, 21.5, 51))
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