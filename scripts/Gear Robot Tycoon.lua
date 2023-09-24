local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Collect = false,
    Buttons = false,
}

function GetTycoon()
    for _, v in ipairs(Workspace["Tycoons_Main"].Tycoons:GetChildren()) do
        if v.Owner.Value == LocalPlayer then
            return v
        end
    end
end

function FireButton(part)
    if firetouchinterest then 
        firetouchinterest(part, LocalPlayer.Character:FindFirstChildOfClass("Part"), 0);
        firetouchinterest(part, LocalPlayer.Character:FindFirstChildOfClass("Part"), 1);
    else
        LocalPlayer.Character:PivotTo(part:GetPivot());
    end
end

local Tycoon = GetTycoon()

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("GRT | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Auto Collect", {}, function(state)
    task.spawn(function()
        Settings.Collect = state
        while true do
            if not Settings.Collect then return end

            FireButton(Tycoon.Essentials.Giver)
            task.wait(1)
        end
    end)
end)

Window:Toggle("Auto Buttons", {}, function(state)
    task.spawn(function()
        Settings.Buttons = state
        while true do
            if not Settings.Buttons then return end

            for _, v in ipairs(Tycoon.Buttons:GetChildren()) do
                if v:FindFirstChild("Head") and v.Head.Transparency == 0 then
                    FireButton(v.Head)
                end
            end

            task.wait(2.5)
        end
    end)
end)

Window:Section("Anti-AFK Enabled")

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