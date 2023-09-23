local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Buttons = false,
    Collect = false,
    Coins = false,
}

function GetTycoon()
    for _, v in ipairs(Workspace.Tycoon.Tycoons:GetChildren()) do
        if v.Owner.Value == LocalPlayer.Name then
            return v
        end
    end
end

local Tycoon = GetTycoon()

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("BT | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Auto Buttons", {}, function(state)
    task.spawn(function()
        Settings.Buttons = state
        while true do
            if not Settings.Buttons then return end
        
            for _, v in ipairs(Tycoon.Buttons:GetDescendants()) do
                if v:IsA("TouchTransmitter") then
                    local Root = v.Parent.Parent

                    if not Root.Config.Gamepass.Value and Root.Config.Cost.Value <= LocalPlayer.leaderstats.Money.Value then
                        if firetouchinterest then
                            firetouchinterest(v.Parent, LocalPlayer.Character:FindFirstChildOfClass("Part"), 0); task.wait()
                            firetouchinterest(v.Parent, LocalPlayer.Character:FindFirstChildOfClass("Part"), 1)
                        else
                            LocalPlayer.Character:PivotTo(Root:GetPivot()); task.wait(.25)
                        end
                    end
                end
            end

            task.wait(2.5)
        end
    end)
end)

Window:Toggle("Auto Collect", {}, function(state)
    task.spawn(function()
        Settings.Collect = state
        while true do
            if not Settings.Collect then return end
        
            for _, v in ipairs(Tycoon.Collectors:GetDescendants()) do
                if v:IsA("TouchTransmitter") then
                    if firetouchinterest then
                        firetouchinterest(v.Parent, LocalPlayer.Character:FindFirstChildOfClass("Part"), 0)
                        firetouchinterest(v.Parent, LocalPlayer.Character:FindFirstChildOfClass("Part"), 1)
                    else
                        LocalPlayer.Character:PivotTo(v.Parent.Parent:GetPivot()); task.wait(.25)
                    end
                end
            end

            task.wait(1)
        end
    end)
end)

Window:Toggle("Auto UGC Coins", {}, function(state)
    task.spawn(function()
        Settings.Coins = state
        while true do
            if not Settings.Coins then return end
        
            for _, v in ipairs(Workspace.ItemsToCollect:GetChildren()) do
                if v.Transparency == 0 then
                    LocalPlayer.Character:PivotTo(v:GetPivot()); task.wait(.5)
                    fireproximityprompt(v.ProximityPrompt)
                end
            end

            task.wait(5)
        end
    end)
end)

Window:Section("Anti-AFK Enabled.")

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