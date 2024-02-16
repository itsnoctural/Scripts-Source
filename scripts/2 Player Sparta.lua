local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Buttons = false,
    Collect = false,
    NPCs = false,
}

local function FireTouchTransmitter(touchParent)
    local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")

    if Character then
        firetouchinterest(touchParent, Character, 0)
        firetouchinterest(touchParent, Character, 1)
    end
end

local function GetTycoon()
    local Tycoon = nil

    for _, v in ipairs(Workspace.GeneralPurposeTycoonKit.Tycoons:GetDescendants()) do
        if v.Name == "Owner" and v.Value == LocalPlayer.Name then
            Tycoon = v.Parent.Parent.Parent
        end
    end

    return Tycoon
end

local Tycoon = GetTycoon()

if not Tycoon then
    task.spawn(function()
        while task.wait(2.5) do
            if not Tycoon then
                Tycoon = GetTycoon()
            else return end
        end
    end)
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("2PST | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Buttons", {}, function(state)
    task.spawn(function()
        Settings.Buttons = state
        while true do
            if not Settings.Buttons then return end

            for _,v in ipairs(LocalPlayer.NextButtons:GetChildren()) do
                if v.Value then
                    local Configuration = v.Value:FindFirstChild("Configuration")

                    if Configuration then
                        local Price = Configuration:FindFirstChild("Price")
                        local TouchToBuy = v.Value:FindFirstChild("TouchToBuy")

                        if Price and TouchToBuy then
                            if Price.Value <= LocalPlayer.Values.Cash.Value then
                                FireTouchTransmitter(TouchToBuy); task.wait()
                            end
                        end
                    end
                end
            end

            task.wait(1)
        end
    end)
end)

Window:Toggle("Auto Collect", {}, function(state)
    task.spawn(function()
        Settings.Collect = state
        while true do
            if not Settings.Collect then return end

            if Tycoon then
                for _,v in ipairs(Tycoon.Default:GetDescendants()) do
                    if v.Name == "Collector" then
                        FireTouchTransmitter(v); task.wait()
                    end
                end
            end

            task.wait(1)
        end
    end)
end)

Window:Section("\"Dory\" should be equipped")

Window:Toggle("Auto Kill NPCs", {}, function(state)
    task.spawn(function()
        Settings.NPCs = state
        while true do
            if not Settings.NPCs then return end

            local FightArena = Workspace.FightArenas:FindFirstChild(LocalPlayer.Name)

            if FightArena then                
                local Dory = FightArena:FindFirstChild("Dory")

                if Dory then
                    local Helmet = Dory:FindFirstChildOfClass("MeshPart")

                    if Helmet then
                        FireTouchTransmitter(Helmet);
                    end
                end

                for _, v in ipairs(FightArena.NPCs:GetChildren()) do
                    while Settings.NPCs and v and v.Parent and task.wait() do
                        LocalPlayer.Character:PivotTo(v:GetPivot() + Vector3.new(0, -10, 0));
                        ReplicatedStorage.Tool.Attack:FireServer(v, "Dory");
                    end
                end
            else task.wait(1) end

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

LocalPlayer.Idled:connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
    task.wait()
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
end)