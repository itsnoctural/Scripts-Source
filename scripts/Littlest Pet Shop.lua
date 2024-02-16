local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Play = false,
}

local function GetKnit()
    for _,v in ipairs(ReplicatedStorage.Packages._Index:GetChildren()) do
        local knit = v:FindFirstChild("knit")

        if knit then
            return knit;
        end
    end

    return false
end

local function GetPlayerPets()
    local Pets = {}

    for _,v in ipairs(Workspace:GetChildren()) do
        if v:IsA("Model") and v:GetAttribute("Owner") == LocalPlayer.Name then
            table.insert(Pets, v:GetAttribute("GUID"));
        end
    end

    return Pets
end

local function GetNearestActivity()
    local Activity = nil
    local StartDist = 100

    for _, v in ipairs(Workspace.Activities:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("RootPart") then
            local Distance = LocalPlayer:DistanceFromCharacter(v:GetPivot().Position)
        
            if Distance < StartDist then
                StartDist = Distance
                Activity = v
            end
        end
    end

    return Activity
end

task.spawn(function()
    while task.wait(10) do
        Settings.Exclude = {}
    end
end)

local Knit = GetKnit()

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("LTP | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Play", {}, function(state)
    task.spawn(function()
        Settings.Play = state
        while true do
            if not Settings.Play then return end

            for _,v in ipairs(GetPlayerPets()) do
                Knit.Services.PetService.RF.AddPetToActivity:InvokeServer(v, GetNearestActivity()); task.wait(.1)
            end
            
            task.wait(5)
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