local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Farm = false,
    Collect = false,
}

function ActivateSword()
    if LocalPlayer.Character:FindFirstChildOfClass("Tool") == nil then
        local Tool = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
        
        if Tool then
            LocalPlayer.Character.Humanoid:EquipTool(Tool)
        else
            return false
        end
    end

    LocalPlayer.Character:FindFirstChildOfClass("Tool"):Activate()
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("LOFE | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Auto Farm Coin", {}, function(state)
    task.spawn(function()
        Settings.Farm = state
        while true do
            if not Settings.Farm then return end

            for _, v in ipairs(Workspace.Map:GetDescendants()) do
                if v:IsA("ImageLabel") and v.Image == "rbxassetid://14192923644" then
                    LocalPlayer.Character:PivotTo(v.Parent.Parent:GetPivot() * CFrame.new(0, 0, 2.5)); task.wait(.25)
                    if not ActivateSword() then break end;
                end
            end

            task.wait(.1)
        end
    end)
end)

Window:Toggle("Auto Collect Coin", {}, function(state)
    task.spawn(function()
        Settings.Collect = state
        while true do
            if not Settings.Collect then return end

            for _, v in ipairs(Workspace:GetChildren()) do
                if v.Name == "Coin" then
                    v:PivotTo(LocalPlayer.Character:GetPivot()); task.wait()
                end
            end

            task.wait(2.5)
        end
    end)
end)

Window:Button("Teleport to End", function()
    task.spawn(function()
        LocalPlayer.Character:PivotTo(Workspace.UGC.Restart:GetPivot());
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